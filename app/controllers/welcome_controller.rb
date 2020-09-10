class WelcomeController < ApplicationController
  def index
    consumer = OAuth::Consumer.new(ENV['GOODREADS_API_KEY'],
                                   ENV['GOODREADS_API_SECRET'],
                                   :site => 'https://www.goodreads.com')
    request_token = consumer.get_request_token
    @authorize_url = request_token.authorize_url
  end
end
