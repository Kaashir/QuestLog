class FriendsController < ApplicationController
  def profile
    @friend = User.find(params[:id])
    render partial: 'shared/friend_profile_modal_content'
  end
end
