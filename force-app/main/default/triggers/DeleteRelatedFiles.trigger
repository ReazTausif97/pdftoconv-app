trigger DeleteRelatedFiles on Knowledge_Base_Document__c (before delete) {
    Set<Id> knowledgeBaseDoc = Trigger.oldMap.keySet();
    
    List<ContentDocumentLink> relatedFiles = [
        SELECT ContentDocumentId 
        FROM ContentDocumentLink 
        WHERE LinkedEntityId IN :knowledgeBaseDoc
    ];
    
    Set<Id> contentDocumentIds = new Set<Id>();
    for (ContentDocumentLink link : relatedFiles) {
        contentDocumentIds.add(link.ContentDocumentId);
    }
    
    List<ContentDocument> documentsToDelete = [
        SELECT Id 
        FROM ContentDocument 
        WHERE Id IN :contentDocumentIds
    ];
    
    delete documentsToDelete;
}