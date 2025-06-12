class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :choose_class] # Skip authentication for the home and choose_class actions
  # This allows the home page and class selection to be accessible without requiring a user to be logged in.

  layout 'devise', only: [:home, :choose_class]

  def home
  end

  def choose_class
  end

  def friends_list
  end

  def add_friend
    @friend = User.find_by(username: params[:friendship][:username].downcase)
    if @friend && current_user.add_friend(@friend)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.append(:friends_list, partial: "shared/friend_bar", locals: { friend: @friend })
        end
        format.html { redirect_to friends_list_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:friends_list, partial: "shared/error_alert")
        end
        format.html { redirect_to friends_list_path }
      end
    end
  end

  def remove_friend
    @friend = User.find_by(username: params[:format].downcase)
    current_user.remove_friend(@friend)
    redirect_to friends_list_path
  end

  def rewards
    @current_user_class = current_user.current_class.hero_class.name
  end

  private

  def friend_params
    params.require(:friendship).permit(:username)
  end
end
