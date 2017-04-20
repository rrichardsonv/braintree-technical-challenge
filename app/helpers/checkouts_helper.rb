module CheckoutsHelper
  def show_amount_cents(cost)
    str_cost = cost.to_s
    if !!(/^\d*$/ =~ str_cost) #nil on no cents
      str_cost = [str_cost, '00'].join('.')
    elsif !!(/\.[0-9]$/ =~ str_cost) #nil on only tenths
      str_cost = [str_cost, '0'].join('')
    else
      str_cost
    end
  end

  def self.bt_form_fields(options={})
    if options.fetch(:hostedFields, false)
      braintree_options = {}
      CHECKOUT_FIELDS.each do |f|
        braintree_options.store(
          f.fetch(:type, f[:name]), {
            selector: ['#',f[:name]].join('')
          }
        )
      end
      braintree_options.to_json.html_safe
    else
      CHECKOUT_FIELDS
    end
  end

  protected
  CHECKOUT_FIELDS = [{
      type: 'number',
      name: 'card-number',
      display: 'Card Number'
    }, {
      type: 'expirationDate',
      name: 'expiration-date',
      display: 'Exp. date'
    }, {
      name: 'cvv',
      display: 'CVV'
    }, {
      type: 'postalCode',
      name: 'zip',
      display: 'Billing Zipcode'
  }]
end