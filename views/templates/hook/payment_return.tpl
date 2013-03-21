<p>{l s='Your order on' mod='everypaypayments'} <span class="bold">{$shop_name}</span> {l s='is complete.' mod='everypaypayments'}
    <br />

<div class="everypay_selection_wrapper_">
    <h3>{l s='Some details about your order' mod='everypaypayments'}:</h3>
    <ul class="ev_order_details">

        <li>
            {if $order->reference}
                <span>{l s='Reference' mod='everypaypayments'}:</span> {$order->reference} (id:{$order_id_formatted})
            {else}
                <span>{l s='ID number' mod='everypaypayments'}:</span> {$order_id_formatted}   
            {/if}
        </li>
        <li><span>{l s='Total amount paid' mod='everypaypayments'}:</span> {$total_paid}</li>
        <li><span>{l s='Payment way' mod='everypaypayments'}:</span> {$order->payment}</li>
        {if isset($carrier->name) && !empty($carrier->name)}
            <li><span>{l s='Delivery method' mod='everypaypayments'}:</span> {$carrier->name}</li>
        {/if}
        <li><span>{l s='Current state' mod='everypaypayments'}:</span> {$state['name']}</li>
    </ul>
</div>
<br />{l s='For any questions or for further information, please contact our' mod='everypaypayments'} 
<a href="{$link->getPageLink('contact-form', true)}">{l s='customer support' mod='everypaypayments'}</a>.
<br />
{l s='Thank you for your trust.' mod='everypaypayments'}
</p>