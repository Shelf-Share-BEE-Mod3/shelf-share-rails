class User::FriendRequestsController < ApplicationController
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

  def update
    request = FriendRequest.find(params[:id])
    friend = User.find(request.from)
    Friendship.create_reciprocal_for_ids(request.user_id, request.from)
    request.update(status: 1)
    flash[:success] = "Now friends with #{friend.first_name}"
    redirect_to user_friends_path
  end

  def destroy
    FriendRequest.delete(params[:id])
    redirect_to user_friends_path
  end

  def friends_params
    params.permit(:email)
  end
end
