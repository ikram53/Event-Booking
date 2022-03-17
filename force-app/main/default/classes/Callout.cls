public with sharing class Callout {
 

    public static final String HEADER_CONTENT_TYPE     = 'Content-Type';
    public static final String APPLICATION_CONTENT_TYPE = 'application/json;charset=UTF-8';
    public static final String WEB_SERVICE_URL = 'callout:webServiceUrl';
    public static final String POST_METHOD     = 'POST';
    public static final Integer HTTPCODE_OK             = 201;
    public static final Integer HTTPCODE_ERRREQ         = 400;
    public static final String  HTTPSTATUS_KO          = 'KO';
    public static final String  HTTPSTATUS_OK          = 'OK';
    public static final String  HTTPSTATUS_ERRREQ       = 'Bad Request';
    public static final String  HTTPSTATUS_SUCCESS     = 'Success';


    
    public static HTTPResponse doCallout(String endpoint, String method,String headerContent,String headerContentValue,String body) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader(headerContent, headerContentValue);
        request.setBody(body);
        HTTPResponse response = http.send(request);

        return response;
    }
}