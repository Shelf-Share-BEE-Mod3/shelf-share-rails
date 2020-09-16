class Books::SearchController < ApplicationController
  def index
    @books = SearchFacade.search(params[:search])
    @keyword = params[:keyword]
  end
end
