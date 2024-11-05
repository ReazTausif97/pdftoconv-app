public class MetadataService {
  public static String SOAP_M_URI = 'http://soap.sforce.com/2006/04/metadata';
  public static String endpoint_x = URL.getOrgDomainUrl().toExternalForm() + '/services/Soap/m/62.0';

  public virtual class Metadata {
    public String fullName;
  }
    public class EmbeddedServiceConfig extends Metadata {
     public String type = 'EmbeddedServiceConfig';
    public EmbeddedServiceMessagingChannel embeddedServiceMessagingChannel;
    public String fullName; // The unique name of the Embedded Service configuration
    public String masterLabel; // The label for the Embedded Service configuration
    public String site; // The name of the site where the Embedded Service is configured
    public Boolean isEnabled; // Indicates if the Embedded Service configuration is enabled
    
    public String deploymentFeature; // The deployment feature type (enumeration of string)
    public String deploymentType; // The deployment type (enumeration of string)
    public String embeddedServiceAppointmentSettings; // Settings for appointment scheduling

    private String[] fullName_type_info = new String[]{'fullName', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] masterLabel_type_info = new String[]{'masterLabel', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] site_type_info = new String[]{'site', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] isEnabled_type_info = new String[]{'isEnabled', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] deploymentFeature_type_info = new String[]{'deploymentFeature', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] deploymentType_type_info = new String[]{'deploymentType', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] embeddedServiceMessagingChannel_type_info = new String[]{'embeddedServiceMessagingChannel', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] embeddedServiceAppointmentSettings_type_info = new String[]{'embeddedServiceAppointmentSettings', SOAP_M_URI, null, '0', '1', 'false'};
    
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI, 'true', 'false'};
    private String[] type_att_info = new String[]{'xsi:type'};
    private String[] field_order_type_info = new String[]{'fullName', 'masterLabel', 'site', 'isEnabled', 'deploymentFeature', 'deploymentType', 'embeddedServiceAppointmentSettings','embeddedServiceMessagingChannel'};
}
    public class EmbeddedServiceMessagingChannel{
        
    public String businessHours; // Optional, type: string
    public Boolean isEnabled; // Required, type: boolean
    public String messagingChannel; // Required, type: string
    public Boolean shouldShowDeliveryReceipts; // Required, type: boolean
    public Boolean shouldShowEmojiSelection; // Required, type: boolean
    public Boolean shouldShowReadReceipts; // Required, type: boolean
    public Boolean shouldShowTypingIndicators; // Required, type: boolean
    public Boolean shouldStartNewLineOnEnter; // Required, type: boolean

    private String[] businessHours_type_info = new String[]{'businessHours', SOAP_M_URI, null, '0', '1', 'false'};
    private String[] isEnabled_type_info = new String[]{'isEnabled', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] messagingChannel_type_info = new String[]{'messagingChannel', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] shouldShowDeliveryReceipts_type_info = new String[]{'shouldShowDeliveryReceipts', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] shouldShowEmojiSelection_type_info = new String[]{'shouldShowEmojiSelection', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] shouldShowReadReceipts_type_info = new String[]{'shouldShowReadReceipts', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] shouldShowTypingIndicators_type_info = new String[]{'shouldShowTypingIndicators', SOAP_M_URI, null, '1', '1', 'false'};
    private String[] shouldStartNewLineOnEnter_type_info = new String[]{'shouldStartNewLineOnEnter', SOAP_M_URI, null, '1', '1', 'false'};
    
    private String[] apex_schema_type_info = new String[]{SOAP_M_URI, 'true', 'false'};
    private String[] field_order_type_info = new String[]{
        'businessHours', 'isEnabled', 'messagingChannel', 
        'shouldShowDeliveryReceipts', 'shouldShowEmojiSelection', 
        'shouldShowReadReceipts', 'shouldShowTypingIndicators', 'shouldStartNewLineOnEnter'
    };
        
    }
      public class Queue extends Metadata {
        public String type = 'Queue';
        public String fullName;
        private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
        public Boolean doesSendEmailToMembers;
        public String email;
        public String name;
        public MetadataService.QueueMembers queueMembers;
        public String queueRoutingConfig;
        public MetadataService.QueueSobject[] queueSobject;
        private String[] doesSendEmailToMembers_type_info = new String[]{'doesSendEmailToMembers',SOAP_M_URI,null,'0','1','false'};
        private String[] email_type_info = new String[]{'email',SOAP_M_URI,null,'0','1','false'};
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        private String[] queueMembers_type_info = new String[]{'queueMembers',SOAP_M_URI,null,'0','1','false'};
        private String[] queueRoutingConfig_type_info = new String[]{'queueRoutingConfig',SOAP_M_URI,null,'0','1','false'};
        private String[] queueSobject_type_info = new String[]{'queueSobject',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName', 'doesSendEmailToMembers','email','name','queueMembers','queueRoutingConfig','queueSobject'};
    }
      public class QueueMembers {
        public MetadataService.Users users;
        private String[] users_type_info = new String[]{'users',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'users'};
    }
     public class QueueSobject {
        public String sobjectType;
        private String[] sobjectType_type_info = new String[]{'sobjectType',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'sobjectType'};
    }
    public class Users {
        public String[] user_x;
        private String[] user_x_type_info = new String[]{'user',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'user_x'};
    }
    public class MessagingChannel extends Metadata {
    public String type = 'MessagingChannel';

    public String fullName; // The unique name of the Messaging Channel configuration
    public String masterLabel; // The label for the Messaging Channel
    public String messagingChannelType; // The type of Messaging Channel (e.g., EmbeddedMessaging, Voice)
    public String description; // The description of the Messaging Channel
    public String sessionHandlerFlow; // The Omni-Channel flow used to route the channel’s messaging sessions
    public String sessionHandlerQueue; // The fallback queue used if a sessionHandlerFlow cannot route messages
    public String sessionHandlerType; // The method used to route messages (e.g., Flow, Queue)

    private String[] fullName_type_info = new List<String>{
      'fullName',
      SOAP_M_URI,
      null,
      '0',
      '1',
      'false'
    };
    private String[] masterLabel_type_info = new List<String>{
      'masterLabel',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] messagingChannelType_type_info = new List<String>{
      'messagingChannelType',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] description_type_info = new List<String>{
      'description',
      SOAP_M_URI,
      null,
      '0',
      '1',
      'false'
    };
    private String[] sessionHandlerFlow_type_info = new List<String>{
      'sessionHandlerFlow',
      SOAP_M_URI,
      null,
      '0',
      '1',
      'false'
    };
    private String[] sessionHandlerQueue_type_info = new List<String>{
      'sessionHandlerQueue',
      SOAP_M_URI,
      null,
      '0',
      '1',
      'false'
    };
    private String[] sessionHandlerType_type_info = new List<String>{
      'sessionHandlerType',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };

    private String[] apex_schema_type_info = new List<String>{
      SOAP_M_URI,
      'true',
      'false'
    };
    private String[] type_att_info = new List<String>{ 'xsi:type' };
    private String[] field_order_type_info = new List<String>{
      'fullName',
      'masterLabel',
      'messagingChannelType',
      'description',
      'sessionHandlerFlow',
      'sessionHandlerQueue',
      'sessionHandlerType'
    };
}
 public class ExtendedErrorDetails {
        public String extendedErrorCode;
        private String[] extendedErrorCode_type_info = new String[]{'extendedErrorCode',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'extendedErrorCode'};
    }
  
  public class Error {
    public MetadataService.ExtendedErrorDetails[] extendedErrorDetails;
    public String[] fields;
    public String message;
    public String statusCode;
    private String[] extendedErrorDetails_type_info = new List<String>{
      'extendedErrorDetails',
      SOAP_M_URI,
      null,
      '0',
      '-1',
      'false'
    };
    private String[] fields_type_info = new List<String>{
      'fields',
      SOAP_M_URI,
      null,
      '0',
      '-1',
      'false'
    };
    private String[] message_type_info = new List<String>{
      'message',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] statusCode_type_info = new List<String>{
      'statusCode',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      SOAP_M_URI,
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'extendedErrorDetails',
      'fields',
      'message',
      'statusCode'
    };
  }

    public class createMetadataResponse_element {
        public MetadataService.SaveResult[] result;
        private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }

  public class createMetadata_element {
    public MetadataService.Metadata[] metadata;
    private String[] metadata_type_info = new List<String>{
      'metadata',
      SOAP_M_URI,
      null,
      '0',
      '-1',
      'false'

    };
    private String[] apex_schema_type_info = new List<String>{
      SOAP_M_URI,
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'metadata' };
  }

 

  public class SaveResult {
    public MetadataService.Error[] errors;
    public String fullName;
    public Boolean success;
    private String[] errors_type_info = new List<String>{
      'errors',
      SOAP_M_URI,
      null,
      '0',
      '-1',
      'false'
    };
    private String[] fullName_type_info = new List<String>{
      'fullName',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] success_type_info = new List<String>{
      'success',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      SOAP_M_URI,
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'errors',
      'fullName',
      'success'
    };
  }

  

  public class DeleteResult {
    public MetadataService.Error[] errors;
    public String fullName;
    public Boolean success;
    private String[] errors_type_info = new List<String>{
      'errors',
      SOAP_M_URI,
      null,
      '0',
      '-1',
      'false'
    };
    private String[] fullName_type_info = new List<String>{
      'fullName',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] success_type_info = new List<String>{
      'success',
      SOAP_M_URI,
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      SOAP_M_URI,
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'errors',
      'fullName',
      'success'
    };
  }
    
     public class deployResponse_element {
        public MetadataService.AsyncResult result;
        private String[] result_type_info = new String[]{'result',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
      public class deploy_element {
        public String ZipFile;
        public MetadataService.DeployOptions DeployOptions;
        private String[] ZipFile_type_info = new String[]{'ZipFile',SOAP_M_URI,null,'1','1','false'};
        private String[] DeployOptions_type_info = new String[]{'DeployOptions',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'ZipFile','DeployOptions'};
    }
       public class DeployOptions {
        public Boolean allowMissingFiles;
        public Boolean autoUpdatePackage;
        public Boolean checkOnly;
        public Boolean ignoreWarnings;
        public Boolean performRetrieve;
        public Boolean purgeOnDelete;
        public Boolean rollbackOnError;
        public String[] runTests;
        public Boolean singlePackage;
        public String testLevel;
        private String[] allowMissingFiles_type_info = new String[]{'allowMissingFiles',SOAP_M_URI,null,'1','1','false'};
        private String[] autoUpdatePackage_type_info = new String[]{'autoUpdatePackage',SOAP_M_URI,null,'1','1','false'};
        private String[] checkOnly_type_info = new String[]{'checkOnly',SOAP_M_URI,null,'1','1','false'};
        private String[] ignoreWarnings_type_info = new String[]{'ignoreWarnings',SOAP_M_URI,null,'1','1','false'};
        private String[] performRetrieve_type_info = new String[]{'performRetrieve',SOAP_M_URI,null,'1','1','false'};
        private String[] purgeOnDelete_type_info = new String[]{'purgeOnDelete',SOAP_M_URI,null,'1','1','false'};
        private String[] rollbackOnError_type_info = new String[]{'rollbackOnError',SOAP_M_URI,null,'1','1','false'};
        private String[] runTests_type_info = new String[]{'runTests',SOAP_M_URI,null,'0','-1','false'};
        private String[] singlePackage_type_info = new String[]{'singlePackage',SOAP_M_URI,null,'1','1','false'};
        private String[] testLevel_type_info = new String[]{'testLevel',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'allowMissingFiles','autoUpdatePackage','checkOnly','ignoreWarnings','performRetrieve','purgeOnDelete','rollbackOnError','runTests','singlePackage','testLevel'};
    }
    public MetadataService.AsyncResult deploy(String ZipFile,MetadataService.DeployOptions DeployOptions) {
            MetadataService.deploy_element request_x = new MetadataService.deploy_element();
            request_x.ZipFile = ZipFile;
            request_x.DeployOptions = DeployOptions;
            MetadataService.deployResponse_element response_x;
            Map<String, MetadataService.deployResponse_element> response_map_x = new Map<String, MetadataService.deployResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              SOAP_M_URI,
              'deploy',
              SOAP_M_URI,
              'deployResponse',
              'MetadataService.deployResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
    public class FlowRecordCreate extends FlowNode {
        public String type = 'FlowRecordCreate';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String description;
        public String name;
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        public String label;
        public Integer locationX;
        public Integer locationY;
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
        private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
        private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
        public String assignRecordIdToReference;
        public MetadataService.FlowConnector connector;
        public MetadataService.FlowConnector faultConnector;
        public MetadataService.FlowInputFieldAssignment[] inputAssignments;
        public String inputReference;
        public String object_x;
        private String[] assignRecordIdToReference_type_info = new String[]{'assignRecordIdToReference',SOAP_M_URI,null,'0','1','false'};
        private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
        private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
        private String[] inputAssignments_type_info = new String[]{'inputAssignments',SOAP_M_URI,null,'0','-1','false'};
        private String[] inputReference_type_info = new String[]{'inputReference',SOAP_M_URI,null,'0','1','false'};
        private String[] object_x_type_info = new String[]{'object',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'assignRecordIdToReference','connector','faultConnector','inputAssignments','inputReference','object_x'};
    }
        public class FlowInputFieldAssignment extends FlowBaseElement {
        public String type = 'FlowInputFieldAssignment';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String field;
        public MetadataService.FlowElementReferenceOrValue value;
        private String[] field_type_info = new String[]{'field',SOAP_M_URI,null,'1','1','false'};
        private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues', 'field','value'};
    }
      public class FlowConnector extends FlowBaseElement {
        public String type = 'FlowConnector';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String targetReference;
        private String[] targetReference_type_info = new String[]{'targetReference',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues', 'targetReference'};
    }
      public virtual class FlowNode extends FlowElement {
        public String label;
        public Integer locationX;
        public Integer locationY;
    }
     public virtual class FlowElement extends FlowBaseElement {
        public String description;
        public String name;
    }
      public virtual class FlowBaseElement {
        public MetadataService.FlowMetadataValue[] processMetadataValues;
    }
        public class FlowMetadataValue {
        public String name;
        public MetadataService.FlowElementReferenceOrValue value;
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'name','value'};
    }
         public class FlowElementReferenceOrValue {
        public Boolean booleanValue;
        public DateTime dateTimeValue;
        public Date dateValue;
        public String elementReference;
        public String setupReference;
        public String setupReferenceType;
        public Double numberValue;
        public String stringValue;
        private String[] booleanValue_type_info = new String[]{'booleanValue',SOAP_M_URI,null,'0','1','true'};
        private String[] dateTimeValue_type_info = new String[]{'dateTimeValue',SOAP_M_URI,null,'0','1','false'};
        private String[] dateValue_type_info = new String[]{'dateValue',SOAP_M_URI,null,'0','1','false'};
        private String[] elementReference_type_info = new String[]{'elementReference',SOAP_M_URI,null,'0','1','false'};
        private String[] setupReference_type_info = new String[]{'setupReference',SOAP_M_URI,null,'0','1','true'};
        private String[] setupReferenceType_type_info = new String[]{'setupReferenceType',SOAP_M_URI,null,'0','1','true'};

        private String[] numberValue_type_info = new String[]{'numberValue',SOAP_M_URI,null,'0','1','true'};
        private String[] stringValue_type_info = new String[]{'stringValue',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'booleanValue','dateTimeValue','dateValue','elementReference','numberValue','setupReference','setupReferenceType','stringValue'};
    }
       public class AsyncResult {
        public Boolean done;
        public String id;
        public String message;
        public String state;
        public String statusCode;
        private String[] done_type_info = new String[]{'done',SOAP_M_URI,null,'1','1','false'};
        private String[] id_type_info = new String[]{'id',SOAP_M_URI,null,'1','1','false'};
        private String[] message_type_info = new String[]{'message',SOAP_M_URI,null,'0','1','false'};
        private String[] state_type_info = new String[]{'state',SOAP_M_URI,null,'1','1','false'};
        private String[] statusCode_type_info = new String[]{'statusCode',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'done','id','message','state','statusCode'};
    }
    public class Flow extends Metadata {
        public String type = 'Flow';
        public String fullName;
        public Decimal apiVersion;
        private String[] fullName_type_info = new String[]{'fullName',SOAP_M_URI,null,'0','1','false'};
        public MetadataService.FlowActionCall[] actionCalls;
       // public MetadataService.FlowApexPluginCall[] apexPluginCalls;
        //public MetadataService.FlowAssignment[] assignments;
       // public MetadataService.FlowChoice[] choices;
       // public MetadataService.FlowConstant[] constants;
       // public MetadataService.FlowDecision[] decisions;
        public String description;
        //public MetadataService.FlowDynamicChoiceSet[] dynamicChoiceSets;
        //public MetadataService.FlowFormula[] formulas;
        public String interviewLabel;
        public String label;
       // public MetadataService.FlowLoop[] loops;
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        public String processType;
        //public MetadataService.FlowRecordCreate[] recordCreates;
       // public MetadataService.FlowRecordDelete[] recordDeletes;
       // public MetadataService.FlowRecordLookup[] recordLookups;
       // public MetadataService.FlowRecordUpdate[] recordUpdates;
        //public MetadataService.FlowScreen[] screens;
        //public MetadataService.FlowStage[] stages;
        public String startElementReference;
       // public MetadataService.FlowStep[] steps;
        //public MetadataService.FlowSubflow[] subflows;
        //public MetadataService.FlowTextTemplate[] textTemplates;
      public MetadataService.FlowVariable[] variables;
       // public MetadataService.FlowWait[] waits;
        private String[] actionCalls_type_info = new String[]{'actionCalls',SOAP_M_URI,null,'0','-1','false'};
        private String[] apexPluginCalls_type_info = new String[]{'apexPluginCalls',SOAP_M_URI,null,'0','-1','false'};
        private String[] assignments_type_info = new String[]{'assignments',SOAP_M_URI,null,'0','-1','false'};
        private String[] choices_type_info = new String[]{'choices',SOAP_M_URI,null,'0','-1','false'};
        private String[] constants_type_info = new String[]{'constants',SOAP_M_URI,null,'0','-1','false'};
        private String[] decisions_type_info = new String[]{'decisions',SOAP_M_URI,null,'0','-1','false'};
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
		private String[] apiVersion_type_info = new String[]{'apiVersion',SOAP_M_URI,null,'0','1','false'};
        private String[] dynamicChoiceSets_type_info = new String[]{'dynamicChoiceSets',SOAP_M_URI,null,'0','-1','false'};
        private String[] formulas_type_info = new String[]{'formulas',SOAP_M_URI,null,'0','-1','false'};
        private String[] interviewLabel_type_info = new String[]{'interviewLabel',SOAP_M_URI,null,'0','1','false'};
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
        private String[] loops_type_info = new String[]{'loops',SOAP_M_URI,null,'0','-1','false'};
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        private String[] processType_type_info = new String[]{'processType',SOAP_M_URI,null,'0','1','false'};
        private String[] recordCreates_type_info = new String[]{'recordCreates',SOAP_M_URI,null,'0','-1','false'};
        private String[] recordDeletes_type_info = new String[]{'recordDeletes',SOAP_M_URI,null,'0','-1','false'};
        private String[] recordLookups_type_info = new String[]{'recordLookups',SOAP_M_URI,null,'0','-1','false'};
        private String[] recordUpdates_type_info = new String[]{'recordUpdates',SOAP_M_URI,null,'0','-1','false'};
        private String[] screens_type_info = new String[]{'screens',SOAP_M_URI,null,'0','-1','false'};
        private String[] stages_type_info = new String[]{'stages',SOAP_M_URI,null,'0','-1','false'};
        private String[] startElementReference_type_info = new String[]{'startElementReference',SOAP_M_URI,null,'0','1','false'};
        private String[] steps_type_info = new String[]{'steps',SOAP_M_URI,null,'0','-1','false'};
        private String[] subflows_type_info = new String[]{'subflows',SOAP_M_URI,null,'0','-1','false'};
        private String[] textTemplates_type_info = new String[]{'textTemplates',SOAP_M_URI,null,'0','-1','false'};
        private String[] variables_type_info = new String[]{'variables',SOAP_M_URI,null,'0','-1','false'};
        private String[] waits_type_info = new String[]{'waits',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'fullName','apiVersion', 'actionCalls','description','interviewLabel','label','processMetadataValues','processType','startElementReference','variables'};
    }

    // Flow Variable metadata class
   public class FlowVariable extends FlowElement {
        public String type = 'FlowVariable';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String description;
        public String name;
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        public String dataType;
        public Boolean isCollection;
        public Boolean isInput;
        public Boolean isOutput;
        public String objectType;
        public Integer scale;
        public MetadataService.FlowElementReferenceOrValue value;
        private String[] dataType_type_info = new String[]{'dataType',SOAP_M_URI,null,'1','1','false'};
        private String[] isCollection_type_info = new String[]{'isCollection',SOAP_M_URI,null,'0','1','false'};
        private String[] isInput_type_info = new String[]{'isInput',SOAP_M_URI,null,'0','1','false'};
        private String[] isOutput_type_info = new String[]{'isOutput',SOAP_M_URI,null,'0','1','false'};
        private String[] objectType_type_info = new String[]{'objectType',SOAP_M_URI,null,'0','1','false'};
        private String[] scale_type_info = new String[]{'scale',SOAP_M_URI,null,'0','1','false'};
        private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues','description','name', 'dataType','isCollection','isInput','isOutput','objectType','scale','value'};
    }

    public class FlowScreen extends FlowNode {
        public String type = 'FlowScreen';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String description;
        public String name;
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        public String label;
        public Integer locationX;
        public Integer locationY;
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
        private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
        private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
        public Boolean allowBack;
        public Boolean allowFinish;
        public Boolean allowPause;
        public MetadataService.FlowConnector connector;
        public MetadataService.FlowScreenField[] fields;
        public String helpText;
        public String pausedText;
       // public MetadataService.FlowScreenRule[] rules;
        public Boolean showFooter;
        public Boolean showHeader;
        private String[] allowBack_type_info = new String[]{'allowBack',SOAP_M_URI,null,'0','1','false'};
        private String[] allowFinish_type_info = new String[]{'allowFinish',SOAP_M_URI,null,'0','1','false'};
        private String[] allowPause_type_info = new String[]{'allowPause',SOAP_M_URI,null,'0','1','false'};
        private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
        private String[] fields_type_info = new String[]{'fields',SOAP_M_URI,null,'0','-1','false'};
        private String[] helpText_type_info = new String[]{'helpText',SOAP_M_URI,null,'0','1','false'};
        private String[] pausedText_type_info = new String[]{'pausedText',SOAP_M_URI,null,'0','1','false'};
        private String[] rules_type_info = new String[]{'rules',SOAP_M_URI,null,'0','-1','false'};
        private String[] showFooter_type_info = new String[]{'showFooter',SOAP_M_URI,null,'0','1','false'};
        private String[] showHeader_type_info = new String[]{'showHeader',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'allowBack','allowFinish','allowPause','connector','fields','helpText','pausedText','rules','showFooter','showHeader'};
    }

    // Flow Screen Field metadata class
    public class FlowScreenField {
        public String name;
        public String fieldType;
        public String label;
        public Boolean isRequired;
    }
    
  public class FlowActionCall extends FlowNode {
        public String type = 'FlowActionCall';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String description;
        public String name;
        private String[] description_type_info = new String[]{'description',SOAP_M_URI,null,'0','1','false'};
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        public String label;
        public Integer locationX;
        public Integer locationY;
        private String[] label_type_info = new String[]{'label',SOAP_M_URI,null,'1','1','false'};
        private String[] locationX_type_info = new String[]{'locationX',SOAP_M_URI,null,'1','1','false'};
        private String[] locationY_type_info = new String[]{'locationY',SOAP_M_URI,null,'1','1','false'};
        public String actionName;
        public String actionType;
        public MetadataService.FlowConnector connector;
        public MetadataService.FlowConnector faultConnector;
        public MetadataService.FlowActionCallInputParameter[] inputParameters;
        //public MetadataService.FlowActionCallOutputParameter[] outputParameters;
        private String[] actionName_type_info = new String[]{'actionName',SOAP_M_URI,null,'1','1','false'};
        private String[] actionType_type_info = new String[]{'actionType',SOAP_M_URI,null,'1','1','false'};
        private String[] connector_type_info = new String[]{'connector',SOAP_M_URI,null,'0','1','false'};
        private String[] faultConnector_type_info = new String[]{'faultConnector',SOAP_M_URI,null,'0','1','false'};
        private String[] inputParameters_type_info = new String[]{'inputParameters',SOAP_M_URI,null,'0','-1','false'};
        private String[] outputParameters_type_info = new String[]{'outputParameters',SOAP_M_URI,null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues','description','name','label','locationX','locationY', 'actionName','actionType','connector','faultConnector','inputParameters'};
    }

    // Flow Action Call Input Parameter metadata class
    public class FlowActionCallInputParameter extends FlowBaseElement {
        public String type = 'FlowActionCallInputParameter';
        public MetadataService.FlowMetadataValue[] processMetadataValues;
        private String[] processMetadataValues_type_info = new String[]{'processMetadataValues',SOAP_M_URI,null,'0','-1','false'};
        public String name;
        public MetadataService.FlowElementReferenceOrValue value;
        private String[] name_type_info = new String[]{'name',SOAP_M_URI,null,'1','1','false'};
        private String[] value_type_info = new String[]{'value',SOAP_M_URI,null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] type_att_info = new String[]{'xsi:type'};
        private String[] field_order_type_info = new String[]{'processMetadataValues', 'name','value'};
    }

    // Flow Assignment metadata class (used to assign values to variables)
    public class FlowAssignment {
        public String name;
        public List<FlowAssignmentItem> assignmentItems;
    }

    // Flow Assignment Item metadata class (each assignment in the Assignment step)
    public class FlowAssignmentItem {
        public String variable;
        public String value;
    }

    // Flow Decision metadata class
    public class FlowDecision {
        public String name;
        public List<FlowDecisionOutcome> outcomes;
    }

    // Flow Decision Outcome metadata class (each outcome of the decision step)
    public class FlowDecisionOutcome {
        public String label;
        public String conditionLogic;
        public List<FlowCondition> conditions;
    }

    // Flow Condition metadata class (conditions for decision outcomes)
    public class FlowCondition {
        public String leftValue;
        public String operator;
        public String rightValue;
    }

    // Flow Start Element metadata class (Start element configuration for the flow)
    public class FlowStartElement {
        public String name;
        public String startType;
    }

 public class SessionHeader_element {
        public String sessionId;
        private String[] sessionId_type_info = new String[]{'sessionId',SOAP_M_URI,null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{SOAP_M_URI,'true','false'};
        private String[] field_order_type_info = new String[]{'sessionId'};
    }

   public class MetadataPort {
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public MetadataService.SessionHeader_element SessionHeader;
        //public MetadataService.DebuggingInfo_element DebuggingInfo;
        //public MetadataService.DebuggingHeader_element DebuggingHeader;
        //public MetadataService.CallOptions_element CallOptions;
       // public MetadataService.AllOrNoneHeader_element AllOrNoneHeader;
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/2006/04/metadata';
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/2006/04/metadata';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/2006/04/metadata';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/2006/04/metadata';
        private String AllOrNoneHeader_hns = 'AllOrNoneHeader=http://soap.sforce.com/2006/04/metadata';
        private String[] ns_map_type_info = new String[]{SOAP_M_URI, 'MetadataService'};
    
       
        public MetadataService.SaveResult[] createMetadata(MetadataService.Metadata[] metadata) {
            MetadataService.createMetadata_element request_x = new MetadataService.createMetadata_element();
            request_x.metadata = metadata;
            MetadataService.createMetadataResponse_element response_x;
            Map<String, MetadataService.createMetadataResponse_element> response_map_x = new Map<String, MetadataService.createMetadataResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              SOAP_M_URI,
              'createMetadata',
              SOAP_M_URI,
              'createMetadataResponse',
              'MetadataService.createMetadataResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
       
    }
}