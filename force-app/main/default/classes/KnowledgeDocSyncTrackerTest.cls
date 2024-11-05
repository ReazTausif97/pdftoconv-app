@isTest
public class KnowledgeDocSyncTrackerTest {
    
    @isTest
    static void testKnowledgeDocSyncTracker() {
        // Step 1: Create a test Knowledge_Document_Syncing__c record
        Knowledge_Document_Syncing__c syncCheck = new Knowledge_Document_Syncing__c(
            Name = 'Knowledge Document Sync Check',
            IsSynced__c = true
        );
        insert syncCheck;

        // Step 2: Create a test Knowledge_Base_Document__c record
        Knowledge_Base_Document__c knowledgeDoc = new Knowledge_Base_Document__c(
            Name = 'Test Document'
            // Add other required fields here
        );
        insert knowledgeDoc;

        // Step 3: Verify the initial state of the IsSynced__c field
        syncCheck = [SELECT IsSynced__c FROM Knowledge_Document_Syncing__c WHERE Id = :syncCheck.Id];
        System.assertEquals(false, syncCheck.IsSynced__c, 'IsSynced__c should initially be true');

        // Step 4: Update the Knowledge_Base_Document__c record to trigger the update
        knowledgeDoc.Name = 'Updated Test Document';
        update knowledgeDoc;

        // Step 5: Verify that the IsSynced__c field was updated to false
        syncCheck = [SELECT IsSynced__c FROM Knowledge_Document_Syncing__c WHERE Id = :syncCheck.Id];
        System.assertEquals(false, syncCheck.IsSynced__c, 'IsSynced__c should be false after update');

        // Step 6: Delete the Knowledge_Base_Document__c record to trigger the delete
        delete knowledgeDoc;

        // Step 7: Verify that the IsSynced__c field remains false
        syncCheck = [SELECT IsSynced__c FROM Knowledge_Document_Syncing__c WHERE Id = :syncCheck.Id];
        System.assertEquals(false, syncCheck.IsSynced__c, 'IsSynced__c should remain false after delete');
    }
}