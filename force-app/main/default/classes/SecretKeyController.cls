public with sharing class SecretKeyController {
  @AuraEnabled
  public static String saveSecretKey(String key) {

      SecretKey__c secretKeySetting = SecretKey__c.getInstance('Secret Key'); 

      if (secretKeySetting == null) {
        secretKeySetting = new SecretKey__c(Name = 'Secret Key');
      }

      // Set the API Key value
      secretKeySetting.Key__c = key;

      // Insert or update the custom setting
      upsert secretKeySetting;

      return 'Success';
   
  }
}