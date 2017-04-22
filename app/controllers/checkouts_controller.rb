class CheckoutsController < ApplicationController
  include CheckoutsHelper, SessionsHelper

  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
    customer = current_customer
    if !!customer.cards
      @card = customer.cards.last
    end
    @fields = CheckoutsHelper.bt_form_fields
    @product = _get_purchase_product
    @client_token = Braintree::ClientToken.generate
  end

  def show
    @product = _get_purchase_product
    @transaction = Braintree::Transaction.find(params[:id])
    @result = _create_result_hash(@transaction)
  end

  def create
    customer = current_customer
    checkout = params[:checkout]
    product = _get_purchase_product
    amount = checkout[:amount].to_i
    nonce = params[:payment_method_nonce]
    save = checkout[:save] === 'on'
    purchase_amount = '%.2f' % (amount * product.price_per_lb)

    result = Braintree::Transaction.sale(
      amount: purchase_amount,
      payment_method_nonce: nonce,
      :customer_id => customer.bt_id,
      :options => {
        :submit_for_settlement => true,
        :store_in_vault_on_success => save
      }
    )
    if save && ( result.success? || result.transaction )
      card = result.transaction.credit_card_details
      customer.cards.new({token: card.token, last_4: card.last_4})
      if customer.save
        flash[:error] = 'Save unsuccessful.'
      else
        flash[:notice] = 'Card save successful.'
      end
    end 
    _checkout_redirect(result, product)
  end

  def _checkout_redirect(result, product)
    if result.success? || result.transaction
      case product.model_name.name
      when 'Fruit'
        redirect_to fruit_checkout_path(product.id, result.transaction.id)
      else
        flash[:error] = 'Something went wrong, please contact us.'
        redirect_to root_path
      end
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages

      case product.model_name.name
      when 'Fruit'
        redirect_to new_fruit_checkout_path(product.id)
      else
        redirect_to root_path
      end
    end
  end
  def _create_result_hash(transaction)
    t = transaction.credit_card_details
    status = transaction.status
    reciept = [
      "TransactionID: #{transaction.id}",
      "Date: #{transaction.created_at}",
      "Amount: $#{show_amount_cents(transaction.amount)}"
    ]
      
    if t.card_type != nil
      reciept.push("Payment Method: #{t.card_type} ending in #{t.last_4}")
    end
    
    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        :header => "Sweet Success!",
        :icon => "success_grape",
        :message => "Thanks a bunch! Everything went GRAPE!",
        :reciept => reciept
      }
    else
      result_hash = {
        :header => "Transaction Failed",
        :icon => "fail_pear",
        :message => "It ap-PEAR-s something went wrong"
      }
    end
  end
  
  def _get_purchase_product
    model = params["product"].constantize
    product_key = params["product"].foreign_key
    model.find_by(id: params[product_key])
  end
end