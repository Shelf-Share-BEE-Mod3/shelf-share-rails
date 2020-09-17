# frozen_string_literal: true

class AddressesController < ApplicationController # rubocop:todo Style/Documentation
  def new
    @address = Address.new(session.delete(:address_params))
  end

  def show
    @borrower = Address.find(params[:id]).user
  end

  def create # rubocop:todo Metrics/AbcSize
    user = User.find(current_user.id)
    @address = Address.create(address_params)
    @address.user_id = user.id
    if @address.save
      flash[:success] = 'Address successfully saved'
      redirect_to user_dashboard_path
    else
      flash[:failure] = 'Please fill out all required fields'
      flash[:error] = @address.errors.full_messages.to_sentence
      session[:address_params] = address_params
      redirect_to request.referrer
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    if current_user.address.update(address_params)
      flash[:success] = 'Address updated successfully'
      redirect_to user_account_path
    else
      flash[:failure] = 'Please fill out all required fields'
      flash[:error] = address.errors.full_messages.to_sentence
      session[:params] = address_params
      render :edit
    end

  end

  private

  def address_params
    params.permit(:address_first, :address_second, :city, :state, :zip)
  end
end
