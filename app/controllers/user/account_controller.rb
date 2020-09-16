class User::AccountController < ApplicationController
  def show
    @address = current_user.address
  end
end
