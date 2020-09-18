# frozen_string_literal: true

class User::FriendsController < ApplicationController
  def index
    @friends = current_user.friends.includes(:books)
  end

  def show
    @friend = User.find(params[:id])
  end
end
