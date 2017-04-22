class CustomersController < ApplicationController
  include CheckoutsHelper, SessionsHelper
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = 'Account creation successful!'
      log_in(@customer)
      redirect_to checkout_cart
    else
      flash[:alert] = 'Account creation failed'
      redirect_to new_customer_path
    end
  end
  
  private
  def customer_params
      params.require(:customer).permit(:username, :email, :password)
  end
end
