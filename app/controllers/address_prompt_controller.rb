class AddressPromptController < ApplicationController
  def new
    @address = Address.new(session.delete(:address_params))
  end

  def create
    user = User.find(current_user.id)
    @address = Address.create(address_params)
    @address.user_id = user.id
    if @address.save
      flash[:success] = 'Address successfully saved'
      redirect_to user_dashboard_path
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
