import { LightningElement, api } from 'lwc';
import refreshGoal from '@salesforce/apex/TM_RefreshTreasuryGoal.refreshGoal';

export default class Tm_RefreshTreasuryGoal extends LightningElement {
    @api recordId;
    @api invoke() {
        refreshGoal({recordId: this.recordId}).then(() =>{
            window.location.reload();
        })
        .catch(error =>{
            Console.log('Error: ', error);
        });
    }
}