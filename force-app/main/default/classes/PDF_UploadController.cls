public with sharing class PDF_UploadController {
   
    @AuraEnabled
    public static Id saveKnowledgeBaseDocument(String name, String fileContent) {
        // Create a new instance of the custom object
     

        // Check if the current user has create access to the Knowledge_Base_Document__c fields
        if (!Schema.sObjectType.Knowledge_Base_Document__c.fields.Name.isCreateable()) {
            // Log the error or handle it as needed
            // For example, you could log an error message or return a custom error response
            // System.debug('You do not have permission to create Knowledge Base Document records.');
            throw new System.NoAccessException();
        }
         Knowledge_Base_Document__c kbd = new Knowledge_Base_Document__c();

        // Insert the custom object record
        try{
        kbd.Name = name;
        insert kbd;
        }
        catch (Exception e) {
            System.debug('Error Saving Knowledge Base Document  ' + e.getMessage());
     		 throw new AuraHandledException(
        	'Error Saving Knowledge Base Document ' + e.getMessage()
      );
            
        }

        

        // Create a new ContentDocumentLink record
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = fileContent;
        cdl.LinkedEntityId = kbd.Id;
        cdl.ShareType = 'I';

        // Check if the current user has create access to the ContentDocumentLink fields
        if (!Schema.sObjectType.ContentDocumentLink.fields.ContentDocumentId.isCreateable() ||
            !Schema.sObjectType.ContentDocumentLink.fields.LinkedEntityId.isCreateable() ||
            !Schema.sObjectType.ContentDocumentLink.fields.ShareType.isCreateable()) {
            // Log the error or handle it as needed
            // For example, you could log an error message or return a custom error response
            // System.debug('You do not have permission to link documents.');
            throw new System.NoAccessException();
        }

        // Insert the ContentDocumentLink record
        insert cdl;

        // Return the ID of the newly created custom object record
        return kbd.Id;
    }
    
    
  
}