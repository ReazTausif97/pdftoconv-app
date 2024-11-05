public with sharing class KnowledgeDocumentController {
  @AuraEnabled
  public static List<ContentVersion> getAllKnowledgeBase() {
    if (
      !Schema.sObjectType.Knowledge_Base_Document__c.fields.Id.isAccessible()
    ) {
      throw new System.NoAccessException();
    }

    List<Knowledge_Base_Document__c> knowledgeBaseDocuments = [
      SELECT Id
      FROM Knowledge_Base_Document__c
    ];
    if (knowledgeBaseDocuments.isEmpty()) {
      return new List<ContentVersion>();
    }

    Set<Id> knowledgeDocId = new Map<Id, Knowledge_Base_Document__c>(
        knowledgeBaseDocuments
      )
      .keySet();

    if (
      !Schema.sObjectType.ContentDocumentLink.fields.ContentDocumentId.isAccessible()
    ) {
      throw new System.NoAccessException();
    }
    List<Id> tempsId = new List<Id>();
    List<ContentDocumentLink> lsOfCDL = new List<ContentDocumentLink>();
    if (knowledgeDocId != null) {
      lsOfCDL = [
        SELECT ContentDocumentId
        FROM ContentDocumentLink
        WHERE LinkedEntityId IN :knowledgeDocId
      ];
      for (ContentDocumentLink tempLoop : lsOfCDL) {
        tempsId.add(tempLoop.ContentDocumentId);
      }
    } else {
      throw new System.NullPointerException();
    }

    if (tempsId.isEmpty()) {
      return new List<ContentVersion>();
    }

    if (
      !Schema.sObjectType.ContentVersion.fields.Id.isAccessible() ||
      !Schema.sObjectType.ContentVersion.fields.ContentDocumentId.isAccessible() ||
      !Schema.sObjectType.ContentVersion.fields.FileExtension.isAccessible()
    ) {
      throw new System.NoAccessException();
    }

    List<ContentVersion> lsOfCV = [
      SELECT Id, ContentDocumentId, FileExtension
      FROM ContentVersion
      WHERE ContentDocumentId IN :tempsId AND isLatest = TRUE
    ];
    return lsOfCV;
  }

  @AuraEnabled
  public static String getVersionData(String contentVersionId) {
    if (!Schema.sObjectType.ContentVersion.fields.VersionData.isAccessible()) {
      throw new System.NoAccessException();
    }
    ContentVersion cv = new ContentVersion();
    if (contentVersionId != null) {
      cv = [
        SELECT VersionData
        FROM ContentVersion
        WHERE Id = :contentVersionId
        LIMIT 1
      ];
    } else {
      throw new System.NullPointerException();
    }
    return EncodingUtil.base64Encode(cv.VersionData);
  }

  @AuraEnabled
  public static void savePDF(String base64Strings) {
    // Check if the user has read access to the ContentVersion fields
    if (
      !Schema.sObjectType.ContentVersion.fields.Title.isAccessible() &&
      !Schema.sObjectType.ContentVersion.fields.ContentDocumentId.isAccessible()
    ) {
      throw new System.NoAccessException();
    }

    List<ContentVersion> files = [
      SELECT Id, Title, ContentDocumentId
      FROM ContentVersion
      WHERE Title = 'Knowledge Articles'
    ];
    try {
      Blob completePdfBlob = EncodingUtil.base64Decode(base64Strings);
      System.debug(completePdfBlob);
      if (!files.isEmpty()) {
        
          List<ContentDocument> docs = [
            SELECT Id
            FROM ContentDocument
            WHERE Id = :files[0].ContentDocumentId
          ];
          if (Schema.sObjectType.ContentDocument.isDeletable()) {
            delete docs;
          } else {
            throw new System.NoAccessException();
          }
      }
        

        // Delete the existing file
      

      // Check if the user has create access to the ContentVersion fields
      if (
        !Schema.sObjectType.ContentVersion.fields.Title.isCreateable() ||
        !Schema.sObjectType.ContentVersion.fields.PathOnClient.isCreateable() ||
        !Schema.sObjectType.ContentVersion.fields.VersionData.isCreateable()
      ) {
        throw new System.NoAccessException();
      }

      // Create a new file record with the updated file
      ContentVersion newFile = new ContentVersion();
      newFile.Title = 'Knowledge Articles';
      newFile.PathOnClient = 'Knowledge Articles.pdf';
      newFile.VersionData = completePdfBlob;
      insert newFile;
      generateURL(newFile.id);
    } catch (Exception e) {
      System.debug('Error saving complete PDF: ' + e.getMessage());
      throw new AuraHandledException(
        'Error saving complete PDF: ' + e.getMessage()
      );
    }
  }

  private static void generateURL(String cv) {
    // Check if the user has create access to the ContentDistribution fields
    if (
      !Schema.sObjectType.ContentDistribution.fields.Name.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.ContentVersionId.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.PreferencesAllowViewInBrowser.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.PreferencesLinkLatestVersion.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.PreferencesNotifyOnVisit.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.PreferencesPasswordRequired.isCreateable() ||
      !Schema.sObjectType.ContentDistribution.fields.PreferencesAllowOriginalDownload.isCreateable()
    ) {
      throw new System.NoAccessException();
    }

    ContentDistribution cd = new ContentDistribution();
    cd.Name = 'Knowledge Articles';
    cd.ContentVersionId = cv;
    cd.PreferencesAllowViewInBrowser = true;
    cd.PreferencesLinkLatestVersion = true;
    cd.PreferencesNotifyOnVisit = false;
    cd.PreferencesPasswordRequired = false;
    cd.PreferencesAllowOriginalDownload = true;
    insert cd;
  }

  @AuraEnabled(Cacheable=true)
  public static boolean checkSync() {
    // Check if the user has read access to the Knowledge_Document_Syncing__c fields
    if (
      !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.IsSynced__c.isAccessible() ||
      !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.Name.isAccessible()
    ) {
      throw new System.NoAccessException();
    }

    List<Knowledge_Document_Syncing__c> isSynced = [
      SELECT IsSynced__c
      FROM Knowledge_Document_Syncing__c
      WHERE name = 'Knowledge Document Sync Check'
    ];
    System.debug(isSynced[0].IsSynced__c);
    return isSynced[0].IsSynced__c;
  }

  @AuraEnabled
  public static void setSync() {
    if (
      !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.IsSynced__c.isAccessible() ||
      !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.Name.isAccessible()
    ) {
      throw new System.NoAccessException();
    }

    List<Knowledge_Document_Syncing__c> syncRecords = [
      SELECT Id, IsSynced__c, Name
      FROM Knowledge_Document_Syncing__c
      WHERE Name = 'Knowledge Document Sync Check'
    ];

    if (syncRecords.size() > 0) {
      // Corrected the method calls to check field-level security on the SObjectField tokens
      if (
        Schema.sObjectType.Knowledge_Document_Syncing__c.fields.IsSynced__c.isUpdateable() &&
        Schema.sObjectType.Knowledge_Document_Syncing__c.fields.Name.isUpdateable()
      ) {
        syncRecords[0].IsSynced__c = true;
        update syncRecords;
      } else {
        throw new System.NoAccessException();
      }
    } else {
      Knowledge_Document_Syncing__c newSyncRecord = new Knowledge_Document_Syncing__c(
        IsSynced__c = true,
        Name = 'Knowledge Document Sync Check'
      );

      // Corrected the method calls to check field-level security on the SObjectField tokens
      if (
        !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.IsSynced__c.isCreateable() ||
        !Schema.sObjectType.Knowledge_Document_Syncing__c.fields.Name.isCreateable()
      ) {
        throw new System.NoAccessException();
      }

      // FLS check before DML operation
      insert newSyncRecord;
    }
  }
}