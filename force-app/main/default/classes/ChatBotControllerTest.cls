@IsTest
public class ChatBotControllerTest {

    @IsTest
    static void testSendMessage_Success() {
        // Set up the mock response for the HTTP callout
        Test.setMock(HttpCalloutMock.class, new ChatBotMockHttpResponse(200, '{"content": "Test answer from bot"}'));

        // Insert required test data for SecretKey__c and KnowledgeBase__c
        SecretKey__c secretKey = new SecretKey__c(Name = 'Secret Key', Key__c = 'testKey');
        insert secretKey;

        KnowledgeBase__c knowledgeBase = new KnowledgeBase__c(Name = 'Knowledge Article', File_Source_Id__c = 'testSourceId');
        insert knowledgeBase;

        // Prepare the input for the Invocable method
        List<String> queries = new List<String>{ 'Test query' };

        // Execute the method
        Test.startTest();
        List<ChatBotController.BotResponse> response = ChatBotController.sendMessage(queries);
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, response.size(), 'Expected one response');
        System.assertEquals('Test answer from bot', response[0].answer, 'The bot answer should match the mock response');
    }

   /* @IsTest
    static void testSendMessage_ErrorResponse() {
        // Simulate an error response from the external API
        Test.setMock(HttpCalloutMock.class, new ChatBotMockHttpResponse(500, ''));

        // Insert required test data for SecretKey__c and KnowledgeBase__c
        SecretKey__c secretKey = new SecretKey__c(Name = 'Secret Key', Key__c = 'testKey');
        insert secretKey;

        KnowledgeBase__c knowledgeBase = new KnowledgeBase__c(Name = 'Knowledge Article', File_Source_Id__c = 'testSourceId');
        insert knowledgeBase;

        // Prepare the input for the Invocable method
        List<String> queries = new List<String>{ 'Test query' };

        // Execute the method
        Test.startTest();
        List<ChatBotController.BotResponse> response = ChatBotController.sendMessage(queries);
        Test.stopTest();

        // Verify that the error message is handled correctly
        System.assertEquals(1, response.size(), 'Expected one response');
        System.assert(response[0].answer.startsWith('Error: 500'), 'Expected error response');
    }*/

    
}