class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: [:edit, :update, :destroy]

  def new
    @quest = Quest.new
    @quest_categories = QuestCategory.where(class_type: current_user.user_classes.first.class_type)
  end

  def create
    @quest = Quest.new(quest_params)
    @quest.user_created = true
    @current_user_class = current_user.user_classes.first
    @quest_categories = QuestCategory.where(class_type: @current_user.user_classes.first.class_type)
    if @quest.save
      # Create a UserQuest for the current user
      UserQuest.create(user: current_user, quest: @quest, completed: false, completed_frequency: 0)
      redirect_to user_quests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to user_quests_path, notice: 'Quest was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quest.destroy
    redirect_to quests_path, notice: 'Quest was successfully destroyed.'
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :description, :frequency, :quest_category_id)
  end
end
