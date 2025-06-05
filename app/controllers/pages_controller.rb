class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home] # Skip authentication for the home action
  # This allows the home page to be accessible without requiring a user to be logged in.

  layout 'devise', only: [:home, :choose_class]

  def home
  end
end
