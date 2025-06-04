class UserClassesController < ApplicationController
  before_action :authenticate_user!

  def refresh_level
    @user_class = current_user.user_classes.first
    render partial: "shared/level_xp", locals: { user_class: @user_class }
  end
end