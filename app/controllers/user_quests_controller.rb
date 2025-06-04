class UserQuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_quest, only: [:show, :update, :destroy]

  def index
    @user_quests = UserQuest.all
  end

  def show
  end

  def create
    @user_quest = UserQuest.new(user_quest_params)
    @user_quest.user_id = current_user.id

    if @user_quest.save
      redirect_to user_quests_path, notice: 'Quest was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user_quest.update(user_quest_params)
      redirect_to user_quests_path, notice: 'Quest was successfully updated.'
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
    params.require(:user_quest).permit(:quest_id, :user_id, :completed)
  end

  def set_user_quest
    @user_quest = UserQuest.find(params[:id])
  end
  
  flash.now[:xp_updated] = true
end
