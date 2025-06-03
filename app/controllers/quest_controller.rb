class QuestController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: [:show, :edit, :update, :destroy]

  def index
    @quests = Quest.all
  end

  def show
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      redirect_to quests_path, notice: 'Quest was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to quests_path, notice: 'Quest was successfully updated.'
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
    params.require(:quest).permit(:title, :description, :category, :frequency)
  end
end
