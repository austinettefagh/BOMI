import { LightningElement, track, wire ,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from "lightning/uiRecordApi";
import { NavigationMixin } from 'lightning/navigation';
import ACCOUNT_RECORDTYPE_FIELD from '@salesforce/schema/Account.RecordTypeId';
import CONTACTNAME from '@salesforce/schema/Contact.Name';
import AName from '@salesforce/schema/Account.Name';
import CURRENTUSERID from '@salesforce/user/Id';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import OpportunityData from '@salesforce/schema/Opportunity';
import StageName_FIELD from '@salesforce/schema/Opportunity.StageName';
import ProductLine_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product_Line__c';
import ProductType_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product_Type__c';
import Product_FIELD from '@salesforce/schema/Opportunity.LLC_BI__Product__c';

export default class Tm_SendReferralPopup extends NavigationMixin(LightningElement) {
    @api accountRecordId;
    @api objectApiName;
    @track referralId;
    @track recordTypeName;
    @track isModalOpen = false;
    @track accountRecordType =false;
    @track error;
    @track createdurl;
    @track isQuickAction =false;
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
   @api UserId;  
    userId = CURRENTUSERID;
    
    @api
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;

        //this.REVENUE_FIELD =accountRecordId ;
    }
    
   
    
    @wire(getRecord, { recordId: '$accountRecordId', fields: [ACCOUNT_RECORDTYPE_FIELD,AName] })
    getAccount({ error, data }){
        if(data){
            var result = JSON.parse(JSON.stringify(data));
            this.accountinfo = result;
            this.recordTypeName = result.recordTypeInfo.name;
            if(this.recordTypeName === 'Business'){
                this.accountRecordType= true;
            }
            if(this.recordTypeName === 'Person Account'){
                this.isQuickAction= true;
                this.isModalOpen = true;
            }
            }
            // else if(error) {
            //     var resultError = JSON.parse(JSON.stringify(error));
            //     Console.log('error: ', resultError);
            // }
        };

    @wire(getObjectInfo, { objectApiName: OpportunityData })
    objectInfo;

    
       @wire(getRecord, { recordId: '$contactId', fields: [CONTACTNAME] })
        getContact({ error, data }){
            if(data){
                var result = JSON.parse(JSON.stringify(data));
                this.contactInfo = result;
            }
            // else if(error) {
            //     var resultError = JSON.parse(JSON.stringify(error));
            //     Console.log('error: ', resultError);
            // }
        };
        handleChange(event){
             this.contactId = event.target.selectedRecordId;
             event.stopPropagation();
             event.preventDefault();
        }
        handleSubmit(event) {
            this.isLoading = true;
            event.preventDefault();
            // Get data from submitted form
            const fields = event.detail.fields;
            if(this.UserId != null){
                fields.OwnerId = this.UserId;
            }
            fields.RecordTypeId = this.OppRecordTypeId;
            fields.StageName = this.stageNameValue;
            fields.LLC_BI__Product_Line__c = this.productLineValue;
            fields.LLC_BI__Product_Type__c = this.productTypeValue;
            fields.LLC_BI__Product__c = this.productValue;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
       
        }
        handleSuccess(event) {
            this.boolVisible = false;
            this[NavigationMixin.GenerateUrl]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.id,
                    actionName: 'view',
                    objectApiName: 'Lead'
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
            }); 
            
            const closeQA = new CustomEvent('close');
            // Dispatches the event.
            this.dispatchEvent(closeQA);
            this.contactId='';
            this.isModalOpen = false;
        }

    closeModal(){
        const closeQA = new CustomEvent('close');
        // Dispatches the event.
        this.dispatchEvent(closeQA);
        this.isModalOpen = false;
    }
    

   onAccountSelection(event){  
   this.UserName = event.detail.selectedValue;  
   this.UserId = event.detail.selectedRecordId; 
   event.stopPropagation();
   event.preventDefault();
   
   }  
   handleClick(event) {  
    const check = event.target.checked;
    if ( check === true) {  
        this.boolVisible = true;  
    } 
     else
        this.boolVisible = false;  
     
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
        if(this.OppRecordTypeName === "Treasury"){
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
        } 
        // else if (error) {
        //     // Handle error
        //     Console.log(error);
        // }
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
                return {
                    label: plValue.label,
                    value: plValue.value
                };
            });

        } 
        // else if (error) {
        //     // Handle error
        //     Console.log(error);
        // }
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

        } 
        // else if (error) {
        //     // Handle error
        //     Console.log(error);
        // }
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
        } 
        // else if (error) {
        //     // Handle error
        //     Console.log(error);
        // }
    }

    handleproductChange(event){
        this.productValue = event.detail.value;
    }
}