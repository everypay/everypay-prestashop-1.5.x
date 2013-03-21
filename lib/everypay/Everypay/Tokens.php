<?php
/**
 * EveryPay PHP Library
 */

require_once 'AbstractResource.php';

/**
 * Tokens resource class.
 */
class Everypay_Tokens extends Everypay_AbstractResource
{
    /**
     * API resource name.
     * 
     * @var string
     */
    const RESOURCE_NAME = 'tokens';
    
    /**
     * {@inheritdoc}
     */
    public static function getResourceName()
    {
        return self::RESOURCE_NAME;
    }
    
    /**
     * Create a new card token object.
     * 
     * @param array $params
     * @return stdClass
     */
    public static function create(array $params)
    {
        return parent::_create(self::getResourceName(), $params);
    }
    
    /**
     * Retrieve an existing card token.
     * 
     * @param string|stdClass $token
     * @return stdClass
     */
    public static function retrieve($token)
    {
        return parent::_retrieve(self::getResourceName(), $token);
    }
    
    /**
     * Not avalable for this resource.
     * 
     * @param array $params
     * @throws Everypay_Exception_RuntimeException
     */
    public static function listAll(array $params = array())
    {
        throw new Everypay_Exception_RuntimeException(
            'Resource ' . ucfirst(self::getResourceName()) . 
            ' does not support method ' . __METHOD__
        );
    }
    
    /**
     * Not avalable for this resource.
     * 
     * @param array $params
     * @throws Everypay_Exception_RuntimeException
     */
    public static function update($token, array $params)
    {
        throw new Everypay_Exception_RuntimeException(
            'Resource ' . ucfirst(self::getResourceName()) . 
            ' does not support method ' . __METHOD__
        );
    }
    
    /**
     * Not avalable for this resource.
     * 
     * @param array $params
     * @throws Everypay_Exception_RuntimeException
     */
    public static function delete($token)
    {
        throw new Everypay_Exception_RuntimeException(
            'Resource ' . ucfirst(self::getResourceName()) . 
            ' does not support method ' . __METHOD__
        );
    }
}
