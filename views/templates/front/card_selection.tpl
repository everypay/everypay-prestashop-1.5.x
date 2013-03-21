{if !is_null($customerCards) && $customerCards|count>0}
    <form action="{$form_action}" id="select_everypay_saved_card" method="POST">

        <p class="select">
            <span>{l s='Select a saved card' mod='everypaypayments'}:</span> 
            <select name="cus_id" id="cust_ids">
                {foreach from=$customerCards key=k item=v}
                    <option value="{$v['id_customer_token']}">{$v['card_type']}...............{$v['card_last_four']}</option>
                {/foreach}
            </select>
        </p>
        <div class="submit-everypay">
            <input type="submit" name="submit_saved_card" class="submit_saved_card button" value="{l s='Continue' mod="everypaypayments"}" /> 
        </div>
    </form>
{/if}