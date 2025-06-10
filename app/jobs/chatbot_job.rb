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
      partial: "questions/question", locals: { question: question })
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions.order(:created_at)
    results = []

    # SYSTEM INSTRUCTION FOR OPENAI
    system_text = "You are an assistant in a gamified self-improvement app. " \
                  "Users can complete quests to improve themselves. " \
                  "Users may refer to quests also when they mean user quests. " \
                  "Don't answer with referring to ids, only use names and descriptions. " \
                  "Don't distiniguish between quests and user quests when you talk to the user. " \
                  "Users may ask you questions about quests, classes (either their own classes, i.e. user classes or all classes available, i.e. hero classes), or how the app works. " \
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
               "User class: #{userquest.user.user_class.name}. **"
    end

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
    ).first(5) # adjust number of suggestions as needed
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
    ).first(5) # adjust number of suggestions as needed
  end
end
