# frozen_string_literal: true

class AddressesController < ApplicationController # rubocop:todo Style/Documentation
  def new
    @address = Address.new(session.delete(:address_params))
  end

  def create # rubocop:todo Metrics/AbcSize
    user = User.find(current_user.id)
    @address = Address.create(address_params)
    @address.user_id = user.id
    if @address.save
      flash[:success] = 'Address successfully saved'
      redirect_to root_path
    else
      flash[:failure] = 'Please fill out all required fields'
      flash[:error] = @address.errors.full_messages.to_sentence
      session[:params] = address_params
      render :new
    end
  end

  private

  def address_params
    params.permit(:address_first, :address_second, :city, :state, :zip)
  end
end
