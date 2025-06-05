# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'devise'

  protected

  def after_sign_in_path_for(resource)
    root_path(just_logged_in: true)
  end
end
