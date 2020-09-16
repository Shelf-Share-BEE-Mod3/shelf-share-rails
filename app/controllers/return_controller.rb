class ReturnController < ApplicationController

  def index
    @borrow_requests = current_user.borrow_requests.find_approved_requests
  end

  def show
    @friend = User.find(params[:id])
  end
end
