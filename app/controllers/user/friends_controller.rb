class User::FriendsController < ApplicationController
  def index; end

  def create
    friend = User.find_by(email: friends_params[:email])
    if friend.nil?
      flash[:error] = 'No users with that email'
      redirect_to user_friends_path
    else
      friend.friend_requests.create(from: current_user.id)
      flash[:success] = "Friend Request sent to #{friend.first_name}"
      redirect_to user_friends_path
    end
  end

  private

  def friends_params
    params.permit(:email)
  end
end
