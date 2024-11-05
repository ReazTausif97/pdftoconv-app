global with sharing class ChatBotController {
    /**
     * @description Represents the bot's response to the user's query.
     */
    global class BotResponse {
        @InvocableVariable(
            label='Bot Response'
            description='The answer returned from bot'
        )
        global String answer;
    }
	
    /**
     * @description Sends the user's queries to the external chatbot API and retrieves the response.
     * @param queries The user's queries.
     * @return List<BotResponse> The response from the chatbot.
     */
    @InvocableMethod(label='Send Message' description='Send users queries')
    global static List<BotResponse> sendMessage(List<String> queries) {
         List<BotResponse> botRes = new List<BotResponse>();
        BotResponse obj = new BotResponse();
        botRes.add(obj);

        try {
            SecretKey__c secretKey = SecretKey__c.getInstance('Secret Key');
            KnowledgeBase__c article = KnowledgeBase__c.getInstance('Knowledge Article');

            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.chatpdf.com/v1/chats/message');
            req.setMethod('POST');

            req.setHeader('x-api-key', secretKey.Key__c);
            req.setHeader('Content-Type', 'application/json');

            String requestBody = '{"sourceId": "' + article.File_Source_Id__c + '", "messages": [{"role": "user", "content": "' + queries[0] + '. Please do not use information from elsewhere, like internet, and answer solely on the basis of the pdf that is provided. If you are not confident about an answer, clearly state that and do not provide pretentious answer. ' + '"}]}';
            req.setBody(requestBody);

            // Send the request and handle the response
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                if (responseBody.containsKey('content')) {
                    botRes[0].answer = (String) responseBody.get('content');
                } else {
                    botRes[0].answer = 'Error: Response does not contain content';
                }
            } else {
                botRes[0].answer = 'Error: ' + res.getStatus() + ' ' + res.getStatusCode();
            }
        } catch (Exception e) {
            botRes[0].answer = 'Exception: ' + e.getMessage();
        }

        return botRes;
    }

    @AuraEnabled
    public static String getBotResponse(String query) {
        List<String> queries = new List<String>{ query };
        List<BotResponse> responses = sendMessage(queries);
        if (!responses.isEmpty()) {
            return responses[0].answer;
        }
        return 'No response from bot';
    }
    
     
}