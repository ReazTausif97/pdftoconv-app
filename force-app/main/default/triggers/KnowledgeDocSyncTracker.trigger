trigger KnowledgeDocSyncTracker on Knowledge_Base_Document__c (after insert, after update, after delete) {
 List<Knowledge_Document_Syncing__c> syncCheck = [SELECT ID, IsSynced__c FROM Knowledge_Document_Syncing__c Where Name = 'Knowledge Document Sync Check'];
 if(syncCheck.size()==0)
 {
    Knowledge_Document_Syncing__c newSyncRecord = new Knowledge_Document_Syncing__c(Name = 'Knowledge Document Sync Check');
     insert newSyncRecord;
     syncCheck = [SELECT ID, IsSynced__c FROM Knowledge_Document_Syncing__c Where Name = 'Knowledge Document Sync Check'];
     
 } 
    syncCheck[0].IsSynced__c=false;
      update syncCheck;   
     EventBus.publish(new PDFtoConv__knowledgeDocumentChangeEvent__e());
      
}