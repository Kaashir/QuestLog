class RemoveUserClassIdFromHeroClasses < ActiveRecord::Migration[7.1]
  def change
    remove_column :hero_classes, :user_class_id, :bigint
  end
end
