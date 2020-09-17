# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.update_or_create(request.env['omniauth.auth'])
    session[:id] = user.id
    flash[:success] = "Welcome #{user.full_name}!"
    if user.address.nil?
      redirect_to '/address/prompt'
    else
      redirect_to user_dashboard_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
