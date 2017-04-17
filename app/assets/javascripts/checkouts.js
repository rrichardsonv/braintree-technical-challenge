var startAmountListener = function(){
  const price = parseFloat($('#total')[0].innerText)
  $('#payment-section').change('input#amount', function(e){
    var total = parseInt(e.target.value) * price;
    $('h3#total')[0].innerHTML = total
  })
};

var getBrainTreeForm = function (client_token) {
    var checkout = new DropIn({
      formID: 'braintree-payment-form'
    })

    braintree.setup(client_token, "dropin", {
      container: "bt-dropin"
    })
};

var ready = function(config){
  getBrainTreeForm(config.client_token)
  startAmountListener()
};

var checkoutsWillEnter = function(config) {
  $('document').ready(ready(config)) || $('document').on('turbolinks:load', ready(config))
}

