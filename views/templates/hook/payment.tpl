{if isset($standalone) && $standalone}
    {assign var="pageform" value="1"}
{else}
    {assign var="pageform" value="0"}  
{/if}

{if !$pageform}
    <p class="payment_module">
        <a title="Pay with PayPal" id="everypay_process_payment" href="#everypay-payment-form" >
            <img height="49px" alt="Pay with your credit card" src="{$module_template_dir}assets/images/everypay_select.jpg">            
            {l s='Pay safely with your credit/debit card' mod='everypaypayments'}
        </a>
    </p>
{/if}

{if $pageform}<div class="everypayform__standalone_wrapper">
        {if $msg}
            <div class="warning">{$msg}</div>    
        {/if}
    {/if} 

    {if $customerMode && !is_null($customerCards) && $customerCards|count>0 && !$isGuest}
        <div class="everypay_cardway_selection">
            <label>{l s='You can pay with a' mod='everypaypayments'}:</label>
            <input type="radio" id="select_saved_card" value="saved_card" name="everypay_cardway" checked="checked"><label for="select_saved_card">{l s='Saved Card' mod='everypaypayments'}</label>
            <input type="radio" id="select_new_card" value="new_card" name="everypay_cardway"><label for="select_new_card">{l s='New card' mod='everypaypayments'}</label>
        </div>
        <div class="everypay_selection_wrapper_saved_card">
            {$cardSelection}
        </div>
    {/if}
    <div class="everypay_selection_wrapper_new_card" {if $customerMode && !is_null($customerCards) && $customerCards|count>0 && !$isGuest}style="display:none"{/if}>
        <form action="{$form_action}" method="POST" id="everypay-payment-form" class="everypay_form" >

            <p class="required text">
                <label for="card-number">{l s='Card Number' mod='everypaypayments'} <sup>*</sup></label>
                <input type="text" maxlength="16" autocomplete="off" id="card-number" placeholder="XXXXXXXXXXXX4242" value="" class="text">
            </p>   

            <p class="select">
                <span>{l s='Expiration' mod='everypaypayments'} <sup>*</sup></span> 
                <select id="card-month">
                    <option value="0">{l s='Month' mod='everypaypayments'}</option>
                    {for $foo=1 to 12}
                    <option value="{$foo}">{$foo|str_pad:2:"0":$smarty.const.STR_PAD_LEFT}</option>
                    {/for}
                </select>
                <select id="card-year">
                    <option value="0">{l s='Year' mod='everypaypayments'}</option>
                    {for $foo=$smarty.now|date_format:'%Y' to ($smarty.now|date_format:'%Y')+8}
                    <option value="{$foo}">{$foo}</option>
                    {/for}
                </select>
            </p>

            <p class="required text">
                <label for="card-cvv">{l s='CVV' mod='everypaypayments'} <sup>*</sup></label>
                <input type="text" maxlength="3" autocomplete="off" id="card-cvv" placeholder="123" value="" class="text">
            </p>
            <div class="submit-everypay">
                <div class="form-error" style="display:none"></div>
                {if ($customerMode && !$isGuest)}           
                    <p>
                        <input id="remember_ev_card" type="checkbox" name="remember_card" />
                        <label for="remember_ev_card">{l s='Save this card for use in the future?' mod='everypaypayments'}
                            <br />
                            <small>{l s='Your card details don\'t get really stored. A unique token gets saved instead.' mod='everypaypayments'}</small> </label>
                    </p>
                {/if}
                <input type="button" class="submit-payment button" value="{l s='Continue' mod='everypaypayments'}" />
            </div>
        </form>
    </div> <!-- new_selection_wrapper -->

    <!-- Load this in here to have OPC compability -->
    <script type="text/javascript">
        try{
        Everypay.setPublicKey('{$configuration.EVERYPAY_PUBLIC_KEY}');
    
        var $everypayForm = {};
        bindEverypayForm();
    }catch(Exception){}
    </script>


{if $pageform}</div>{/if}
