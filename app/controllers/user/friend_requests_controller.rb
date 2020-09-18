# frozen_string_literal: true

class User::FriendRequestsController < ApplicationController
  def create
    friend = User.find_by(email: friends_params[:email])
    if friend.nil?
      flash[:error] = 'No users with that email'
      redirect_to user_friends_path and return
    end
    request = friend.friend_requests.create(from: current_user.id)
    if request.save
      flash[:success] = "Friend Request sent to #{friend.first_name}"
    else
      flash[:failure] = "Friend Request Could not be sent"
      flash[:error] = request.errors.full_messages.to_sentence
    end
    redirect_to user_friends_path
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
    FriendRequest.update(params[:id], status: 2)
    redirect_to user_friends_path
  end

  def friends_params
    params.permit(:email)
  end
end
