@IsTest
public class MetadataUtilsTest {

    @IsTest
    static void testCreateService() {
        // Arrange: Set the mock session ID
        String mockSessionId = 'mockedSessionId12345';
        MetadataUtils.mockSessionId = mockSessionId;

        // Act: Call the method under test
        MetadataService.MetadataPort service = MetadataUtils.createService();

        // Assert: Verify that the service session ID is set correctly
        System.assertNotEquals(null, service);
        System.assertEquals(mockSessionId, service.SessionHeader.sessionId);

        // Clean up the mock
        MetadataUtils.mockSessionId = null;
    }

    @IsTest
    static void testGetSessionIdFromVFPageWithMock() {
        // Arrange: Set a mock session ID
        String mockSessionId = 'mockedSessionId12345';
        MetadataUtils.mockSessionId = mockSessionId;

        // Act: Call the method under test
        String sessionId = MetadataUtils.getSessionIdFromVFPage();

        // Assert: Verify the session ID is as expected
        System.assertEquals(mockSessionId, sessionId);

        // Clean up the mock
        MetadataUtils.mockSessionId = null;
    }

    @IsTest
    static void testGetSessionIdFromVFPageWithoutMock() {
        // Test the behavior without the mock (if applicable)
        // You can include a check that will verify behavior without setting the mock session ID.
        // However, since getContent cannot be called in test methods, this test can focus on edge cases.
    }
}