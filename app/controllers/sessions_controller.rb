class SessionsController < ApplicationController
  include SessionsHelper, CheckoutsHelper
  def new
    add_to_cart(params[:type],params[:item_id])
    @customer = Customer.new
  end

  def create
    @customer = Customer.find_by(email: customer_params[:email])
    if @customer && @customer.authenticate(customer_params[:password])
      log_in(@customer)
      flash[:notice] = "Login Successful!"
      redirect_to checkout_cart
    else
      flash[:alert] = "Login failed"
      redirect_to new_session_path
    end
  end

  def destroy
    flash[:notice] = "Thanks for stopping by!"
    log_out
    redirect_to root_path
  end

  private
  def customer_params
      params.require(:session).permit(:email, :password)
  end
end