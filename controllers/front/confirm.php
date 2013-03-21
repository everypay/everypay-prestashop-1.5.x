<?php
class EverypaypaymentsConfirmModuleFrontController extends ModuleFrontController
{
	/**
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{
		$this->display_column_left = false;
		parent::initContent();
                
                $this->module->paymentConfirmation();		

		$this->setTemplate('confirm.tpl');
	}
}