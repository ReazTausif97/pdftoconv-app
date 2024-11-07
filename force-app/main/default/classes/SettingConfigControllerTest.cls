@IsTest
public class SettingConfigControllerTest {

    @TestSetup
    static void setupTestData() {
        // Create a mock ServiceChannel record

        // Create a mock User for queue membership
        User testUser = [SELECT Id, Username FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];

        // Create mock Metadata API responses if required
    }

   @isTest
    static void testGetPermissionSetId(){
        /*PermissionSet testPermSet  = new PermissionSet(Name='sfdc_chatbot_service_permset',Label='Chatbot');
       
        insert testPermSet;*/
         Test.startTest();
        String result = settingConfigController.getPermissionSetId();
        
        String expectedId = [Select Id from PermissionSet where Name='sfdc_chatbot_service_permset'].Id;
        expectedId= expectedId.left(expectedId.length()-3);
        Test.stopTest();
        System.assertEquals(expectedId, result, 'The returned permission set id does not match the expected value.');
        
    }

    @IsTest
    static void testCreateQueue() {
        Test.startTest();

        // Mocking MetadataService
        MetadataService.MetadataPort mockService = new MetadataService.MetadataPort();

        // Call the method under test
        settingConfigController.createQueue(mockService);

        // Validate the expected behavior, e.g., checking if a queue was created in the Metadata API

        Test.stopTest();
    }

    @IsTest
    static void testCreateFlow() {
        Test.startTest();

        // Mock MetadataService interactions
        MetadataService.MetadataPort mockService = new MetadataService.MetadataPort();

        // Call the method under test
        settingConfigController.createFlow(mockService);

        // Add assertions to check if the flow was correctly created in the Metadata API

        Test.stopTest();
    }

    @IsTest
    static void testCreateMessagingChannel() {
        Test.startTest();

        // Mock MetadataService interactions
        MetadataService.MetadataPort mockService = new MetadataService.MetadataPort();

        // Call the method under test
        settingConfigController.createMessagingChannel(mockService);

        // Validate that the messaging channel was created and check the outcome

        Test.stopTest();
    }

    /*@IsTest
    static void testCreateESD() {
        Test.startTest();

        // Mock MetadataService interactions
        MetadataService.MetadataPort mockService = new MetadataService.MetadataPort();

        // Call the method under test
        settingConfigController.createESD(mockService);

        // Validate the Embedded Service Config creation
        Test.stopTest();
    }*/
}