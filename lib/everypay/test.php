<?php

require_once 'Everypay.php';
require_once 'Everypay/Tokens.php';
require_once 'Everypay/Customers.php';
require_once 'Everypay/Payments.php';

try {
    $uri = 'http://api.everypay.local/';
    EveryPay::setApiEndPoint($uri);

    $key = 'sk_PmGxqSfY6YuUrHwIM5NOlIyIDcgO8Nhr';
    EveryPay::setApiKey($key);
    
    $params = array(
        'card_number' => '4242424242424242',
        'expiration_month' => '12',
        'expiration_year' => '2015',
        'cvv' => '123'
    );
    $cardToken = Everypay_Tokens::create($params);
    
    $customer  = Everypay_Customers::create(array(
        //'amount' => 10000,
        'token'  => $cardToken->token,
        'full_name' => 'Minas Kitsos',
        'email' => 'sdgf@mail.com'        
    ));
    
    $payment = Everypay_Payments::create(array(
        'token' => $customer->token,
        'amount' => 100232,
        'description' => "Dell All in One 23''"
    ));
    
    //Everypay_Payments::delete($payment);
    
    //$payment = Everypay_Payments::refund($payment, array('amount' => 200));
    
    print_r($payment);
    
} catch (Exception $e) {
    echo $e->getMessage() . PHP_EOL;
}
