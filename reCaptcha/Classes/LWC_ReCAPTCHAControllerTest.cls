/**
 * @description       : 
 * @author            : Shahrukh Ahmed 
 * @last modified on  : 17-04-2024
 * @last modified by  : Shahrukh Ahmed 
**/
@isTest
public with sharing class LWC_ReCAPTCHAControllerTest {
       @isTest 
       static void isVerifiedRecaptchaEnterpriseLowScoreTest(){
        String body = '{"success":true,"challenge_ts":"2024-04-16T05:31:42Z","score":0.9,"action":"submit"}';
        String endpoint = 'https://www.google.com/recaptcha/api/siteverify';
        Test.setMock(HttpCalloutMock.class, new HttpCallOutMockTest(body,endpoint, 'POST'));
        Test.startTest();         
        Assert.areEqual(true, LWC_ReCAPTCHAController.isReCAPTCHAValid('tokenFromClient'),'The ReCaptcha response is valid.');
        Test.stopTest();
    }
}