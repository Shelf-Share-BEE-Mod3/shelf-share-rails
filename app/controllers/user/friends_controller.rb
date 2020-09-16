# frozen_string_literal: true

class User::FriendsController < ApplicationController
  def index; end

  def show
    @friend = User.find(params[:id])
  end
end
