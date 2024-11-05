@isTest
private class PostInstallTest {
 
    @isTest
    static void testSuccessfulInstallation() {
        // Create a mock install context
        Test.testInstall(new PostInstallClass(), new Version(1,0), true);
        
        // Set up the mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(true));
        
        // Start the test
        Test.startTest();
        
        // Create a new instance of the install class
        PostInstallClass installScript = new PostInstallClass();
        
        // Create a mock InstallContext
        TestInstallContext mockContext = new TestInstallContext();
        
        // Execute the onInstall method
        installScript.onInstall(mockContext);
        
        // Execute any async processes
        Test.stopTest();
        
        // Verify debug logs were created (optional if you have access to debug logs in tests)
        // You might need to modify this based on your org's setup
    }
    
    @isTest
    static void testFailedInstallation() {
        // Set up the mock HTTP response with error
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(false));
        
        Test.startTest();
        
        // Create a new instance of the install class
        PostInstallClass installScript = new PostInstallClass();
        
        // Create a mock InstallContext
        TestInstallContext mockContext = new TestInstallContext();
        
        // Execute the onInstall method
        installScript.onInstall(mockContext);
        
        Test.stopTest();
        
        // Add assertions as needed
    }
    
    // Mock InstallContext inner class
    public class TestInstallContext implements System.InstallContext {
        public ID organizationId() { 
            return UserInfo.getOrganizationId(); 
        }
        public ID installerId() { 
            return UserInfo.getUserId(); 
        }
        public Boolean isUpgrade() { 
            return false; 
        }
        public Boolean isPush() { 
            return false; 
        }
        public Version previousVersion() { 
            return null; 
        }
    }
    
    // Mock HTTP Response Generator
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        private Boolean isSuccess;
        
        public MockHttpResponseGenerator(Boolean isSuccess) {
            this.isSuccess = isSuccess;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            
            // Verify the request parameters
            System.assertEquals('POST', req.getMethod());
            System.assertEquals('application/json', req.getHeader('Content-Type'));
            System.assertEquals('https://rut.my.salesforce-sites.com/services/apexrest/getAPIKey', req.getEndpoint());
            
            if (isSuccess) {
                res.setStatusCode(200);
                res.setBody('MOCK_API_KEY_12345');
            } else {
                res.setStatusCode(500);
                res.setBody('Error processing request');
            }
            
            return res;
        }
    }

}