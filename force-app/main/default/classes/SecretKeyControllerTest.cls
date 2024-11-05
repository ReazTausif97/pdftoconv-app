@IsTest
public class SecretKeyControllerTest {
    
    @IsTest
    static void testSaveSecretKey_CreateNewKey() {
        // Test creating a new Secret Key setting
        Test.startTest();
        
        // Call the method to save a new key
        String result = SecretKeyController.saveSecretKey('NewTestKey');
        
        Test.stopTest();
        
        // Check that the result is success
        System.assertEquals('Success', result);
        
        // Verify that the SecretKey__c record was inserted with the new key
	  SecretKey__c insertedKey = SecretKey__c.getInstance('Secret Key');
        System.assertEquals('NewTestKey', insertedKey.Key__c);
    }
    
    @IsTest
    static void testSaveSecretKey_UpdateExistingKey() {
        // Test updating an existing Secret Key setting
        Test.startTest();
        
        // Insert an existing SecretKey__c record to simulate an update scenario
        SecretKey__c secretKeySetting = new SecretKey__c(Name = 'Secret Key', Key__c = 'ExistingKey');
        insert secretKeySetting;
        
        // Call the method to update the existing key
        String result = SecretKeyController.saveSecretKey('UpdatedTestKey');
        
        Test.stopTest();
        
        // Check that the result is success
        System.assertEquals('Success', result);
        
        // Verify that the SecretKey__c record was updated with the new key
        SecretKey__c updatedKey = [SELECT Name, Key__c FROM SecretKey__c WHERE Name = 'Secret Key' LIMIT 1];
        System.assertEquals('UpdatedTestKey', updatedKey.Key__c);
    }
    
   
}