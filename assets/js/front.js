$(document).ready(function() {
    var $everypayForm = {};
    bindEverypayForm();
});

function everypayResponseHandler(status, response) {
    var $everypayForm = $('#everypay-payment-form');
    
    if (response.error) {                
        /* displaying the error to the user */
        $everypayForm.find(".form-error").html(response.error.message).show();
        $everypayForm.find(".submit-payment").removeAttr("disabled");
    } else {
        var token = response['token'];
        /* adding the token to the form */
        $everypayForm.append('<input type="hidden" name="token" value="' + token + '"/>');
        /* submitting the form */
        $everypayForm.submit();
    }
}


function bindEverypayForm(){
    $everypayForm = $('#everypay-payment-form');
    $everypayForm.find('.submit-payment').removeAttr('disabled');
    
    $everypayForm.find('.submit-payment').unbind('click').bind('click', function(){
    
        /*  disabling the button to prevent multiple executions */
        $(this).attr("disabled", "disabled");

        /*  clearing any errors that may have occured at previous attempts */
        $everypayForm.find(".form-error").html('').hide();
        
        var cardData = {
            card_number: $everypayForm.find('#card-number').val(),
            cvv: $everypayForm.find('#card-cvv').val(),
            expiration_month: $everypayForm.find('#card-month').val(),
            expiration_year: $everypayForm.find('#card-year').val()
        }

        Everypay.validateCardData(cardData);

        if (Everypay.error){
            $everypayForm.find(".form-error").html(Everypay.error).show();
            $(this).removeAttr("disabled");                    
        }else{
            Everypay.createToken(cardData, everypayResponseHandler);
        }
    });       
    
    
    /*
     * The customer mode selector
     * 
     */
    $('.everypay_cardway_selection input[type="radio"]').unbind('click').bind('click',function(){
        
        var selected = $(this).val();
        
        if ($('.everypay_selection_wrapper_'+selected).is(':visible')){
            return;
        }        
        
        $('.everypay_cardway_selection > *').attr('disabled', 'disabled');
        
        $('[class^="everypay_selection_wrapper_"]:visible').fadeOut(function(){
            $('.everypay_selection_wrapper_'+selected).fadeIn();
            $('.everypay_cardway_selection > *').removeAttr('disabled');
        });
    });
    
    $('.everypay_cardway_selection #select_saved_card').trigger('click');
    
    $('.everypay_customer_cards_container input[type="submit"]').bind('click', function() {
        if(!confirm('Are you sure?') )
            return false;
    });
    
}