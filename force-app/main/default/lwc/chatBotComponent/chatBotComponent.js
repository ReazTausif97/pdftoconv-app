import { LightningElement, track } from 'lwc';
import getBotResponse from '@salesforce/apex/ChatBotController.getBotResponse';

export default class ChatBotComponent extends LightningElement {
    @track userQuery = '';
    @track botResponse = '';

    handleQueryChange(event) {
        this.userQuery = event.target.value;
    }

    handleSend() {
        if (this.userQuery) {
            getBotResponse({ query: this.userQuery })
                .then(result => {
                    this.botResponse = result;
                })
                .catch(error => {
                    this.botResponse = 'Error: ' + error.body.message;
                });
        } else {
            this.botResponse = 'Please enter a query';
        }
    }
}