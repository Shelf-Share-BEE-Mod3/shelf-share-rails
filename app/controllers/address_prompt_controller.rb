class AddressPromptController < ApplicationController
  def new
    @address = Address.new(session.delete(:address_params))
  end
end
