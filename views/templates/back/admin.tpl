<div class="everypay_container">

    <div class="admin_logo">
        <p>{l s='Accept payments with VISA/Mastercard safely, through EveryPay'}</p>    
    </div>


    <div class="menu_admin">
        <ul>
            <!--
            <li class="text_li_label">Go to:</li>
            <li><a class="button" href="#">Settings</a></li>
            <li><a class="button" href="">Customers</a></li>
            <li><a class="button"href="">Payments</a></li>-->
            <li class="text_li_label">{l s='Are you NEW to EveryPay? You should'}</li>
            <li><a class="button btn-blue" href="http://everypay.gr">{l s='Sign Up'}</a></li>
        </ul>
    </div>

    {$adminMessages.warnings}
    {$adminMessages.errors}
    {$adminMessages.success}

    <div class="ev_settings">
        <form method="post" action="">
            <fieldset>
                <legend><img alt="" src="/modules/{$moduleName}/logo.png" style="width:16px;height:16px;"> {l s='EveryPay account settings'}</legend>

                <label for="input_public_key">{l s='Public Key'}:</label>
                <div class="margin-form">
                    <input type="text" value="{$configuration.EVERYPAY_PUBLIC_KEY}" id="input_public_key" name="input_public_key" />
                </div>
                <label for="input_secret_key">{l s='Secret Key'}:</label>
                <div class="margin-form">
                    <input type="text" value="{$configuration.EVERYPAY_SECRET_KEY}" id="input_secret_key" name="input_secret_key" />                    
                </div>
                <label><abbr title="{l s='Fill in these values, according to the details in your Everypay company details'}">{l s='Where can I find these?'}</abbr></label>
                <div class="margin-form"><a href="http://everypay.local/support" target="_blank">{l s='Read more...'}</a></div>
                <p class="center"><input type="submit" value="{l s='Save settings'}" name="submitConfiguration" class="button"></p>
            </fieldset>

            <br />

            <fieldset>
                <legend><img alt="" src="..../../../img/admin/edit.gif" style="width:16px;height:16px;"> {l s='Other Settings'}</legend>

                <label for="input_customer_mode">{l s='Enable customers to save cards'}</label>
                <div class="margin-form">
                    <input type="checkbox" value="1" id="input_customer_mode" name="input_customer_mode" {if $configuration.EVERYPAY_CUSTOMER_MODE}checked="checked"{/if} autocomplete=off />
                </div>
                <p class="center"><input type="submit" value="{l s='Save settings'}" name="submitConfiguration" class="button"></p>
            </fieldset>
        </form>
    </div>
</div>