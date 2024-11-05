@isTest
private class PDF_UploadControllerTest {
    @isTest static void testSaveKnowledgeBaseDocument() {
       Knowledge_Document_Syncing__c kdSync = new Knowledge_Document_Syncing__c(Name='Knowledge Document Sync Check', IsSynced__c=false);
        insert kdSync; 
        Knowledge_Base_Document__c testKBD = new Knowledge_Base_Document__c(Name = 'Test KBD');
        insert testKBD;

        // Step 2: Simulate the file upload process
        // Create a ContentVersion to represent the PDF file
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test PDF',
            PathOnClient = 'TestPDF.pdf',
            VersionData = Blob.valueOf('Test PDF Content'),
            IsMajorVersion = true
        );
        insert testContentVersion;

        // Query the newly inserted ContentVersion to get the ContentDocumentId
        testContentVersion = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id LIMIT 1];

        // Step 3: Call the method under test
        Test.startTest();
        Id kbdId = PDF_UploadController.saveKnowledgeBaseDocument('Test KBD', testContentVersion.ContentDocumentId);
        Test.stopTest();

        // Step 4: Assert the expected outcomes
        System.assertNotEquals(null, kbdId, 'The Knowledge Base Document ID should not be null');

        // Query for the ContentDocumentLink to verify the link was created
        ContentDocumentLink cdl = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :kbdId LIMIT 1];
        System.assertEquals(testContentVersion.ContentDocumentId, cdl.ContentDocumentId, 'The ContentDocumentId should match the test ContentVersion');
    }
}