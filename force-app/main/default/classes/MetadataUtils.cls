public class MetadataUtils {

    @TestVisible
    static String mockSessionId = null;

    // Method to create MetadataService with default settings
    public static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = getSessionIdFromVFPage();
        return service;
    }

    public static String getSessionIdFromVFPage() {
        if (mockSessionId != null) {
            return mockSessionId;
        }

        String content = Page.UserSessionPage.getContent().toString();
        Integer s = content.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
                e = content.indexOf('End_Of_Session_Id');
        return content.substring(s, e);
    }
}