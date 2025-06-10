class UserQuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_quest, only: [:edit, :update, :destroy]

  def index
    @current_user_quests = UserQuest.quest_by_class(current_user.current_class.hero_class.name, current_user).order(completed: :desc, position: :asc)
    @current_user_class = current_user.user_classes.where(active: true)
  end

  def new
    @user_quest = UserQuest.new
    @current_user_class = current_user.current_class
    existing_quest_ids = current_user.user_quests.pluck(:quest_id)
    @quests = Quest.where(quest_category: @current_user_class.hero_class.quest_categories)
                   .where(user_created: false)
                   .where.not(id: existing_quest_ids)
  end

  def create
    @user_quest = UserQuest.new(user_quest_params)
    @user_quest.user = current_user
    @user_quest.save
    redirect_to user_quests_path
  end

  def edit
  end

  def update
    @current_user_class = current_user.user_classes.where(active: true)
    if @user_quest.update(user_quest_params)
      @current_user_class.first.increment!(:xp, @user_quest.quest.xp_granted) if @user_quest.completed
      @current_user_class.first.save
      redirect_to user_quests_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_quest.destroy
    redirect_to user_quests_path, notice: 'Quest was successfully deleted.'
  end

  private

  def user_quest_params
    params.require(:user_quest).permit(:quest_id, :user_id, :completed, :completed_frequency)
  end

  def set_user_quest
    @user_quest = UserQuest.find(params[:id])
  end
end
