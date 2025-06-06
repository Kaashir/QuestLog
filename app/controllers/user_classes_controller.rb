class UserClassesController < ApplicationController
  before_action :authenticate_user!

  def refresh_level
    @user_class = current_user.user_classes.first
    render partial: "shared/level_xp", locals: { user_class: @user_class }
  end

  def add_xp
    @user_class = current_user.user_classes.first
    @user_class.add_xp_to_user_class
    redirect_to user_quests_path
  end
end