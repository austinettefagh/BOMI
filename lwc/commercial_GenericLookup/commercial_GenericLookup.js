import { LightningElement, track, wire, api } from "lwc";  
import findRecords from "@salesforce/apex/TM_GenericLookupController.findRecords";  
//import LeadData from '@salesforce/schema/Lead';
export default class Commercial_GenericLookup extends LightningElement {
    @track recordsList;  
  @track searchKey = "";  
  @api selectedValue;  
  @api selectedRecordId;  
  @api objectApiName;  
  @api iconName;  
  @api lookupLabel;  
  @track message;  
  @api searchBarMessage;
  @api lookupFilterId;
    
  onLeave(event) {  
   setTimeout(() => {  
    this.searchKey = "";  
    this.recordsList = null;  
   }, 300);  
  }  
    
  onRecordSelection(event) {  
   this.selectedRecordId = event.target.dataset.key;  
   this.selectedValue = event.target.dataset.name;  
   this.searchKey = "";  
   this.onSeletedRecordUpdate();  
  }  
   
  handleKeyChange(event) {  
   const searchKey = event.target.value;  
   this.searchKey = searchKey;  
   this.getLookupResult();  
  }  
   
  removeRecordOnLookup(event) {  
   this.searchKey = "";  
   this.selectedValue = null;  
   this.selectedRecordId = null;  
   this.recordsList = null;  
   event.stopPropagation();
   event.preventDefault();
   this.onSeletedRecordUpdate();  
 }  
 getLookupResult() {  
   console.log('passedId'+this.accountId);
    findRecords({ searchKey: this.searchKey, objectName : this.objectApiName,lookupFilterId : this.lookupFilterId })  
     .then((result) => {  
      if (result.length===0) {  
        this.recordsList = [];  
        this.message = "No Records Found";  
       } else {  
        this.recordsList = result;  
        this.message = "";  
       }  
       this.error = undefined;  
     })  
     .catch((error) => {  
      this.error = error;  
      this.recordsList = undefined;  
     });  
   }  
    
   onSeletedRecordUpdate(){  
    const passEventr = new CustomEvent('recordselection', {  
      detail: { selectedRecordId: this.selectedRecordId, selectedValue: this.selectedValue }  
     });  
    
         this.dispatchEvent(passEventr);  
      
   }  
}