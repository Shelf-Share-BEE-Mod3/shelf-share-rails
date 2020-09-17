class Books::SearchController < ApplicationController
  def index
    @books = SearchFacade.search(params[:search], current_user.id)
    @keyword = params[:keyword]
  end
end
