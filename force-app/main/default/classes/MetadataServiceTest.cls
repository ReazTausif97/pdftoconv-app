@isTest
public class MetadataServiceTest {
		private class WebServiceMockImpl implements WebServiceMock 
	{
		public void doInvoke(
			Object stub, Object request, Map<String, Object> response,
			String endpoint, String soapAction, String requestName,
			String responseNS, String responseName, String responseType) 
		{
             if(request instanceof  MetadataService.createMetadata_element)
                response.put('response_x', new MetadataService.createMetadataResponse_element());
			return;
		}
	}
	@IsTest
	private static void coverGeneratedCodeCRUDOperations()
	{	
    	// Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations     
        Test.startTest();    
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        Test.stopTest();
	}  
     @IsTest
    private static void coverGeneratedCodeFileBasedOperations2()
    {       
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations     
        Test.startTest();    
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        metaDataPort.createMetadata(null);
        Test.stopTest();
    }
    
        
	@IsTest
    private static void coverGeneratedCodeTypes()
    {    	       
        // Reference types
        Test.startTest();
        new MetadataService();
        new MetadataService.Queue();
        new MetadataService.QueueMembers();
        new MetadataService.QueueSobject();
        new MetadataService.Users();
        new MetadataService.SessionHeader_element();
        new MetadataService.MessagingChannel();
        new MetadataService.ExtendedErrorDetails();
        new MetadataService.Error();
        new MetadataService.createMetadataResponse_element();
        
        new MetadataService.createMetadata_element();
        new MetadataService.EmbeddedServiceConfig();
         new MetadataService.SaveResult();
         new MetadataService.DeleteResult();
         new MetadataService.MetadataPort();
        
        Test.stopTest();
        
    }

    
    /*@IsTest
     * private static void testMessagingChannelCreation() {
        // Mocking web service call
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Creating MetadataService instance
        MetadataService.MetadataPort metadataPort = new MetadataService.MetadataPort();
        MetadataService.MessagingChannel messagingChannel = new MetadataService.MessagingChannel();
 		 messagingChannel.fullName = 'TestChannel1';  // Unique API name for the messaging channel
        messagingChannel.masterLabel = 'Test Channel1';  // User-friendly label for the messaging channel
        messagingChannel.messagingChannelType = 'EmbeddedMessaging';  // Type of messaging channel
        messagingChannel.description = 'This is a sample Messaging Channel for Embedded Messaging';  // Description
        messagingChannel.sessionHandlerFlow = 'PDFtoConv__PTC_Bot_Flow';  // Omni-Channel flow used for routing sessions
        messagingChannel.sessionHandlerQueue = 'PDFtoConv__MyQueue';  // Fallback queue if flow cannot route messages
        messagingChannel.sessionHandlerType = 'Flow';  // The method used to route messages ('Flow' or 'Queue')

        // Begin test
        Test.startTest();
        MetadataService.SaveResult[] saveResults = metadataPort.createMetadata(
            new MetadataService.MessagingChannel[] { messagingChannel }
        );
        Test.stopTest();

        // Asserts to verify that the Metadata creation was successful
        System.assertNotEquals(null, saveResults);
        System.assert(saveResults[0].success, 'Messaging Channel creation failed!');
    }

    @IsTest
    private static void testEmbeddedServiceConfigCreation() {
        // Mocking web service call
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Creating MetadataService instance
        MetadataService.MetadataPort metadataPort = new MetadataService.MetadataPort();
        MetadataService.EmbeddedServiceMessagingChannel messagingChannel = new MetadataService.EmbeddedServiceMessagingChannel();
            messagingChannel.businessHours = 'Default';
            messagingChannel.isEnabled = true;
            messagingChannel.messagingChannel = 'My_Test_Channel';
            messagingChannel.shouldShowDeliveryReceipts = false;
            messagingChannel.shouldShowEmojiSelection = false;
            messagingChannel.shouldShowReadReceipts = false;
            messagingChannel.shouldShowTypingIndicators = false;
            messagingChannel.shouldStartNewLineOnEnter = false;
            // Create EmbeddedServiceConfig object
            MetadataService.EmbeddedServiceConfig embeddedConfig = new MetadataService.EmbeddedServiceConfig();
            embeddedConfig.fullName = 'Test_Embedded_Service_Config';
            embeddedConfig.masterLabel = 'test deployment';
            embeddedConfig.site = 'election_commission_bot1';
            embeddedConfig.isEnabled = true;
            embeddedConfig.deploymentFeature = 'EmbeddedMessaging';
            embeddedConfig.deploymentType = 'Web';
       		embeddedConfig.embeddedServiceMessagingChannel=messagingChannel;  

 

        // Begin test
        Test.startTest();
        MetadataService.SaveResult[] saveResults = metadataPort.createMetadata(
            new MetadataService.EmbeddedServiceConfig[] { embeddedConfig }
        );
        Test.stopTest();

        // Asserts to verify that the Metadata creation was successful
        System.assertNotEquals(null, saveResults);
        System.assert(saveResults[0].success, 'Embedded Service Config creation failed!');
    }*/
}