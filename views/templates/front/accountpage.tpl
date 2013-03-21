{capture name=path}
    <a href="{$link->getPageLink('my-account', true)|escape:'htmlall':'UTF-8'}">
        {l s='My account' mod='everypaypayments'}</a>
    <span class="navigation-pipe">{$navigationPipe}</span>{l s='My credit/debit cards' mod='everypaypayments'}
{/capture}

{include file="$tpl_dir./breadcrumb.tpl"}

<div id="everypay_confirmation_wrapper" class="everypay_customer_cards_container">
    <h1>{l s='My credit/debit cards' mod='everypaypayments'}</h1>
    {if $cards}
        {if $msg}
            <p class="warning">{$msg}</p>
        {/if}
        <p> {l s='Here you can review your stored Credit/Debit cards.' mod='everypaypayments'}
            <br /><br />
            {l s='Note that your sensitive card data are not really stored in our store. Instead a unique token is created so that your future transactions use this.' mod='everypaypayments'}
        </p>
        <table class="std" id="order-list">
            <thead>
                <tr>

                    <th></th>
                    <th>{l s='Card type' mod='everypaypayments'}</th>
                    <th>{l s='Last four digits' mod='everypaypayments'}</th>
                    <th></th>
                </tr>

            </thead>
            <tbody>
                {foreach from=$cards item=card}
                    <tr>
                        <td style="text-align:center"><img src="/modules/{$moduleName}/assets/images/icon-{$card['card_type']|strtolower}.gif" /></td>
                        <td>{$card['card_type']}</td>
                        <td>{$card['card_last_four']}</td>
                        <td>
                            <form action="{$form_action}" method="POST">
                                <input type="submit" name="deleteCard" class="button" value="{l s='Remove' mod='everypaypayments'}">
                                <input type="hidden" name="card" value="{$card['id_customer_token']}" />
                            </form>
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    {else}   

        {if $msg}
            <p class="warning">
                <font style="font-size:15px; font-weight:bold;">{$msg}</font>
            </p>
        {/if}

        <p class="warning">{l s='No stored cards have been found' mod='everypaypayments'}</p>

        <p>
            {l s='No credit/debit card has been stored in your account yet. You will be offered to save your card upon your first order that is paid with credit/debit card (check the "save card" option).' mod='everypaypayments'}                
            <br/><br/>
            {l s='Note that your sensitive card data are not really stored in our store. Instead a unique token is created so that your future transactions use this.' mod='everypaypayments'}
        </p>
    {/if}

    <ul class="footer_links">
        <li class="fleft">
            <a href="{$link->getPageLink('my-account', true)|escape:'htmlall':'UTF-8'}"><img src="{$img_dir}icon/my-account.gif" alt="" class="icon" />{l s='Back to Your Account' mod='everypaypayments'}</a>
        </li>
    </ul>
</div>