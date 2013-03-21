<?php
class EverypaypaymentsTokenModuleFrontController extends ModuleFrontController
{
	/**
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{		
		parent::initContent(); 
                
                $this->module->submitToken();
	}
}