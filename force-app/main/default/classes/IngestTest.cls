@IsTest
public class IngestTest {

    @IsTest
    static void testUploadPDF_Success() {
        // Set up mock HTTP response for the successful callout
        Test.setMock(HttpCalloutMock.class, new IngestMockHttpResponse(200, '{"sourceId": "testSourceId"}'));

        // Set up required test data
        SecretKey__c secretKey = new SecretKey__c(Name = 'Secret Key', Key__c = 'testApiKey');
        insert secretKey;

        // Insert ContentVersion to simulate a knowledge article PDF upload
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Knowledge Articles',   
            PathOnClient = 'Knowledge Articles.pdf',
            
            VersionData = Blob.valueOf('Test data')
        );
        insert contentVersion;
        
             ContentDistribution cd = new ContentDistribution();
        cd.Name = 'Knowledge Articles';
        cd.ContentVersionId = contentVersion.id;
        cd.PreferencesAllowViewInBrowser = true;
        cd.PreferencesLinkLatestVersion = true;
        cd.PreferencesNotifyOnVisit = false;
        cd.PreferencesPasswordRequired = false;
        cd.PreferencesAllowOriginalDownload = true;
        insert cd;

      

        // Execute the uploadPDF method
        Test.startTest();
        Ingest.uploadPDF();
        Test.stopTest();

        // Validate that the KnowledgeBase__c record was updated with the correct sourceId
        KnowledgeBase__c knowledgeBase = [SELECT File_Source_Id__c FROM KnowledgeBase__c WHERE Name = 'Knowledge Article' LIMIT 1];
        System.assertEquals('testSourceId', knowledgeBase.File_Source_Id__c, 'The sourceId should be updated to testSourceId');
    }

    @IsTest
    static void testUploadPDF_ContentVersionNotFound() {
        // Set up mock HTTP response for the callout
        Test.setMock(HttpCalloutMock.class, new IngestMockHttpResponse(200, '{"sourceId": "testSourceId"}'));

        // Insert SecretKey__c but no ContentVersion
        SecretKey__c secretKey = new SecretKey__c(Name = 'Secret Key', Key__c = 'testApiKey');
        insert secretKey;

        // Execute the uploadPDF method
        Test.startTest();
        Ingest.uploadPDF();
        Test.stopTest();

        // Verify that no KnowledgeBase__c record was created, since no ContentVersion was found
        List<KnowledgeBase__c> knowledgeBaseList = [SELECT Id FROM KnowledgeBase__c WHERE Name = 'Knowledge Article'];
        System.assertEquals(0, knowledgeBaseList.size(), 'No KnowledgeBase__c record should be created without ContentVersion');
    }

   

    @IsTest
    static void testDeletePDF() {
        // Simulate a delete PDF operation
        Test.setMock(HttpCalloutMock.class, new IngestMockHttpResponse(200, '{"success": true}'));

        // Insert SecretKey__c
        SecretKey__c secretKey = new SecretKey__c(Name = 'Secret Key', Key__c = 'testApiKey');
        insert secretKey;

        // Execute the deletePDF method
        Test.startTest();
        Ingest.deletePDF('testFileSourceId');
        Test.stopTest();

        // Verify that no exceptions were thrown during the delete operation
        System.assert(true, 'PDF deletion completed without any errors.');
    }
}