<?php
class EverypaypaymentsAccountModuleFrontController extends ModuleFrontController
{
	public $ssl = true;
        
	public function initContent()
	{       
                $this->display_column_left = false;
		parent::initContent();                
                
                $this->module->customerCardsPage();
                
                $this->setTemplate('accountpage.tpl');
	}
}