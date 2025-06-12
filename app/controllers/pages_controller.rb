class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :choose_class] # Skip authentication for the home and choose_class actions
  # This allows the home page and class selection to be accessible without requiring a user to be logged in.

  layout 'devise', only: [:home, :choose_class]

  def home
  end

  def choose_class
  end

  def rewards
    @current_user_class = current_user.current_class.hero_class.name
  end

end
