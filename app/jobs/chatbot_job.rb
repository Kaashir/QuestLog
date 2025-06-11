class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question }
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions.order(:created_at)
    results = []

    # SYSTEM INSTRUCTION FOR OPENAI
    system_text = "You are a kind and helpful fairy guide in a magical self-improvement world." \
                  "Speak like a kind, whimsical fairy—warm, playful, and a little magical, as if guiding the user through an enchanted world." \
                  "Adventurers (users) complete quests to grow stronger." \
                  "Users may refer to quests also when they mean user quests. " \
                  "Don't answer with referring to ids, only use names and descriptions. " \
                  "Don't distiniguish between quests and user quests when you talk to the user. " \
                  "Users may ask you questions about quests, classes (either their own classes, i.e. user classes or all classes available, i.e. hero classes), or how the app works. " \
                  "Do not make anything up, only use the information you have about quests, user quests, classes and hero classes. " \
                  "If you don't know the answer, say that you don't know. " \
                  "Give concise and clear answers. " \
                  "Here are the quests you can refer to: "

    # Include relevant quests
    nearest_quests.each do |quest|
      system_text += "** Quest: #{quest.title}. Description: #{quest.description}. xp granted: #{quest.xp_granted}. " \
                     "Category: #{quest.quest_category.name} ** "
    end

    system_text += "Here are the user quests you can refer to: "

    nearest_user_quests.each do |userquest|
      system_text += "** Quest: #{userquest.quest.title}. Description: #{userquest.quest.description}. xp granted: #{userquest.quest.xp_granted}" \
                     "Hero class: #{userquest.quest.quest_category.hero_class.name}. " \
                     "User class: #{userquest.user.current_class.hero_class.name}. **"
    end

    # Add user's current stats
    current_user_class = @question.user.current_class
    if current_user_class
      system_text += "Current user stats: " \
                     "Class: #{current_user_class.hero_class.name}, " \
                     "Level: #{current_user_class.level}, " \
                     "Current XP: #{current_user_class.xp}, " \
                     "XP needed for next level: #{current_user_class.xp_needed_for_next_level}. "

      # Add available quests for the user's class (for XP optimization advice)
      available_quests = available_quests_for_user_class(current_user_class)
      if available_quests.any?
        system_text += "Available quests for your #{current_user_class.hero_class.name} class that you haven't taken yet: "
        available_quests.each do |quest|
          system_text += "** #{quest.title}: #{quest.description}. XP: #{quest.xp_granted}. Category: #{quest.quest_category.name}. ** "
        end
      end
    end

    available_classes = available_classes_for_user(@question.user)
    if available_classes.any?
      system_text += "Available classes for your user: "
      available_classes.each do |hero_class|
        system_text += "** Class: #{hero_class.name}, " \
                       "Description: #{hero_class.description}"
      end
    end

    # Add information about quests for classes that the user does not have
    system_text += "Here are quests for all classes that you can refer to: "
    system_text += availabe_quests_for_all_classes.map do |quest|
      "Quest: #{quest.title}. Description: #{quest.description}. xp granted: #{quest.xp_granted}. " \
      "Category: #{quest.quest_category.name} "
    end.join(" ** ")

    # Add information about quests for a specific class
    system_text += "Here are quests for a specific class that you can refer to: "
    HeroClass.all.each do |klass|
      system_text += "For class #{klass.name}: "
      available_quests = available_quests_for_class(klass)
      if available_quests.any?
        system_text += available_quests.map do |quest|
          "Quest: #{quest.title}. Description: #{quest.description}. xp granted: #{quest.xp_granted}. " \
          "Category: #{quest.quest_category.name} "
        end.join(" ** ")
      else
        system_text += "No quests available for this class. "
      end
    end

    # Add information about how the app works
    instruction_file = Rails.root.join("app/data/helper_instructions.txt")
    system_text += "Here are some instructions on how the app works: "
    system_text += File.read(instruction_file)

    results << { role: "system", content: system_text }

    # ONLY show welcome message if it's the first time
    if questions.empty?
      results << {
        role: "assistant",
        content: "Hi there! 👋 I'm your personal quest guide.\n\nHere’s what I can help you with:\n" \
                 "- Understand what a quest means\n" \
                 "- Pick your next quest\n" \
                 "- Answer any questions about how this app works\n\nJust type a question to begin!"
      }
    end

    # PAST MESSAGES
    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    results
  end

  def nearest_quests
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']

    Quest.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    )
  end

  def nearest_user_quests
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']

    UserQuest.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    )
  end

  def available_quests_for_user_class(user_class)
    user = @question.user
    taken_quest_ids = user.user_quests.pluck(:quest_id) # to avoid suggesting quests that the user has already taken

    Quest.joins(:quest_category)
         .where(quest_category: { hero_class: user_class.hero_class })
         .where.not(id: taken_quest_ids)
         .where(user_created: false) # so that it doesnt suggest user created qests
         .order(xp_granted: :desc)
         .limit(10) # optional, but good for performance
  end

  def available_classes_for_user(user)
    HeroClass.all.reject do |hero_class|
      user.user_classes.exists?(hero_class: hero_class)
    end
  end

  def availabe_quests_for_all_classes
    Quest.joins(:quest_category)
          .where(quest_category: { hero_class: HeroClass.all })
          .where(user_created: false) # so that it doesnt suggest user created quests
          .order(xp_granted: :desc)
  end

  def available_quests_for_class(klass)
    Quest.joins(:quest_category)
         .where(quest_category: { hero_class: klass })
         .where(user_created: false) # so that it doesnt suggest user created quests
         .order(xp_granted: :desc)
  end

  # def information_about_app_functionality

  # end
end
