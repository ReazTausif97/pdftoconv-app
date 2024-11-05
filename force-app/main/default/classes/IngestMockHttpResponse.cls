@IsTest
global class IngestMockHttpResponse implements HttpCalloutMock {
    private Integer statusCode;
    private String body;

    // Constructor to set the status code and response body
    public IngestMockHttpResponse(Integer statusCode, String body) {
        this.statusCode = statusCode;
        this.body = body;
    }

    // Implement the respond method to return the mock HTTP response
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(statusCode);
        res.setBody(body);
        return res;
    }
}