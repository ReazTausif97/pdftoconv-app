@isTest
public class DeleteRelatedFileTest {
    
  @isTest
	static void testDeleteRelatedFiles() {
           Knowledge_Document_Syncing__c kdSync = new Knowledge_Document_Syncing__c(Name='Knowledge Document Sync Check', IsSynced__c=false);
        insert kdSync;   
   Knowledge_Base_Document__c testDoc = new Knowledge_Base_Document__c(Name = 'Test Document');
    insert testDoc;

    ContentVersion contentVersion = new ContentVersion(
        Title = 'Test File',
        VersionData = Blob.valueOf('Test Content'),
        PathOnClient = 'TestFile.pdf'
    );
    insert contentVersion;
    
    ContentDocumentLink contentLink = new ContentDocumentLink(
        LinkedEntityId = testDoc.Id,
        ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id].ContentDocumentId
    );
    insert contentLink;

    Test.startTest();
    delete testDoc;
    Test.stopTest();

    List<ContentDocument> remainingDocuments = [
        SELECT Id FROM ContentDocument WHERE Id = :contentLink.ContentDocumentId
    ];
    System.assertEquals(0, remainingDocuments.size());
}

}