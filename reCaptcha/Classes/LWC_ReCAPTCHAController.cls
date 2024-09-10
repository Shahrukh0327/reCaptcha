/**
 * @description       : For ReCaptcha LWC
 * @author            : Shahrukh Ahmed 
 * @last modified on  : 17-04-2024
 * @last modified by  : Shahrukh Ahmed 
**/
public with sharing class LWC_ReCAPTCHAController {
    @AuraEnabled
    public static Boolean isReCAPTCHAValid(String tokenFromClient) {
        String SECRET_KEY = '6LcAL7spAAAAAKodwBxfnQCXsKs_3TxW-SfO3LqW';
        String RECAPTCHA_SERVICE_URL = 'https://www.google.com/recaptcha/api/siteverify';
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(RECAPTCHA_SERVICE_URL + '?secret=' + SECRET_KEY + '&response=' + tokenFromClient);
        request.setMethod('POST');
        request.setHeader('Content-Length', '0');
        HttpResponse response = http.send(request);

        Map<String, Object> mapOfBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Boolean success = (Boolean) mapOfBody.get('success');

        return success;
    }
}