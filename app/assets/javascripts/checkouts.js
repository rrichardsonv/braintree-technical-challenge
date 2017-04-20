//------Utility functions
//for maintaining floats with 2 decimals
var roundToNearestCent = function(num){
  var strTotal = (Math.round( num * 100 + Number.EPSILON ) / 100).toString()
  if (strTotal.search(/\./) === -1) {
    strTotal = strTotal + '.00'
  } else if (strTotal.search(/\./) === strTotal.length - 2) {
    strTotal = strTotal + '0'
  }
  return strTotal
};
//for resetting cached fields
var resetAmountFields = function(){
  $('input#checkout-amount')[0].value = '1'
  $('input#amount')[0].value = '1'
};
//------Listener functions
//for calculating and showing cost for lbs
var startAmountListener = function(){
  const price = parseFloat($('#total')[0].innerText)
  $('#payment-section').change('input#amount', function(e){
    var total = roundToNearestCent(parseInt(e.target.value) * price);
    $('span#total')[0].innerHTML = total
    $('input#checkout-amount')[0].value = e.target.value 
  })
};
//for hiding card inputs on paypal
var startPaypalButtonListener = function(){
  $revealBtn = $('#reveal-input-btn');
  if ($revealBtn) {
    $revealBtn.remove();
  }
  $('.purchase-form-wrapper').on('click', '#braintree-paypal-button', function(e){
    $('#cc-inputs').hide();
    startRevealInputListener();
  })
};
//for handling input reveals if needed
var startRevealInputListener = function(){
  $('.purchase-form-wrapper').off('click', '#braintree-paypal-button');
  const button = `
    <a
      id='reveal-input-btn'
      class='btn btn-lg btn-default'
    >
      show
    </a>
  `
  $('.purchase-form-wrapper').append(button);
  $('.purchase-form-wrapper').on('click', '#reveal-input-btn', function(e){
    e.preventDefault();
    $('#cc-inputs').show();
    startPaypalButtonListener();
  })
};
//------Options functions
//for setting all of the options for braintree setup (get it? cuz its a form...)
var formatOptions = function(serverOptions, formId){
  return (
    addStylesToOptions(
      addErrorHandler(
        addPaypalToOptions(
          addFormIdToOptions(
            { hostedFields: serverOptions }, formId),
        formId, function(){$('#reveal-input-btn').trigger('click')}))
    )
  )
};
//add errorhandler function to braintree options
var addErrorHandler = function(options){
  const errorHand
  ler = function(error){
    var notice = ["<span class='error'>", error.message, "</span>"].join('')
    $('#notice-wrapper').append(notice)
    window.setTimeout(function(){
      $('span.error').remove();
    }, 5000);
  };
  var newOptions = {};
  Object.assign(newOptions, options, {onError: errorHandler});
  return newOptions
};
//add formId to braintree options
var addFormIdToOptions = function(options, formId){
  var newOptions = {};
  Object.assign(newOptions, options, {id: formId});
  return newOptions
};
//add Paypal option to braintree options
var addPaypalToOptions = function(options, formId, onAuthClosed){
  var newOptions = {};
  const paypal =
  {
    paypal: 
    {
      container: 'paypal-container',
      onAuthorizationDismissed: onAuthClosed
    }
  }
  Object.assign(newOptions, options, paypal);
  return newOptions
};
//add css to braintree options
var addStylesToOptions = function(options){
  const styles = 
  {
      styles: 
      {
        'input': 
        {
          "display": "block",
          "font-weight": "200",
          "font-size": "16px",
          "height": "30px",
          "-webkit-box-sizing": "border-box",
          "-moz-box-sizing": "border-box",
          "box-sizing": "border-box",
          "margin": "16px 0 0",
          "padding": "3px 14px",
          "width": "100%",
          "outline": "0",
          "border": "none",
          "background-color": "transparent",
          "background-image": "none",
          "-webkit-tap-highlight-color": "transparent" 
        } 
      }
  }
  var newOptions = {};
  Object.assign(newOptions, options, styles);
  return newOptions
};
//----------------------
//for setting up the hosted fields
var getBrainTreeForm = function (client_token, options) {
  braintree.setup(client_token, "custom", options)
};
//for bundling functions together to be passed to checkoutsWillEnter
var ready = function(config){
  const formId = 'braintree-payment-form'
  resetAmountFields();
  getBrainTreeForm(
    config.client_token, 
    formatOptions(config.btOptions, formId)
  );
  startAmountListener();
  startPaypalButtonListener();
};
//needed for working with turbolinks and jQuery
var checkoutsWillEnter = function(config) {
  $('document').ready(ready(config)) || $('document').on('turbolinks:load', ready(config))
};
