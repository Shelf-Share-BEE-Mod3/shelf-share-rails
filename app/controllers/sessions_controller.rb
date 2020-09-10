class SessionsController < ApplicationController
  def create
    # response = Faraday.get 'https://www.goodreads.com/api/auth_user'
    # this is the endpoint for where we can get an authorized user id

    # create a user in the db if they don't exist
    # if they do exist, cool
    # success, params[:authorize] == "1"
    # update their oauth token, that we get from params[:oauth_token]
    # store their user_id in the session[:user_id]

    # session[:user_id] lets us make
    # def current_user
    #   @current_user ||= User.find(session[:user_id])
    # end
  end
end
