/**
 * @description       : Implement Recaptcha functionality for use within Forms
 * @author            : Shahrukh Ahmed 
 * @last modified on  : 18-04-2024
 * @last modified by  : Shahrukh Ahmed 
**/
import { LightningElement, api, track } from 'lwc';
import isReCAPTCHAValid from '@salesforce/apex/LWC_ReCAPTCHAController.isReCAPTCHAValid';
import pageUrl from '@salesforce/resourceUrl/reCAPTCHAv3';

export default class Recaptcha extends LightningElement {
    @api formToken;
    @api validReCAPTCHA = false;

    @track navigateTo;
    captchaWindow = null;

    constructor() {
        super();
        this.navigateTo = pageUrl;
    }

    captchaLoaded(evt) {
        var e = evt;
        if (e.target.getAttribute('src') == pageUrl) {
            window.addEventListener("message", (e) => {
                if (e.data.action == "getCAPCAH" && e.data.callCAPTCHAResponse == "NOK") {
                    console.log("Token not obtained!");
                } else if (e.data.action == "getCAPCAH") {
                    this.formToken = e.data.callCAPTCHAResponse;
                    isReCAPTCHAValid({ tokenFromClient: this.formToken }).then(data => {
                        this.validReCAPTCHA = data;
                        try { self.createEvent(data) }
                        catch (error) {
                            console.log(error);
                        }
                    });
                }
            }, false);
        }
    }

    createEvent(data) {
        const captchaResponse = new CustomEvent('captchareceived', {
            detail: {
                data: data
            }
        });
        this.dispatchEvent(captchaResponse);
    }

}