global class  PostInstallClass implements InstallHandler {	
    // This method will be executed after the package installation
    global void onInstall(InstallContext context) {
        System.debug('Post installation script started.');
        getAPI(context.organizationId());
        
    }
    
    @future(callout=true)
    public static void getAPI(String orgId) {
		try { 
			 Http http = new Http();
             HttpRequest request = new HttpRequest();

            String url = 'https://rut.my.salesforce-sites.com/services/apexrest/getAPIKey';
            request.setEndpoint(url);
            
            // Set the HTTP method to POST
            request.setMethod('POST');
            
            // Set the Content-Type header to application/json
            request.setHeader('Content-Type', 'application/json');
            
            // Prepare the body with orgId in JSON format
            String requestBody = JSON.serialize(new Map<String, String>{'orgId' => orgId});
            request.setBody(requestBody);
            
            // Send the HTTP request and get the response
            HttpResponse response = http.send(request);
            String apiKey = response.getBody();
            SecretKeyController.saveSecretKey(apiKey);
            
            System.debug('Post installation script completed successfully.');
        } catch (Exception e) {
            System.debug('Error during post installation: ' + e.getMessage());
        
        }
    }



  
}