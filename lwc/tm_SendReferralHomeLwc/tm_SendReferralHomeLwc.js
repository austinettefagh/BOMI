import { LightningElement, track, wire ,api } from 'lwc';
import ACCOUNT_RECORDTYPE_FIELD from '@salesforce/schema/Account.RecordTypeId';
import AName from '@salesforce/schema/Account.Name';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
// import LeadData from '@salesforce/schema/Lead';
import OpportunityData from '@salesforce/schema/Opportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from "lightning/uiRecordApi";
import CONTACTNAME from '@salesforce/schema/Contact.Name';
import CURRENTUSERID from '@salesforce/user/Id';
import StageName_FIELD from '@salesforce/schema/Opportunity.StageName';
import ProductLine_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product_Line__c';
import ProductType_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product_Type__c';
import Product_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product__c';

export default class Tm_SendReferralHomeLwc extends NavigationMixin(LightningElement) {
    @api accountRecordId;
    //@api objectApiName;
    @track referralId;
    @track recordTypeName;
    @track isModalOpen = false;
    @track accountRecordType = false;
    @track error;
    @track createdurl;
    @track isQuickAction = false;
    @track OppRecordTypeId;
    @track OppRecordTypeName;
    @track stageNameValue;
    @track stageNameOptions;
    @track productLineValue;
    @track productLineOptions;
    @track productTypedata;
    @track productTypeValue;
    @track productTypeOptions;
    @track productdata;
    @track productValue;
    @track productOptions;
    @track isTreasuryOpp = false;
    @api accountinfo;
    @api contactInfo;
    @api contactId;
    @api UserName;  
    @track boolVisible = false;  
    @track ownerId;  
    @track isAccountSelected = false;
    @track isLoading = false;
    @track checkSave = false;
    userId = CURRENTUSERID;
    
    @wire(getRecord, { recordId: '$accountRecordId', fields: [ACCOUNT_RECORDTYPE_FIELD,AName] })
    getAccount({ error, data }){
        if(data){
            var result = JSON.parse(JSON.stringify(data));
            this.accountinfo = result;
            this.recordTypeName = result.recordTypeInfo.name;
            if(this.recordTypeName === 'Business'){
                this.accountRecordType = true;
            }
            if(this.recordTypeName === 'Person Account'){
                this.isQuickAction= true;
                this.isModalOpen = true;
            }
        }  
    };

    @wire(getObjectInfo, { objectApiName: OpportunityData })
    objectInfo;

    get recordBusinessTypeId() {
        // Returns a map of record type Ids       
        if(this.recordTypeName == 'Business'){
            const rtis = this.objectInfo.data.recordTypeInfos;       
            return Object.keys(rtis).find(rti => rtis[rti].name === 'Business Lead / Referral');
        } else if(this.recordTypeName === 'Person Account'){
            const rtis = this.objectInfo.data.recordTypeInfos;         
            return Object.keys(rtis).find(rti => rtis[rti].name === 'Personal Lead / Referral');
        }else{
           return null; 
        }
    }
    
    @wire(getRecord, { recordId: '$contactId', fields: [CONTACTNAME] })
    getContact({ error, data }){
        if(data){
            var result = JSON.parse(JSON.stringify(data));
            this.contactInfo = result;
        }
    };
       
    handleChange(event){
        this.contactId = event.target.selectedRecordId;
        event.stopPropagation();
        event.preventDefault();
    }

    handleKeyUp(event) {
        if (event.key === 'enter' || event.keyCode === 13) {
            // console.log('is enter');
            event.preventDefault();
        }
    }



    handleSubmit(event) {
        event.preventDefault();
        if (this.ownerId && this.userId) {
            this.isLoading = true;
            event.preventDefault();
            // Get data from submitted form
            const fields = event.detail.fields;
            // Here you can execute any logic before submit
            // and set or modify existing fields
            if(this.ownerId != null){
                fields.OwnerId = this.ownerId;
            }
            fields.RecordTypeId = this.OppRecordTypeId;
            fields.StageName = JSON.parse(JSON.stringify(this.stageNameValue));
            fields.LLC_BI__Product_Line__c = this.productLineValue;
            fields.LLC_BI__Product_Type__c = this.productTypeValue;
            fields.LLC_BI__Product__c = this.productValue;
            // if(this.recordTypeName === 'Business' & this.contactInfo!=null){
            //     //    fields.recordTypeInfo = 'Business Referral';
            //     fields.LastName =   this.contactInfo.fields.Name.value +" ("+ this.accountinfo.fields.Name.value +")"
            //     //fields.LastName = "( "+ this.accountinfo.fields.Name.value +" )"
            //     fields.OB_Related_Contact__c = this.contactId
            //     // fields.OB_Related_Contact__c.reportValidity();
            // }
            // else{
            //     fields.LastName =  this.accountinfo.fields.Name.value
            //     //console.log('rec '+fields.recordTypeInfo)
            // }
            // fields.LeadSource='Internal';
            // fields.Status='New';
            this.checkSave = true;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
    }

    resetCombobox() {
        this.OppRecordTypeId = null;
        this.stageNameValue = null;
        this.productLineValue = null;
        this.productTypeValue = null;
        this.productValue = null;
    }

    handleError(event){

        this.boolVisible = false;
        this.isLoading = false;
        this.checkSave = false;
        var message = 'Looks like this might be a duplicate. Please check the existing Leads before creating a new record.';
        var strError = JSON.stringify(event.detail.detail)
        if(strError.includes('DUPLICATES_DETECTED')){
            const ErrorEvent = new ShowToastEvent({
                "title": "error",
                "message": message,
                 variant: 'error',
            });
            this.dispatchEvent(ErrorEvent);
            // this.clearEditMode();            
        } else {
            const ErrorEvent = new ShowToastEvent({
                "title": "error",
                "message": strError,
                 variant: 'error',
            });
            this.dispatchEvent(ErrorEvent);
            //this.clearEditMode();     
        }
        this.resetCombobox();
        this.isTreasuryOpp = false;
        this.isAccountSelected = false;
        this.productLineOptions = null;
        this.stageNameOptions = null;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {           
            element.value = null;
        });
    }
    handleSuccess(event) {
        this.boolVisible = false;
        this.isLoading = false;
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                actionName: 'view',
                objectApiName: 'Opportunity'
            }
        }).then(url => {
            const event = new ShowToastEvent({
                "title": "Success!",
                "message": "A new referral has been submitted! See it {0}!",
                "messageData": [
                    {
                        url,
                        label: 'here'
                    }
                ], 
                variant: "success"
            });
            this.dispatchEvent(event);
            this.resetCombobox();
            this.checkSave = false;
            this.isAccountSelected = false;
            this.isTreasuryOpp = false;
            this.productLineOptions = null;
            this.stageNameOptions = null;
            this.template.querySelectorAll('lightning-input-field').forEach(element => {           
                element.value = null;
            });
        }); 
        
        const closeQA = new CustomEvent('close');
        // Dispatches the event.
        this.dispatchEvent(closeQA);
        this.contactId='';
        this.isModalOpen = false;
        
    }

    handleResetAll(){
        this.template.querySelectorAll('lightning-input').forEach(element => {
            if(element.type === 'checkbox' || element.type === 'checkbox-button'){
            element.checked = false;
            }else{
            element.value = null;
            }      
        });
    }
        
    
    /*closeModal(){
        const closeQA = new CustomEvent('close');
        // Dispatches the event.
        this.dispatchEvent(closeQA);
        this.isModalOpen = false;
    }*/
    

    onAccountSelection(event){  
        this.UserName = event.detail.selectedValue;  
        this.ownerId = event.detail.selectedRecordId; 
        event.stopPropagation();
        event.preventDefault();   
    }  

    // handleClick(event) {  
    //     const check = event.target.checked;
    //     if ( check === true) {  
    //     this.boolVisible = true;  
    //     } 
    //     else
    //     this.boolVisible = false;  
    // } 

   handleAccountChange(event) {
        this.accountRecordId = event.detail.value[0];
        if(this.accountRecordId != undefined){
            this.isAccountSelected = true;
        } else {
            this.isAccountSelected = false;
        }
    }

    get OppRecordType() {
        var recordtypeinfo = this.objectInfo.data.recordTypeInfos;
        var uiCombobox = [];
        for(var eachRecordtype in  recordtypeinfo)//this is to match structure of lightning combo box
        {
            // if(recordtypeinfo.hasOwnProperty(eachRecordtype) && recordtypeinfo[eachRecordtype].available && recordtypeinfo[eachRecordtype].name !== "Master" && recordtypeinfo[eachRecordtype].name !== "Treasury" && recordtypeinfo[eachRecordtype].name !== "Loan"){
            if(recordtypeinfo.hasOwnProperty(eachRecordtype) && recordtypeinfo[eachRecordtype].available && recordtypeinfo[eachRecordtype].name == "Loan"){
                uiCombobox.push({ label: recordtypeinfo[eachRecordtype].name, value: recordtypeinfo[eachRecordtype].recordTypeId })
            }
        }
        // this.OppRecordTypeId = uiCombobox[0].value;
        return uiCombobox;
    }

    handleRecordTypeChange(event){
        this.OppRecordTypeId = event.detail.value;
        this.productTypeOptions = null;
        this.productOptions = null;
        this.OppRecordTypeName = event.target.options.find(opt => opt.value === event.detail.value).label;
        if(this.OppRecordTypeName === "Track Treasury Products Sold" || this.OppRecordTypeName === "Track Deposit Pipeline"){
            this.isTreasuryOpp = true;
        }else{
            this.isTreasuryOpp = false;
        }
    }

    @wire(getPicklistValues, {
        recordTypeId: "$OppRecordTypeId",
        fieldApiName: StageName_FIELD
      })
      stageNamePicklistValues({ error, data }) {
        if (data) {
            this.stageNameValue = null;
            // Map picklist values
            this.stageNameOptions = data.values.map(plValue => {
                return {
                    label: plValue.label,
                    value: plValue.value
                };
            });
        } else if (error) {
            // Handle error
            // Console.log(error);
        }
    }

    handleStageChange(event){
        this.stageNameValue = event.detail.value;
    }

    @wire(getPicklistValues, {
        recordTypeId: "$OppRecordTypeId",
        fieldApiName: ProductLine_FIELD
      })
      productLinePicklistValues({ error, data }) {
        if (data) {
            this.productLineValue = null;
            // Map picklist values
            this.productLineOptions = data.values.map(plValue => {
                if (plValue.label === 'Commercial' || plValue.label === 'SBA' || plValue.label === 'Agriculture') {
                    return {
                        label: plValue.label,
                        value: plValue.value
                    };
                }
            }).filter(v => v);
        } else if (error) {
            // Handle error
            // Console.log(error);
        }
    }

    handleproductLineChange(event){
        this.productLineValue = event.detail.value;
        this.productTypeValue = null;
        let key = this.productTypedata.controllerValues[event.detail.value];
        this.productTypeOptions = this.productTypedata.values.filter(opt => opt.validFor.includes(key));
    }

    @wire(getPicklistValues, {
        recordTypeId: "$OppRecordTypeId",
        fieldApiName: ProductType_FIELD
      })
      productTypePicklistValues({ error, data }) {
        if (data) {
            this.productTypeValue = null;
            this.productTypedata = data;

        } else if (error) {
            // Handle error
            // Console.log(error);
        }
    }

    handleproductTypeChange(event){
        this.productTypeValue = event.detail.value;
        this.productValue = null;
        let key = this.productdata.controllerValues[event.detail.value];
        this.productOptions = this.productdata.values.filter(opt => opt.validFor.includes(key));
    }

    @wire(getPicklistValues, {
        recordTypeId: "$OppRecordTypeId",
        fieldApiName: Product_FIELD
      })
      productPicklistValues({ error, data }) {
        if (data) {
            this.productValue = null;
            this.productdata = data;
        } else if (error) {
            // Handle error
            // Console.log(error);
        }
    }

    handleproductChange(event){
        this.productValue = event.detail.value;
    }

}