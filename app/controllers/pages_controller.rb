class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home] # Skip authentication for the home action
  # This allows the home page to be accessible without requiring a user to be logged in.

  def home
  end
end
