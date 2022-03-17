@isTest
public  class CalloutMock implements HttpCalloutMock  {

    public Integer responseCode;
    public String  responseBody;
    public String  responseStatus;

    public CalloutMock(String responseStatus,String responseBody,Integer responseCode){
        this.responseCode = responseCode;
        this.responseBody = responseBody;
        this.responseStatus = responseStatus;

    }

    public HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse response = new HttpResponse();

        String endpoint = req.getEndpoint();
        response.setStatusCode(this.responseCode);
        response.setBody(this.responseBody);
        response.setStatus(this.responseStatus);

        return response;
    }



}
