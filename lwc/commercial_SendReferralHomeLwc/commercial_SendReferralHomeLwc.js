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

export default class Commercial_SendReferralHomeLwc extends NavigationMixin(LightningElement) {
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
    @api UserId;  
    @track isAccountSelected = false;
    @track isLoading = false;
    userId = CURRENTUSERID;
    
    /*@api
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
        console.log('here');

        //this.REVENUE_FIELD =accountRecordId ;
    }
    */
   
    
    @wire(getRecord, { recordId: '$accountRecordId', fields: [ACCOUNT_RECORDTYPE_FIELD,AName] })
    getAccount({ error, data }){
        if(data){
            var result = JSON.parse(JSON.stringify(data));
            this.accountinfo = result;
            console.log('accountRecordId'+JSON.stringify(this.accountRecordId));            
            console.log('Account details '+JSON.stringify(this.accountinfo));
            console.log('Account Name '+this.accountinfo.fields.Name.value);
            console.log('acc data: ', result.recordTypeInfo.name);
            this.recordTypeName = result.recordTypeInfo.name;
            console.log('recordTypeId'+ this.recordTypeName);
            if(this.recordTypeName === 'Business'){
                this.accountRecordType = true;
            }
            if(this.recordTypeName === 'Person Account'){
                this.isQuickAction= true;
                this.isModalOpen = true;
            }
        }else if(error) {
            var resultError = JSON.parse(JSON.stringify(error));
            console.log('error: ', resultError);
        }
        console.log('Account recordTypeId'+ this.accountRecordType);   
        console.log('accountRecordId'+JSON.stringify(this.accountRecordId));            
                     
    };

    @wire(getObjectInfo, { objectApiName: OpportunityData })
    objectInfo;
    /*get recordPersonTypeId() {
        // Returns a map of record type Ids 
        console.log('---this.objectInfo recordPersonTypeId---'+JSON.stringify(this.objectInfo));
        if(JSON.stringify(this.objectInfo.data) == undefined){
            console.log('---this.objectInfo 2---'+JSON.stringify(this.objectInfo));        
            return '0124T000000PaRAQA0';
        }
        const rtis = this.objectInfo.data.recordTypeInfos;
        console.log('--rtis recordPersonTypeId--'+JSON.stringify(Object.keys(rtis).find(rti => rtis[rti].name === 'Person Referral' )));
        return Object.keys(rtis).find(rti => rtis[rti].name === 'Person Referral' );// (Updated as per Tanner's request) 'Personal Lead / Referral');
    }*/
    get recordBusinessTypeId() {
        // Returns a map of record type Ids 
        console.log('---this.objectInfo---'+JSON.stringify(this.objectInfo));        
        if(this.recordTypeName == 'Business'){
            const rtis = this.objectInfo.data.recordTypeInfos;  
            console.log('--rtis--'+JSON.stringify(rtis));              
            return Object.keys(rtis).find(rti => rtis[rti].name === 'Business Lead / Referral');
        } else if(this.recordTypeName === 'Person Account'){
            const rtis = this.objectInfo.data.recordTypeInfos;  
            console.log('--rtis--'+JSON.stringify(rtis));              
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
            console.log('contactInfo'+ result.fields.Name.value);
        }
        else if(error) {
            var resultError = JSON.parse(JSON.stringify(error));
            console.log('error: ', resultError);
        }
    };
       
    handleChange(event){
        //const fields = event.detail.fields;
        // console.log('all data '+event.detail)
        //console.log('AccountId'+accountRecordId);
        this.contactId = event.target.selectedRecordId;
        console.log('ContactId '+this.contactId);
        event.stopPropagation();
        event.preventDefault();
    }

    handleSubmit(event) {
        this.isLoading = true;
        event.preventDefault();
        // Get data from submitted form
        const fields = event.detail.fields;
        // console.log('all data '+event.detail)
        console.log('ContactId2 '+this.contactId);
        //console.log('Contact Info --'+JSON.stringify(this.contactInfo.fields));
        // Here you can execute any logic before submit
        // and set or modify existing fields
        if(this.UserId != null){
            fields.OwnerId = this.UserId;
        }
        console.log('OppRecordTypeId--'+this.OppRecordTypeId);
        fields.RecordTypeId = this.OppRecordTypeId;
        fields.StageName = this.stageNameValue;
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
        this.template.querySelector('lightning-record-edit-form').submit(fields);
   
    }
    handleError(event){

        this.boolVisible = false;
        this.isLoading = false;
        var message = 'Looks like this might be a duplicate. Please check the existing Leads before creating a new record.';
        //var errors = event.getParams();
        console.log('---ERRPR---'+JSON.stringify(event.detail.detail));
        //var errormessages = errors.output;
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

        /*if ($A.util.isEmpty(errormessages.errors) === false) {
            if (errormessages.errors.length > 0) {
                for (var j = 0; errormessages.errors.length > j; j++) {
                    var fielderror = errormessages.errors[j];
                    if (fielderror.errorCode === 'DUPLICATES_DETECTED') {
                        message += 'Looks like this might be a duplicate. Click on the “Return to Search” button to find this contact';
                    }
                    else {
                        message += fielderror.errorCode + ' (' + fielderror.field + ') : ' + fielderror.message;
                    }
                }
            }
        //}*/

        
    }
    handleSuccess(event) {
        this.boolVisible = false;
        this.isLoading = false;
        console.log('in success'+event.detail.id);
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
            //handleResetAll();
            this.isAccountSelected = false;
            this.template.querySelectorAll('lightning-input-field').forEach(element => {
                console.log('Inside Query');                
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
        this.UserId = event.detail.selectedRecordId; 
        console.log('Name '+this.UserName) ;
        console.log('UserId '+this.UserId) ;
        event.stopPropagation();
        event.preventDefault();   
    }  

    handleClick(event) {  
        const check = event.target.checked;
        console.log(' this.boolVisible '+ this.boolVisible) 
        if ( check === true) {  
        this.boolVisible = true;  
        } 
        else
        this.boolVisible = false;  
    } 

   handleAccountChange(event) {
        console.log(' this.accountRecordId '+ this.accountRecordId) 
        console.log("You selected an account: " + event.detail.value[0]);
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
        console.log("recordtype" , this.objectInfo.data);
        for(var eachRecordtype in  recordtypeinfo)//this is to match structure of lightning combo box
        {
            if(recordtypeinfo.hasOwnProperty(eachRecordtype) && recordtypeinfo[eachRecordtype].available && recordtypeinfo[eachRecordtype].name !== "Master" && recordtypeinfo[eachRecordtype].name !== "Treasury" && recordtypeinfo[eachRecordtype].name !== "Loan"){
                uiCombobox.push({ label: recordtypeinfo[eachRecordtype].name, value: recordtypeinfo[eachRecordtype].recordTypeId })
            }
        }
        console.log('uiCombobox' + JSON.stringify(uiCombobox));
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
            console.log('==============stageName data  ' , data);
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
            console.log('==============stageName Error  ' , error);
            console.log(error);
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
            console.log('==============productLine data  ' , data);
            this.productLineValue = null;
            // Map picklist values
            this.productLineOptions = data.values.map(plValue => {
                return {
                    label: plValue.label,
                    value: plValue.value
                };
            });

        } else if (error) {
            // Handle error
            console.log('==============productLine Error  ' , error);
            console.log(error);
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
            console.log('==============productType Error  ' , error);
            console.log(error);
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
            console.log('==============product Error  ' , error);
            console.log(error);
        }
    }

    handleproductChange(event){
        this.productValue = event.detail.value;
    }

}