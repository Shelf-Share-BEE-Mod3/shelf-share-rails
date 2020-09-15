class Books::SearchController < ApplicationController
  def index
    @books = SearchFacade.search(params[:search])
  end
end
