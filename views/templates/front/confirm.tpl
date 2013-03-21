{capture name=path}{l s='Card Payment (Everypay)' mod='everypaypayments'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

<div id="everypay_confirmation_wrapper" class="everypay_selection_wrapper_confirm">

    <h2>{l s='Complete your order' mod='everypaypayments'}</h2>

    {assign var='current_step' value='payment'}
    {include file="$tpl_dir./order-steps.tpl"}

    {if isset($msg) && $msg}
        <div class="warning">{$msg}</div>    
    {/if}
    <form action="{$form_action}" method="post">
        <p>                
            {l s='Here is a short summary of your order:' mod='everypaypayments'}
        </p>
        <p>
            {l s='The amount of ' mod='everypaypayments'} <span id="amount" class="price">{displayPrice price=$amount}</span> {l s='will be subtracted from your card.' mod='everypaypayments'}
        </p>
        <p>                
            <b>{l s='Please confirm your order by clicking \'I confirm my order\'' mod='everypaypayments'}</b>
        </p>
        <p class="cart_navigation">
            <input type="submit" name="submitConfirm" value="{l s='I confirm my order' mod='everypaypayments'}" class="exclusive_large" />
            <a href="{$link->getPageLink('order', true, NULL, "step=3")}" class="button_large">{l s='Other payment methods' mod='everypaypayments'}</a>
        </p>
    </form>

</div>
