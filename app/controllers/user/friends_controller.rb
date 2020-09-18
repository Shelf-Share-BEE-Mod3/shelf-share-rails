# frozen_string_literal: true

class User::FriendsController < ApplicationController
  def index
    @friend_requests = BorrowRequestFacade.find_current_friend_requests(current_user)
  end

  def show
    @friend = User.find(params[:id])
  end
end
