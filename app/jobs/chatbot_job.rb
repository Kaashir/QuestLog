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
                  "Always refer to the quest by name. If you're unsure about the answer, say 'I'm not sure about that.' " \
                  "If there are no relevant quests, say 'We don't have a quest for that right now.' " \
                  "Here are the quests you can refer to: "

    # Include relevant quests
    nearest_quests.each do |quest|
      system_text += "** QUEST #{quest.id}: name: #{quest.name}, description: #{quest.description} ** "
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
    ).first(2) # adjust number of suggestions as needed
  end
end
