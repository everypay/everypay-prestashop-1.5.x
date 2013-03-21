<?php
class EverypaypaymentsFormModuleFrontController extends ModuleFrontController
{
	/**
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{		
		parent::initContent();
                
                $this->module->configurePaymentForm();
                
                $this->context->smarty->assign(array(
                    'standalone' => true
                ));
                
                $this->setTemplate('../hook/payment.tpl');
	}
}