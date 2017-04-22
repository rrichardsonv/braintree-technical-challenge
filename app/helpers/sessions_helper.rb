module SessionsHelper
  def logged_in
    session[:customer_id] != nil
  end

  def log_in(customer)
    session[:customer_id] = customer.id
  end

  def current_customer
   @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def log_out
    session[:customer_id] = nil
    session[:cart] = nil
  end

  def add_to_cart(type, id)
    session[:cart] = {type: type, item_id: id}
  end
end