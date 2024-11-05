public with sharing class Ingest {
  @AuraEnabled
  public static void uploadPDF() {
     PDFtoConv__SecretKey__c apiKey = PDFtoConv__SecretKey__C.getInstance('Secret Key');
    if (apiKey == null || String.isBlank(apiKey.KEY__c)) {
      throw new AuraHandledException('Secret Key is missing. Please set the Secret key by following the instructions on the instruction page.');
    }
    

    PDFtoConv__KnowledgeBase__c article = PDFtoConv__KnowledgeBase__c.getInstance(
      'Knowledge Article'
    );
    if (article == null) {
      article = new PDFtoConv__KnowledgeBase__c();
      article.Name = 'Knowledge Article';
    } else if (String.isNotBlank(article.File_Source_Id__c)) {
      deletePDF(article.File_Source_Id__c);
    }

    List<ContentVersion> cntDocs = [
      SELECT ContentDocumentId
      FROM ContentVersion
      WHERE Title = 'Knowledge Articles'
      ORDER BY CreatedDate DESC
      LIMIT 1
    ];
    if (cntDocs.isEmpty()) {
      System.debug('ContentVersion record for Knowledge Articles not found.');
      return;
    }
    ContentVersion cntDoc = cntDocs[0];
    List<ContentDistribution> cntDists = new List<ContentDistribution>();
    if (cntDoc.ContentDocumentId != null) {
      cntDists = [
        SELECT DistributionPublicUrl, PdfDownloadUrl, ContentDownloadUrl
        FROM ContentDistribution
        WHERE ContentDocumentId = :cntDoc.ContentDocumentId
        LIMIT 1
      ];
    } else {
      throw new NullPointerException();
    }
    if (cntDists.isEmpty()) {
      System.debug('ContentDistribution record not found.');
      return;
    }
    ContentDistribution cntDist = cntDists[0];
    Http http = new Http();

    // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.chatpdf.com/v1/sources/add-url');
    req.setMethod('POST');

    // Set headers
    req.setHeader('x-api-key', apiKey.KEY__c);
    req.setHeader('Content-Type', 'application/json');

    // Set the body
    String requestBody = '{"url": "' + cntDist.ContentDownloadUrl + '"}';
    req.setBody(requestBody);

    // Send the request, and return a response
    HttpResponse res;
    try {
      res = http.send(req);

      // Handle response
      if (res.getStatusCode() == 200) {
        // Parse JSON response
        Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(
          res.getBody()
        );
        if (responseBody.containsKey('sourceId')) {
          article.File_Source_Id__c = (String) responseBody.get('sourceId');
          upsert article;
          System.debug('Source ID: ' + (String) responseBody.get('sourceId'));
        } else {
          System.debug('Error: Response does not contain Source ID');
        }
      } else {
        System.debug('Error: ' + res.getStatus() + ' ' + res.getStatusCode());
      }
    } catch (Exception e) {
      System.debug('Exception: ' + e.getMessage());
    }
  }

  public static void deletePDF(String fileSourceId) {
    PDFtoConv__SecretKey__c apiKey = PDFtoConv__SecretKey__C.getInstance('Secret Key');
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.chatpdf.com/v1/sources/delete');
    req.setMethod('POST');

    req.setHeader('x-api-key', apiKey.KEY__c);
    req.setHeader('Content-Type', 'application/json');

    String requestBody = '{"sources":  ["' + fileSourceId + '"] }';
    req.setBody(requestBody);
    HttpResponse res;
    res = http.send(req);
    System.debug(res);
    //  Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    //System.debug(responseBody);
  }
}