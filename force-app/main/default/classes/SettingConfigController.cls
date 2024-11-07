public class SettingConfigController {
    public static String serviceChannelId=[Select Id From ServiceChannel Where MasterLabel='Messaging'].Id;
    public static String queueId;
    public static String botId=[Select Id from BotDefinition where MasterLabel='PTC Bot'].Id;
    @AuraEnabled 
    public static void createChannelandQueue(){
         MetadataService.MetadataPort service = MetadataUtils.createService();
       	 createQueue(service);
         queueId = [Select Id from Group where type='Queue' and Name='PTC Bot Queue'].Id;  
        createFlow(service);
         createMessagingChannel(service);
        //createESD(service);
    }
    
    public static void createQueue(MetadataService.MetadataPort service) {
        try {
            // Initialize MetadataService
           // MetadataService.MetadataPort service = MetadataUtils.createService();
            
            // Create Embedded Service Config metadata
            MetadataService.Queue queue = new MetadataService.Queue();            
            queue.fullName = 'PTCBotQueue';  // Unique API name for the queue
            queue.name = 'PTC Bot Queue';  // User-friendly label for the queue
            queue.queueRoutingConfig='PDFtoConv__PTC_Bot';
           
            // Define the Queue SObject for the queue (e.g., Case)
            MetadataService.QueueSobject messagingSObject = new MetadataService.QueueSobject();
            messagingSObject.sobjectType = 'MessagingSession';  // Specify the SObject type

            // Add the SObject type to the queue
            queue.queueSobject = new MetadataService.QueueSobject[] { messagingSObject };

            // Define the Queue Members (users)
            MetadataService.QueueMembers queueMembers = new MetadataService.QueueMembers();
            queueMembers.users = new MetadataService.Users();
            queueMembers.users.user_x = new String[]{getUserName()};  // Example user ID

            // Add the members to the queue
            queue.queueMembers = queueMembers;

            List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { queue });

            // Handle the result and check for success or errors
           MetadataService.SaveResult saveResult = results[0];
            // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                System.debug(String.join(messages, ' '));
        }
        if(!saveResult.success)
            System.debug('Request failed with no specified error.');
        } catch (Exception e) {
            // Handle any exceptions and log the error
            System.debug('Callout failed: ' + e.getMessage());
        }
    }
    public static String getUserName(){
        List<User> userName = [SELECT Id,UserName FROM User WHERE Profile.Name = 'System Administrator' AND UserType = 'Standard' AND IsActive = TRUE AND Profile.UserLicense.Name IN ('Salesforce', 'Salesforce Platform')];
        return userName[0].UserName;
    }
     public static void createMessagingChannel(MetadataService.MetadataPort service) {
    try {
        // Initialize MetadataService
       // MetadataService.MetadataPort service = createService();

        // Create MessagingChannel metadata
        MetadataService.MessagingChannel messagingChannel = new MetadataService.MessagingChannel();

        // Set the necessary properties for the MessagingChannel
        messagingChannel.fullName = 'PDFtoConversationChannel';  // Unique API name for the messaging channel
        messagingChannel.masterLabel = 'PDF to Conversation Channel';  // User-friendly label for the messaging channel
        messagingChannel.messagingChannelType = 'EmbeddedMessaging';  // Type of messaging channel
        messagingChannel.description = 'This is a sample Messaging Channel for Embedded Messaging';  // Description
        messagingChannel.sessionHandlerFlow = 'PTC_Bot_Flow';  // Omni-Channel flow used for routing sessions
        messagingChannel.sessionHandlerQueue = 'PTCBotQueue';  // Fallback queue if flow cannot route messages
        messagingChannel.sessionHandlerType = 'Flow';  // The method used to route messages ('Flow' or 'Queue')
 List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { messagingChannel });

            // Handle the result and check for success or errors
           MetadataService.SaveResult saveResult = results[0];
            // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                System.debug(String.join(messages, ' '));
        }
        if(!saveResult.success)
            System.debug('Request failed with no specified error.');

    } catch (Exception e) {
        // Handle any exceptions and log the error
        System.debug('Callout failed: ' + e.getMessage());
    }
    }
    
    public static void createFlow(MetadataService.MetadataPort service)
    {
    try{
    MetadataService.Flow flow = new MetadataService.Flow();
    flow.fullName = 'PTC_Bot_Flow';
    flow.description = 'Omni-Channel Routing Flow with Route Work Action';
    flow.label = 'PTC Bot Flow';
    flow.processType = 'RoutingFlow';  // Set process type for Omni-Flow
    
	MetadataService.FlowVariable recordIdVariable = new MetadataService.FlowVariable();
    recordIdVariable.name = 'recordId';  // API name of the flow variable
    recordIdVariable.dataType = 'String';  // Data type for record ID
    recordIdVariable.isInput = true;  // Set as input variable if needed
    recordIdVariable.isOutput = false;  // Not an output variable
    // Create Route Work Action
    flow.variables= new List<MetadataService.FlowVariable> {recordIdVariable};
    MetadataService.FlowActionCall routeWorkAction = new MetadataService.FlowActionCall();
 	routeWorkAction.locationX = 200;
    routeWorkAction.locationY = 100;
 	routeWorkAction.name = 'TestRouteWork';
    routeWorkAction.label = 'Route Work Test';  
    routeWorkAction.actionName = 'routeWork';
	routeWorkAction.actionType='routeWork';
	MetadataService.FlowActionCallInputParameter recordIdParam = new MetadataService.FlowActionCallInputParameter();
    recordIdParam.name = 'recordId';
    recordIdParam.value = new MetadataService.FlowElementReferenceOrValue();
    recordIdParam.value.elementReference='recordId'; 
    // 2. Service Channel (e.g., messaging or chat)
    MetadataService.FlowActionCallInputParameter serviceChannelIdParam = new MetadataService.FlowActionCallInputParameter();
    serviceChannelIdParam.name = 'serviceChannelId';
    serviceChannelIdParam.value = new MetadataService.FlowElementReferenceOrValue();
    serviceChannelIdParam.value.stringValue = serviceChannelId;  
           
           
    MetadataService.FlowActionCallInputParameter serviceChannelParam = new MetadataService.FlowActionCallInputParameter();
    serviceChannelParam.name = 'serviceChannelLabel';
    serviceChannelParam.value = new MetadataService.FlowElementReferenceOrValue();
    serviceChannelParam.value.stringValue = 'Messaging'; 
   //serviceChannelParam.value.setupReferenceType='ServiceChannel';
      
        // Service Channel Developer Name
	MetadataService.FlowActionCallInputParameter serviceChannelDeveloperNameParam = new MetadataService.FlowActionCallInputParameter();
    serviceChannelDeveloperNameParam.name = 'serviceChannelDevName';
    serviceChannelDeveloperNameParam.value = new MetadataService.FlowElementReferenceOrValue();
    serviceChannelDeveloperNameParam.value.stringValue = 'sfdc_livemessage';

	MetadataService.FlowActionCallInputParameter routingTypeParam = new MetadataService.FlowActionCallInputParameter();
    routingTypeParam.name = 'routingType';
    routingTypeParam.value = new MetadataService.FlowElementReferenceOrValue();
    routingTypeParam.value.stringValue = 'Bot';
        
        
   	MetadataService.FlowActionCallInputParameter queueIdParam = new MetadataService.FlowActionCallInputParameter();
    queueIdParam.name = 'queueId';
    queueIdParam.value = new MetadataService.FlowElementReferenceOrValue();
    queueIdParam.value.stringValue = queueId;
        
        
    MetadataService.FlowActionCallInputParameter queueLabelParam = new MetadataService.FlowActionCallInputParameter();
    queueLabelParam.name = 'queueLabel';
    queueLabelParam.value = new MetadataService.FlowElementReferenceOrValue();
    queueLabelParam.value.stringValue = 'PTC Bot Queue';
        
    MetadataService.FlowActionCallInputParameter botIdParam = new MetadataService.FlowActionCallInputParameter();
    botIdParam.name = 'botId';
    botIdParam.value = new MetadataService.FlowElementReferenceOrValue();
    botIdParam.value.stringValue =botId;
        
        
    MetadataService.FlowActionCallInputParameter botLabelParam = new MetadataService.FlowActionCallInputParameter();
    botLabelParam.name = 'botLabel';
    botLabelParam.value = new MetadataService.FlowElementReferenceOrValue();
    botLabelParam.value.stringValue = 'PTC Bot';
        
      
    routeWorkAction.inputParameters = new List<MetadataService.FlowActionCallInputParameter> {
        recordIdParam ,serviceChannelIdParam, serviceChannelParam,serviceChannelDeveloperNameParam,botLabelParam,botIdParam,queueLabelParam,queueIdParam,routingTypeParam
    };
      // Add Route Work Action to the Flow
    flow.actionCalls = new List<MetadataService.FlowActionCall> { routeWorkAction };

    // Optional: Set the start element for the flow to the Route Work action
    flow.startElementReference = 'TestRouteWork';

    // Save the flow using the Metadata API
    MetadataService.SaveResult saveResult = service.createMetadata(new List<MetadataService.Metadata> { flow })[0];

    // Handle the save result and possible errors
    if (saveResult == null || saveResult.success) {
        System.debug('Flow with Route Work action created successfully: ' + flow.fullName);
        return;
    }

    // If errors, process them and log
    if (saveResult.errors != null) {
        List<String> messages = new List<String>();
        messages.add((saveResult.errors.size() == 1 ? 'Error ' : 'Errors ') + 'occurred processing component ' + saveResult.fullName + '.');
        for (MetadataService.Error error : saveResult.errors) {
            messages.add(error.message + ' (' + error.statusCode + ').' + (error.fields != null && error.fields.size() > 0 ? ' Fields ' + String.join(error.fields, ',') + '.' : ''));
        }
        if (messages.size() > 0) {
            System.debug(String.join(messages, ' '));
        }
    }

    if (!saveResult.success) {
        System.debug('Request failed with no specified error.');
    }
    }
    catch(exception e)
    {
        System.debug('error: '+e);
    }
    }
    
    
    /*public static void createESD(MetadataService.MetadataPort service){
        try {
           
            MetadataService.EmbeddedServiceMessagingChannel messagingChannel = new MetadataService.EmbeddedServiceMessagingChannel();
            messagingChannel.businessHours = 'Default';
            messagingChannel.isEnabled = true;
            messagingChannel.messagingChannel = 'SetupTestChannel';
            messagingChannel.shouldShowDeliveryReceipts = false;
            messagingChannel.shouldShowEmojiSelection = false;
            messagingChannel.shouldShowReadReceipts = false;
            messagingChannel.shouldShowTypingIndicators = false;
            messagingChannel.shouldStartNewLineOnEnter = false;
            // Create EmbeddedServiceConfig object
            MetadataService.EmbeddedServiceConfig embeddedServiceConfig = new MetadataService.EmbeddedServiceConfig();
            embeddedServiceConfig.fullName = 'Setup_Test_Embedded_Service_Config';
            embeddedServiceConfig.masterLabel = 'Setup Test Deployment';
            embeddedServiceConfig.site = 'Setup_Test_Site1';
            embeddedServiceConfig.isEnabled = true;
            embeddedServiceConfig.deploymentFeature = 'EmbeddedMessaging';
            embeddedServiceConfig.deploymentType = 'Web';
       		embeddedServiceConfig.embeddedServiceMessagingChannel=messagingChannel;          
            // Save the Embedded Service Config using Metadata API
            MetadataService.SaveResult[] saveResults = service.createMetadata(
                new List<MetadataService.Metadata>{embeddedServiceConfig});
            MetadataService.SaveResult saveResult = saveResults[0];
            
            // Handle the save result and possible errors
            if (saveResult.success) {
                System.debug('Embedded Service Config created successfully: ' + embeddedServiceConfig.fullName);
            } else {
               System.debug('Error saving metadata');
            }
        } catch (Exception e) {
            System.debug('Error creating Embedded Service Config: ' + e.getMessage());
        }
    }*/
     @AuraEnabled 
    public static String getPermissionSetId(){
         List<PermissionSet> permRes = [Select Id,Name from PermissionSet where Name='sfdc_chatbot_service_permset'];
         String permId = permRes[0]?.Id;
        if(permId!='')
        {
            permId= permId.left(permId.length()-3);
        }
        	
        
         return permId;
    }
}