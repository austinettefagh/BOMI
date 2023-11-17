import { LightningElement, api, track } from 'lwc';

export default class Tm_ApplicationAgreementInfoCmp extends LightningElement {

    @api account;

    @api bizname;

    get billingAddress() {
        return this.account.Billing_Address__c === ',' ? null : this.account.Billing_Address__c;
    }

    handleBizChange(event) {
        const selectedEvent = new CustomEvent("biznameinput", {
            detail: event.target.value
          });
      
          // Dispatches the event.
          this.dispatchEvent(selectedEvent);
    }
}