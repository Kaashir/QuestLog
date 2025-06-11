class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :user_question
      t.text :ai_answer
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
