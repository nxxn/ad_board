$(document).ready(function() {

  $('#custom_credit_amount').on('change', function() {
    $('#custom_credit_amount_radio').val( this.value);
    $('.custom_credit_amount_usd').text( this.value * 0.01);
  });

});
