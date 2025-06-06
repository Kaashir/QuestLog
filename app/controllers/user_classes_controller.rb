class UserClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_class, only: [:show, :edit, :update]

  def refresh_level
    @user_class = current_user.user_classes.first
    render partial: "shared/level_xp", locals: { user_class: @user_class }
  end

  def show
    @all_class_types = HeroClass.all
    @user_class_types = HeroClass.where(id: current_user.user_classes.pluck(:hero_class_id))
    @available_class_types = @all_class_types - @user_class_types

    @current_user_classes = current_user.user_classes
    @current_user_active_class = current_user.user_classes.find_by(active: true)
    @user_class = UserClass.new
    @user_class.user = current_user
  end

  def new
  end

  def create
    current_user.user_classes.update_all(active: false)
    @user_class = UserClass.new(user_class_params)
    @user_class.user = current_user
    @user_class.active = true
    if @user_class.save
      redirect_to user_class_path(@user_class)
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:user_class).permit(:xp, :level, :active)
  end
end
