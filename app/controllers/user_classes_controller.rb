class UserClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_class, only: [:show, :edit, :update]

  def refresh_level
    @user_class = current_user.user_classes.first
    render partial: "shared/level_xp", locals: { user_class: @user_class }
  end

  def add_xp
    @user_class = current_user.user_classes.first
    @user_class.add_xp_to_user_class
    redirect_to user_quests_path
  end

  def show
    @user_classes = current_user.user_classes
    @current_user_class = current_user.user_classes.find_by(active: true)
    @quests = Quest.where(class_type: @user_class.class_type)
  end

  def edit
  end

  def update
  end

  private
  def set_user_class
    @user_class = UserClass.find_by(user: current_user, active: true)
  end

  def user_class_params
    params.require(:user_class).permit(:xp, :level, :class_type, :active)
  end
end

