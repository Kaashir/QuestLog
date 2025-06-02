class CreateUserClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_classes do |t|
      t.integer :xp
      t.integer :level
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
