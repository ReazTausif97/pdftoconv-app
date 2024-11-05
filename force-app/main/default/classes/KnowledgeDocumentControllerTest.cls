@isTest
public class KnowledgeDocumentControllerTest {
 @isTest
    static void testGetAllKnowledgeBase() {  
        Knowledge_Document_Syncing__c kdSync = new Knowledge_Document_Syncing__c(Name='Knowledge Document Sync Check', IsSynced__c=false);
        insert kdSync;     
         Knowledge_Base_Document__c kbDoc1 = new Knowledge_Base_Document__c(Name='Test Doc');
         insert kbDoc1; 
       
        ContentVersion cv1 = new ContentVersion(
            Title = 'Test File 1',
            PathOnClient = 'TestFile1.pdf',
            VersionData = Blob.valueOf('Test content'),
          
            Origin = 'H'
        );
        insert cv1;
        
        Id contentDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv1.Id].ContentDocumentId;

        ContentDocumentLink cdl1 = new ContentDocumentLink(
            LinkedEntityId = kbDoc1.Id,
            ContentDocumentId = contentDocId,
            ShareType = 'V'
        );
        insert cdl1;

        Test.startTest();
        List<ContentVersion> result = KnowledgeDocumentController.getAllKnowledgeBase();
        Test.stopTest();
        
        System.assertEquals(1, result.size(), 'There should be 1 ContentVersion returned.');
        System.assertEquals(cv1.Id, result[0].Id, 'The ContentVersiozn ID should match.');
    }

    @isTest
    static void testGetAllKnowledgeBaseNoData() {
        
        List<ContentVersion> result = KnowledgeDocumentController.getAllKnowledgeBase();

        System.assertEquals(0, result.size());
    }
    @isTest
    static void testGetVersionData(){
        ContentVersion cntVer = new ContentVersion(Title = 'Test File 1',
            PathOnClient = 'TestFile1.pdf',
            VersionData = Blob.valueOf('Test content'),
            Origin = 'H');
        insert cntVer;
        Test.startTest();
        String res = KnowledgeDocumentController.getVersionData(cntVer.Id);
        Test.stopTest();
        System.assertEquals(EncodingUtil.base64Encode(cntVer.VersionData),res);
    }
    @isTest
    static void testSavePDF()
    {
        ContentVersion knwArt = new ContentVersion(Title = 'Knowledge Articles',
        PathOnClient = 'Knowledge Articles.pdf',
        VersionData = Blob.valueOf('Initial Content'),
        Origin = 'H');
        insert knwArt;
        
        ContentVersion cntVer = new ContentVersion(Title = 'Test File 1',
        PathOnClient = 'TestFile1.pdf',
        VersionData = Blob.valueOf('Test content'),
        Origin = 'H');
        insert cntVer;
        Test.startTest();
        KnowledgeDocumentController.savePDF(EncodingUtil.base64Encode(cntVer.VersionData));
        Test.stopTest(); 
        ContentVersion res = [SELECT Id,VersionData FROM ContentVersion WHERE Title='Knowledge Articles'];
        System.assertEquals(EncodingUtil.base64Encode(cntVer.VersionData),EncodingUtil.base64Encode(res.VersionData));
                
    }
  @IsTest
    static void testSavePDFWithException() {
        String invalidBase64String = 'InvalidBase64String!!!'; 
        
        Test.startTest();
        try {
            KnowledgeDocumentController.savePDF(invalidBase64String);
        } catch (AuraHandledException e) {
            System.debug('exception: '+e);
                System.assertNotEquals(null, e.getMessage());
                    System.assertNotEquals('', e.getMessage());

        }
        Test.stopTest();
    }
    @IsTest
    static void testCheckSync(){
         Knowledge_Document_Syncing__c syncVar = new Knowledge_Document_Syncing__c(IsSynced__c=true,Name = 'Knowledge Document Sync Check');
        insert syncVar;
        Test.startTest();
        boolean res = KnowledgeDocumentController.checkSync();
        Test.stopTest();
        System.assertEquals(true,res);
    }
     @IsTest
    static void testSetSync(){
        Knowledge_Document_Syncing__c syncVar = new Knowledge_Document_Syncing__c(IsSynced__c=true,Name = 'Knowledge Document Sync Check');
        insert syncVar;
        Test.startTest();
        KnowledgeDocumentController.setSync();
        Test.stopTest();
        Knowledge_Document_Syncing__c res = [Select Id,IsSynced__c From Knowledge_Document_Syncing__c Where Name = 'Knowledge Document Sync Check'];
        System.assertEquals(true, res.IsSynced__c);

    }
    @isTest
    static void testSetSyncNoRecord(){
          Test.startTest();
        KnowledgeDocumentController.setSync();
        Test.stopTest();
        Knowledge_Document_Syncing__c res = [Select Id,IsSynced__c From Knowledge_Document_Syncing__c Where Name = 'Knowledge Document Sync Check'];
        System.assertNotEquals(null, res);
    }
    
}