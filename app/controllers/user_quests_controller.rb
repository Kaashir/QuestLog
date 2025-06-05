class UserQuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_quest, only: [:show, :update, :destroy]

  def index
    @current_user_quests = current_user.user_quests.where(completed: false)
    @current_user_class = current_user.user_classes.where(active: true)
    # @current_user_class = current_user.user_classes.find_by(id: session[:current_user_class_id]) || current_user.user_classes.first
  end

  def show
  end

  def new
    @user_quest = UserQuest.new
    @current_user_class = current_user.user_classes.where(active: true)
    # @current_user_class = current_user.user_classes.find_by(id: session[:current_user_class_id]) || current_user.user_classes.first
    @quests = Quest.quest_class(@current_user_class.first.class_type).where(user_created: false)
  end

  def create
    @user_quest = UserQuest.new(user_quest_params)
    @user_quest.user = current_user
    @user_quest.save
    redirect_to user_quests_path
  end

  def update
    if @user_quest.update(user_quest_params)
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

  def user_quest_frequency_params
    params.permit(:completed_frequency, :completed)
  end

  def set_user_quest
    @user_quest = UserQuest.find(params[:id])
  end
end
