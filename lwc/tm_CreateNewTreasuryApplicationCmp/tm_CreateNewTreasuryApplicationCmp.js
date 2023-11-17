import { LightningElement , api, wire, track} from 'lwc';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getOppDetails from '@salesforce/apex/TM_CreateApplicationController.getOppDetails';
import saveApplicationProduct from '@salesforce/apex/TM_CreateApplicationController.saveApplicationProduct';
import FEES from '@salesforce/schema/TM_Treasury_Application_Product__c.TM_Fees__c';
import FREQUENCY from '@salesforce/schema/TM_Treasury_Product_ACH_Companies__c.TM_Frequency__c';
import CREDITS_DEBITS from '@salesforce/schema/TM_Treasury_Product_ACH_Companies__c.TM_Credits_Debits__c';
import TRANSACTION_TYPE from '@salesforce/schema/TM_Treasury_Application_Product__c.TM_Transaction_type__c';
import TRANSACTION from '@salesforce/schema/TM_Treasury_Product_ACH_Companies__c.TM_Transaction_Type__c';
import IS_CHECK from '@salesforce/schema/TM_Treasury_Product_RDC_Scanner__c.TM_Is_scanner_in_stock__c';
import AUTHORIZED from '@salesforce/schema/TM_Treasury_Application_Product_User__c.TM_Authorized_to__c';
import DUPLICATE_APPLICATION_MESSAGE from '@salesforce/label/c.TM_CreatedApplicationMsg';
import NO_OPPORTUNITY_PRODUCT_MESSAGE from '@salesforce/label/c.TM_NoOppProductMsg';
import MISS_ACCOUNT_INFO_MESSAGE from '@salesforce/label/c.TM_MissAccountTaxMsg';
import CREATE_SUCCESS_APPLICATION_MESSAGE from '@salesforce/label/c.TM_CreateApplicationSuccessMsg';
import SUBMIT_APPLICATION_MESSAGE from '@salesforce/label/c.TM_SubmitApplicationMsg';

const SCREEN_TITLE = {
    ACCOUNT_INFORMATION: "Account Information",
    AGREEMENT_INFORMATION: "Agreement Information",
    TREASURY_PRODUCT : "Treasury Product",
    CREATE_NEW_TREASURY_APPLICATION : "New Treasury Application",
    ADD_TREASURY_PRODUCT: "Add Treasury Product",
    ADD_ACH_COMPANIES: "Add ACH Companies",
    ADD_SCANNERS: "Add Scanners",
    ADD_PROFIT_STARS: "Add Profit Stars Account Access",
    ADD_ADMIN: "Add Administrator",
    ADD_USER: "Add User",
    ADD_PRODUCT_ACCOUNT: "Add Product Account"
}

const label = {
    duplicate: DUPLICATE_APPLICATION_MESSAGE,
    noProduct: NO_OPPORTUNITY_PRODUCT_MESSAGE,
    missAcctInfo: MISS_ACCOUNT_INFO_MESSAGE,
    createSuccess: CREATE_SUCCESS_APPLICATION_MESSAGE,
    submitCreate: SUBMIT_APPLICATION_MESSAGE
}

const actions = [
    { label: 'Edit', name: 'edit' }
];

const columns_action = [
    { label: 'Product', fieldName: 'product' },
    { label: 'Fees', fieldName: 'fees', type: 'text' },
    { label: 'Billing Account Number', fieldName: 'billAcctNum', type: 'text' },
    { label: 'Billing Instructions', fieldName: 'billInstructions', type: 'text' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

const columns = [
    { label: 'Product', fieldName: 'product' },
    { label: 'Fees', fieldName: 'fees', type: 'text' },
    { label: 'Billing Account Number', fieldName: 'billAcctNum', type: 'text' },
    { label: 'Billing Instructions', fieldName: 'billInstructions', type: 'text' },
];

export default class Tm_CreateNewTreasuryApplicationCmp extends LightningElement {
    
    @api recordId;

    @track treasuryProdObj = {
        productLine : null,
        productType: null,
        product: null,
        fees: null,
        bizName: null,
        isBillPayUser: null,
        acctNumStr: null,
        exceptionPricing: null,
        exExpirationDate: null,
        waiveExpirationDate: null,
        billAcctNum: null,
        billInstructions: null,
        dailyDepositAmount: null,
        singleTransactionAmount: null,
        dailyCheckCount: null,
        isHaveScanner: null,
        accountId: null,
        expandAddMoreCIF: null,
        requestedLimit: null,
        dualControlProcedures: null,
        dualNotes: null,
        isCreditProcessing: null,
        transactionType: null,
        transactionNote: null,
        exLstContName: null,
        exLstContPhone: null,
        acctNumEnrolled: null,
        sampleIssuedCheckFile: null,
        positivePayFilterLst: null,
        numOriginators: null,
        achLst: [],
        achItemLst: [],
        adminLst: [],
        adminItemLst: [],
        scannersLst: [],
        scannersItemLst: [],
        profitsStartLst: [],
        profitsStartItemLst: [],
        prodAcctLst: [],
        prodAcctItemLst: [],
        childWrappers: []
    };

    @track achCompaniesObj = {
        type: "ACH Companies",
        achName: null,
        achOffsetAcct: null,
        achAdditional: null,
        reACHLimit: null,
        achSameDay: null,
        achFrequency: null,
        achCreditsDebits: null,
        achTransaction: null,
        achNote:null,
    };

    @track adminObj = {
        type: "Product User",
        adminName: null,
        adminEmail: null,
        adminPerDayLimit: null,
        adminWorkNum: null,
        adminCellNum: null,
        adminBankingAccess: null,
        adminPerWireLimit: null,
        adminAcctAccess: null,
        adminAuthorized: [],
    };

    @track scannerObj = {
        type: "Scanner",
        scannerIsStock: null,
        scannerSerialNum: null
    }

    @track profitsStartObj = {
        type: "Profit Stars Account Access",
        psAcctName : null,
        psAcctNumber : null,
    };

    @track prodAcctObj = {
        type: "Product Account",
        prodAcctPrimaryAcct: null,
        prodAcctSecondaryAcct: null,
        prodAcctPegBalance: null,
        prodAcctAccountNumber: null,
        prodAcctAccountDailyLimit: null,
    }

    @track account;
    @track opportunity;
    @track priceMap;
    @track bizName;
    @track oppProdLst = [];
    @track tableData = [];
    @track achLst = [];
    @track achItemLst = [];
    @track scannersLst = [];
    @track scannersItemLst = [];
    @track profitsStartLst = [];
    @track profitsStartItemLst = [];
    @track adminLst = [];
    @track adminItemLst = [];
    @track prodAcctLst = [];
    @track prodAcctItemLst = [];
    @track price;
    @track panelTitle = SCREEN_TITLE.ACCOUNT_INFORMATION;
    @track validityEmail = false;
    @track oppProdIndex = 0;
    @track checkSaveButton = false;
    @track showSelectProduct = true;
    @track feesOptions;
    @track frequencyOptions;
    @track creditsDebitsOptions;
    @track transactionTypeOptions;
    @track transactionOptions3;
    @track sdACHOptions;
    @track userAccessLevelOptions;
    @track authorizedOptions;
    columns = columns;

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: FEES })
    feesPicklistValues({ data }) {
        if (data) {
            this.feesOptions = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: FREQUENCY })
    frequenctPicklistValues({ data }) {
        if (data) {
            this.frequencyOptions= data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: CREDITS_DEBITS })
    creditsPicklistValues({ data }) {
        if (data) {
            this.creditsDebitsOptions = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: TRANSACTION })
    transactionTypeicklistValues({ data }) {
        if (data) {
            this.transactionTypeOptions = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: TRANSACTION_TYPE })
    transactionPicklistValues({ data }) {
        if (data) {
            this.transactionOptions3 = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: IS_CHECK })
    sdACHOptionsPicklistValues({ data }) {
        if (data) {
            this.sdACHOptions = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: AUTHORIZED })
    authorizedPicklistValues({ data }) {
        if (data) {
            this.authorizedOptions = data.values.map(item => {
                return {
                    label: item.label,
                    value: item.value
                };
            });
        }
    }

    @wire(getOppDetails, { oppId : '$recordId'})
    oppDetails(data){
        eval("$A.get('e.force:refreshView').fire();");
        if(data.data != undefined){
            console.log('data', data.data);
            if (data.data.hasAppProd) {
                const event = new ShowToastEvent({
                    variant: 'Warning',
                    title: 'Warning!',
                    message: label.duplicate,
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
            } else if (data.data.opptyProducts.length === 0) {
                const event = new ShowToastEvent({
                    variant: 'Warning',
                    title: 'Warning!',
                    message: label.noProduct,
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
            } else if (data.data.accRecord.RecordType.Name === 'Person Account' && !(data.data.accRecord.FinServ__LastFourDigitSSN__pc && data.data.accRecord.CIF__c)) {
                const event = new ShowToastEvent({
                    variant: 'Warning',
                    title: 'Warning!',
                    message: label.missAcctInfo,
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
            } else if (data.data.accRecord.RecordType.Name !== 'Person Account' && !(data.data.accRecord.LLC_BI__Tax_Identification_Number_PE__c && data.data.accRecord.CIF__c)) {
                const event = new ShowToastEvent({
                    variant: 'Warning',
                    title: 'Warning!',
                    message: label.missAcctInfo,
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
            } else {
                const priceObj = {};
                this.account = data.data.accRecord;
                this.oppProdLst = data.data.opptyProducts;
                const opptyProducts = data.data.opptyProducts;
                const prodLst = [];
                opptyProducts.forEach(item => {
                    const prodObj = {
                        productLine : null,
                        productType: null,
                        product: null,
                        fees: null,
                        bizName: null,
                        isBillPayUser: null,
                        acctNumStr: null,
                        exceptionPricing: null,
                        exExpirationDate: null,
                        waiveExpirationDate: null,
                        billAcctNum: null,
                        billInstructions: null,
                        dailyDepositAmount: null,
                        singleTransactionAmount: null,
                        dailyCheckCount: null,
                        isHaveScanner: null,
                        accountId: null,
                        expandAddMoreCIF: null,
                        requestedLimit: null,
                        dualControlProcedures: null,
                        dualNotes: null,
                        isCreditProcessing: null,
                        transactionType: null,
                        transactionNote: null,
                        exLstContName: null,
                        exLstContPhone: null,
                        acctNumEnrolled: null,
                        sampleIssuedCheckFile: null,
                        positivePayFilterLst: null,
                        numOriginators: null,
                        achLst: [],
                        achItemLst: [],
                        adminLst: [],
                        adminItemLst: [],
                        scannersLst: [],
                        scannersItemLst: [],
                        profitsStartLst: [],
                        profitsStartItemLst: [],
                        prodAcctLst: [],
                        prodAcctItemLst: [],
                        childWrappers: []
                    };
                    prodObj.productLine = item.Product2.TM_Product_Line__c;
                    prodObj.productType = item.Product2.TM_Product_Type__c;
                    prodObj.product = item.Product2.TM_Product__c;
                    prodObj.fees = 'Standard';
                    prodLst.push(prodObj);
                })
                this.tableData = prodLst;
                this.opportunity = data.data.oppRecord;
                const prodPriceLst = data.data.pricebookEntry;
                prodPriceLst.forEach(item => {
                    priceObj[item.Product2.Name] = item.UnitPrice;
                })
                this.priceMap = priceObj;
            }
        }
    }

    handleBizNameInput(event) {
        this.bizName = event.detail;
    }

    get showScannersItem() {
        return this.scannersItemLst.length > 0;
    }

    get showProfitsStartItem() {
        return this.profitsStartItemLst.length > 0;
    }

    get checkBizName () {
        return (this.bizName === null || this.bizName === undefined || this.bizName === '');
    }

    get showAdminItem() {
        return this.adminItemLst.length > 0;
    }

    get showACHItem() {
        return this.achItemLst.length > 0;
    }

    get showProdAcctItem() {
        return this.prodAcctItemLst.length > 0;
    }

    get showTransactionNotes() {
        return this.treasuryProdObj.transactionType === 'Other';
    }

    get showACH() {
        return (this.treasuryProdObj.product === "ACH Third Party Sender" || this.treasuryProdObj.product === "ACH Origination");
    }

    get showACHThird() {
        return this.treasuryProdObj.product === "ACH Third Party Sender";
    }

    get showMultiUser() {
        return this.treasuryProdObj.product === "Multi User";
    }

    get showRDCScanner() {
        return (this.treasuryProdObj.product === 'RDC Hi-Speed Scanner' ||
                this.treasuryProdObj.product === 'RDC Low-Speed Scanner'
        );
    }

    get showRDCProfitsStart() {
        return (this.treasuryProdObj.product === 'RDC Hi-Speed Scanner' ||
        this.treasuryProdObj.product === 'RDC Low-Speed Scanner' ||
        this.treasuryProdObj.product === 'RDC Mobile'
        );
    }

    get showUPProfitsStart() {
        return (this.treasuryProdObj.product === 'Payment Portal U-Pay' || this.treasuryProdObj.product === 'Payment Portal I-Collect')
    }

    get showUP() {
        return (this.treasuryProdObj.product === 'Payment Portal U-Pay' || this.treasuryProdObj.product === 'Payment Portal I-Collect');
    }

    get showUPTransaction () {
        return (this.treasuryProdObj.product === 'Payment Portal U-Pay');
    }

    get showLockBox() {
        return (this.treasuryProdObj.product === 'Lockbox Retail' ||
        this.treasuryProdObj.product === 'Lockbox Remote' ||
        this.treasuryProdObj.product === 'RDC Hi-Speed Scanner' ||
        this.treasuryProdObj.product === 'RDC Low-Speed Scanner' ||
        this.treasuryProdObj.product === 'RDC Mobile');
    }

    // get showProdAccInLockbox(){
    //     return (this.treasuryProdObj.product === 'Lockbox Retail' ||
    //     this.treasuryProdObj.product === 'Lockbox Remote');
    // }

    get showPostPay() {
        return (this.treasuryProdObj.product === 'Positive Pay Payee Name Verification' || this.treasuryProdObj.product === 'Positive Pay Check' || this.treasuryProdObj.product === 'Positive Pay ACH');
    }

    get showSweep() {
        return (this.treasuryProdObj.product === 'Multi Sweep' || this.treasuryProdObj.product === 'Single Sweep');
    }

    get singleSweepCheck() {
        return (this.treasuryProdObj.product === 'Single Sweep' && this.prodAcctItemLst.length > 0);
    }

    get lockboxCheck() {
        return ((this.treasuryProdObj.product === 'Lockbox Retail' || this.treasuryProdObj.product === 'Lockbox Remote') && this.profitsStartItemLst.length > 0);
    }

    get isSingeSweep() {
        return this.treasuryProdObj.product === 'Single Sweep';
    }

    // get isAddSingeAcc() {
    //     return (this.treasuryProdObj.product === 'Single Sweep' || this.treasuryProdObj.product === 'Lockbox Remote' || this.treasuryProdObj.product === 'Lockbox Retail');
    // }

    get showPayFilter() {
        return (this.treasuryProdObj.product === 'Positive Pay ACH');
    }

    get showSampleCheck() {
        return (this.treasuryProdObj.product === 'Positive Pay Check' || this.treasuryProdObj.product === 'Positive Pay Payee Name Verification');
    }

    get showWire() {
        return this.treasuryProdObj.product === 'Wire Transmission';
    }

    get showBillPay() {
        return (this.treasuryProdObj.product === 'Business BillPay' || this.treasuryProdObj.product === 'Multi User');
    }

    get showSerialNumber() {
        return this.scannerObj.scannerIsStock === 'Yes';
    }
    
    get showInputNote() {
        return this.treasuryProdObj.dualControlProcedures === 'Yes';
    }

    get isLockboxRemote() {
        return this.treasuryProdObj.product === 'Lockbox Remote';
    }

    get isLockbox(){
        return (this.treasuryProdObj.product === 'Lockbox Remote' || this.treasuryProdObj.product === 'Lockbox Retail');
    }
 
    get showAccountInfo() {
        return this.panelTitle === SCREEN_TITLE.ACCOUNT_INFORMATION;
    }

    get showAgreementInfo() {
        return this.panelTitle === SCREEN_TITLE.AGREEMENT_INFORMATION;
    }

    get showTreasuryProduct() {
        return this.panelTitle === SCREEN_TITLE.TREASURY_PRODUCT;
    }

    get showAddProduct() {
        return this.panelTitle === SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    get showAddProductAccountScreen() {
        return this.panelTitle === SCREEN_TITLE.ADD_PRODUCT_ACCOUNT;
    }

    get showAccountNumberInput() {
        return (this.treasuryProdObj.product === 'BAI File Download' || this.treasuryProdObj.product === 'EDI Addenda Translation');
    }
    
    get showStandard() {
        return this.treasuryProdObj.fees === 'Standard';
    }

    get showACHTransactionsNote() {
        return this.achCompaniesObj.achTransaction === 'Other';
    }

    get showHeaderTitle() {
        if (this.panelTitle !== SCREEN_TITLE.ADD_TREASURY_PRODUCT) {
            return this.panelTitle;
        }
        return this.panelTitle + ': ' + this.treasuryProdObj.product;
    }

    get checkRequiredInput() {
        if (this.showBillPay) {
            return !(this.treasuryProdObj.fees && this.treasuryProdObj.billAcctNum && this.treasuryProdObj.isBillPayUser);
        }
        return !(this.treasuryProdObj.fees && this.treasuryProdObj.billAcctNum);
    }

    get lstPrice() {
        return this.priceMap[this.treasuryProdObj.product];
    }

    get showAddACH() {
        return this.panelTitle === SCREEN_TITLE.ADD_ACH_COMPANIES;
    }

    get showAddScanners() {
        return this.panelTitle === SCREEN_TITLE.ADD_SCANNERS;
    }

    get showAddProfitStars() {
        return this.panelTitle === SCREEN_TITLE.ADD_PROFIT_STARS;
    }

    get showCheckScreen() {
        return this.panelTitle === SCREEN_TITLE.CREATE_NEW_TREASURY_APPLICATION;
    }

    get showAddUser() {
        return this.panelTitle === SCREEN_TITLE.ADD_ADMIN || this.panelTitle === SCREEN_TITLE.ADD_USER;
    }

    get showWaiveInput () {
        return this.treasuryProdObj.fees === 'Waive';
    }

    get showExceptionInput() {
        return this.treasuryProdObj.fees === 'Exception';
    }

    editRowDetails(row) {
        const rowData = JSON.parse(JSON.stringify(row));
        this.treasuryProdObj.productLine = rowData.productLine;
        this.treasuryProdObj.productType = rowData.productType;
        this.treasuryProdObj.product = rowData.product;
        this.treasuryProdObj.fees = rowData.fees;
        this.treasuryProdObj.bizName = rowData.bizName;
        this.treasuryProdObj.isBillPayUser = rowData.isBillPayUser;
        this.treasuryProdObj.acctNumStr = rowData.acctNumStr;
        this.treasuryProdObj.exceptionPricing = rowData.exceptionPricing;
        this.treasuryProdObj.exExpirationDate = rowData.exExpirationDate;
        this.treasuryProdObj.waiveExpirationDate = rowData.waiveExpirationDate;
        this.treasuryProdObj.billAcctNum = rowData.billAcctNum;
        this.treasuryProdObj.billInstructions = rowData.billInstructions;
        this.treasuryProdObj.dailyDepositAmount = rowData.dailyDepositAmount;
        this.treasuryProdObj.singleTransactionAmount = rowData.singleTransactionAmount;
        this.treasuryProdObj.dailyCheckCount = rowData.dailyCheckCount;
        this.treasuryProdObj.isHaveScanner = rowData.isHaveScanner;
        this.treasuryProdObj.accountId = rowData.accountId;
        this.treasuryProdObj.expandAddMoreCIF = rowData.expandAddMoreCIF;
        this.treasuryProdObj.requestedLimit = rowData.requestedLimit;
        this.treasuryProdObj.dualControlProcedures = rowData.dualControlProcedures;
        this.treasuryProdObj.dualNotes = rowData.dualNotes;
        this.treasuryProdObj.isCreditProcessing = rowData.isCreditProcessing;
        this.treasuryProdObj.transactionType = rowData.transactionType;
        this.treasuryProdObj.exLstContName = rowData.exLstContName;
        this.treasuryProdObj.exLstContPhone = rowData.exLstContPhone;
        this.treasuryProdObj.acctNumEnrolled = rowData.acctNumEnrolled;
        this.treasuryProdObj.sampleIssuedCheckFile = rowData.sampleIssuedCheckFile;
        this.treasuryProdObj.positivePayFilterLst = rowData.positivePayFilterLst;
        this.treasuryProdObj.numOriginators = rowData.numOriginators;
        this.achItemLst = rowData.achItemLst;
        this.achLst = rowData.achLst;
        this.adminItemLst = rowData.adminItemLst;
        this.adminLst = rowData.adminLst;
        this.profitsStartItemLst = rowData.profitsStartItemLst;
        this.profitsStartLst = rowData.profitsStartLst;
        this.prodAcctItemLst = rowData.prodAcctItemLst;
        this.prodAcctLst = rowData.prodAcctLst;
        this.scannersItemLst = rowData.scannersItemLst;
        this.scannersLst = rowData.scannersLst;
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
        this.price = rowData.price;
    }

    handleRowAction(event) {
        const row = event.detail.row;
        this.editRowDetails(row);
    }

    setTreasuryProductInfo() {
        this.treasuryProdObj.productLine = this.tableData[this.oppProdIndex].productLine;
        this.treasuryProdObj.productType = this.tableData[this.oppProdIndex].productType;
        this.treasuryProdObj.product = this.tableData[this.oppProdIndex].product;
        this.treasuryProdObj.fees = this.tableData[this.oppProdIndex].fees;
        this.treasuryProdObj.bizName = this.tableData[this.oppProdIndex].bizName;
        this.treasuryProdObj.isBillPayUser = this.tableData[this.oppProdIndex].isBillPayUser;
        this.treasuryProdObj.acctNumStr = this.tableData[this.oppProdIndex].acctNumStr;
        this.treasuryProdObj.exceptionPricing = this.tableData[this.oppProdIndex].exceptionPricing;
        this.treasuryProdObj.exExpirationDate = this.tableData[this.oppProdIndex].exExpirationDate;
        this.treasuryProdObj.waiveExpirationDate = this.tableData[this.oppProdIndex].waiveExpirationDate;
        this.treasuryProdObj.billAcctNum = this.tableData[this.oppProdIndex].billAcctNum;
        this.treasuryProdObj.billInstructions = this.tableData[this.oppProdIndex].billInstructions;
        this.treasuryProdObj.dailyDepositAmount = this.tableData[this.oppProdIndex].dailyDepositAmount;
        this.treasuryProdObj.singleTransactionAmount = this.tableData[this.oppProdIndex].singleTransactionAmount;
        this.treasuryProdObj.dailyCheckCount = this.tableData[this.oppProdIndex].dailyCheckCount;
        this.treasuryProdObj.isHaveScanner = this.tableData[this.oppProdIndex].isHaveScanner;
        this.treasuryProdObj.accountId = this.tableData[this.oppProdIndex].accountId;
        this.treasuryProdObj.expandAddMoreCIF = this.tableData[this.oppProdIndex].expandAddMoreCIF;
        this.treasuryProdObj.requestedLimit = this.tableData[this.oppProdIndex].requestedLimit;
        this.treasuryProdObj.dualControlProcedures = this.tableData[this.oppProdIndex].dualControlProcedures;
        this.treasuryProdObj.dualNotes = this.tableData[this.oppProdIndex].dualNotes;
        this.treasuryProdObj.isCreditProcessing = this.tableData[this.oppProdIndex].isCreditProcessing;
        this.treasuryProdObj.transactionType = this.tableData[this.oppProdIndex].transactionType;
        this.treasuryProdObj.transactionNote = this.tableData[this.oppProdIndex].transactionNote;
        this.treasuryProdObj.exLstContName = this.tableData[this.oppProdIndex].exLstContName;
        this.treasuryProdObj.exLstContPhone = this.tableData[this.oppProdIndex].exLstContPhone;
        this.treasuryProdObj.acctNumEnrolled = this.tableData[this.oppProdIndex].acctNumEnrolled;
        this.treasuryProdObj.sampleIssuedCheckFile = this.tableData[this.oppProdIndex].sampleIssuedCheckFile;
        this.treasuryProdObj.positivePayFilterLst = this.tableData[this.oppProdIndex].positivePayFilterLst;
        this.treasuryProdObj.numOriginators = this.tableData[this.oppProdIndex].numOriginators;
        this.treasuryProdObj.achLst = this.tableData[this.oppProdIndex].achLst;
        this.treasuryProdObj.achItemLst = this.tableData[this.oppProdIndex].achItemLst;
        this.treasuryProdObj.adminLst = this.tableData[this.oppProdIndex].adminLst;
        this.treasuryProdObj.adminItemLst = this.tableData[this.oppProdIndex].adminItemLst;
        this.treasuryProdObj.scannersLst = this.tableData[this.oppProdIndex].scannersLst;
        this.treasuryProdObj.scannersItemLst = this.tableData[this.oppProdIndex].scannersItemLst;
        this.treasuryProdObj.profitsStartLst = this.tableData[this.oppProdIndex].profitsStartLst;
        this.treasuryProdObj.profitsStartItemLst = this.tableData[this.oppProdIndex].profitsStartItemLst;
        this.treasuryProdObj.prodAcctLst = this.tableData[this.oppProdIndex].prodAcctLst;
        this.treasuryProdObj.prodAcctItemLst = this.tableData[this.oppProdIndex].prodAcctItemLst;
        this.price = this.tableData[this.oppProdIndex].price;
    }

    handleTreasuryProductChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.treasuryProdObj[event.target.name] = event.target.value;
            }
        } else {
            this.treasuryProdObj[event.target.name] = event.target.value;
        }
    }

    handleACHCompaniesChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.achCompaniesObj[event.target.name] = event.target.value;
            }
        } else {
            this.achCompaniesObj[event.target.name] = event.target.value;
        }
    }

    handleAdminChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.adminObj[event.target.name] = event.target.value;
            }
        } else {
            this.adminObj[event.target.name] = event.target.value;
        }
        if (event.target.name === 'adminEmail') {
            if(!this.template.querySelector('.user-email-input').checkValidity()){
                this.validityEmail = true;
            } else {
                this.validityEmail = false;
            }
        } 
    }

    handleScannerChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.scannerObj[event.target.name] = event.target.value;
            }
        } else {
            this.scannerObj[event.target.name] = event.target.value;
        }
        if(this.scannerObj.scannerIsStock === 'No') {
            this.scannerObj.scannerSerialNum = null;
        }
    }

    handleProfitsStartChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.profitsStartObj[event.target.name] = event.target.value;
            }
        } else {
            this.profitsStartObj[event.target.name] = event.target.value;
        }
    }

    handleProdAcctChange(event) {
        if (event.target.maxlength) {
            if (event.target.value.length < event.target.maxlength ) {
                this.prodAcctObj[event.target.name] = event.target.value;
            }
        } else {
            this.prodAcctObj[event.target.name] = event.target.value;
        }
    }

    handleSelectProduct() {
        if (this.tableData.length > 0) {
            this.setTreasuryProductInfo();
        }

        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleAddScanner() {
        this.panelTitle = SCREEN_TITLE.ADD_SCANNERS;
    }

    handleAddAccountAccess() {
        this.panelTitle = SCREEN_TITLE.ADD_PROFIT_STARS;
    }

    handleACHCompanies() {
        this.panelTitle = SCREEN_TITLE.ADD_ACH_COMPANIES;
    }

    handleAddProductAccount() {
        this.panelTitle = SCREEN_TITLE.ADD_PRODUCT_ACCOUNT;
    }

    resetACHCompaniesObj() {
        this.achCompaniesObj = {
            type: "ACH Companies",
            achName: null,
            achLimit: null,
            achOffsetAcct: null,
            achAdditional: null,
            reACHLimit: null,
            achSameDay: null,
            achFrequency: null,
            achCreditsDebits: null,
            achTransaction: null,
            achNote:null
        }
    }
    resetAdminObj() {
        this.adminObj = {
            type: "Product User",
            adminName: null,
            adminEmail: null,
            adminPerDayLimit: null,
            adminWorkNum: null,
            adminCellNum: null,
            adminBankingAccess: null,
            adminPerWireLimit: null,
            adminAcctAccess: null,
            adminAuthorized: [],
        };
    }

    resetScannerObj() {
        this.scannerObj = {
            type: "Scanner",
            scannerIsStock: null,
            scannerSerialNum: null
        }
    }

    resetProfitsStartObj() {
        this.profitsStartObj = {
            type: "Profit Stars Account Access",
            psAcctName : null,
            psAcctNumber : null,
        };
    }

    resetProdAcctObj() {
        this.prodAcctObj = {
            type: "Product Account",
            prodAcctPrimaryAcct: null,
            prodAcctSecondaryAcct: null,
            prodAcctPegBalance: null,
            prodAcctAccountNumber: null,
            prodAcctAccountDailyLimit: null,
        };
    }

    handleCancelAddACH() {
        this.resetACHCompaniesObj()
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleCancelAddScanner() {
        this.resetScannerObj();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleCancelAddUser() {
        this.resetAdminObj();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleCancelAddProfitStars() {
        this.resetProfitsStartObj();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleCancelAddProdAcct() {
        this.resetProdAcctObj()
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveUser() {
        this.handleSaveNewUser();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveScanner() {
        this.handleSaveNewScanner()
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveProfitStars() {
        this.handleSaveNewProfitStars();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveProdAcct() {
        this.handleSaveNewProdAcct();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveACH() {
        this.handleSaveNewACH();
        this.panelTitle = SCREEN_TITLE.ADD_TREASURY_PRODUCT;
    }

    handleSaveNewUser() {
        const adminItem = {
            label: this.adminObj.adminName,
            name: this.adminObj.adminName
        };
        const addObj = this.adminObj;
        addObj.adminAuthorized = addObj.adminAuthorized.join(';');
        this.adminItemLst.push(adminItem);
        this.adminLst.push(addObj);
        this.resetAdminObj()
    }

    handleSaveNewProfitStars() {
        const profitStarsItem = {
            label: this.profitsStartObj.psAcctName,
            name: this.profitsStartObj.psAcctName
        };
        this.profitsStartItemLst.push(profitStarsItem);
        this.profitsStartLst.push(this.profitsStartObj);
        this.resetProfitsStartObj();
    }

    handleSaveNewScanner() {
        const serialItem = {
            label: this.scannerObj.scannerSerialNum + ' - ' + this.scannerObj.scannerIsStock,
            name: this.scannerObj.scannerSerialNum + ' - ' + this.scannerObj.scannerIsStock
        };
        this.scannersItemLst.push(serialItem);
        this.scannersLst.push(this.scannerObj);
        this.resetScannerObj();
    }

    handleSaveNewACH() {
        const ACHItem = {
            label: this.achCompaniesObj.achName,
            name: this.achCompaniesObj.achName,
        }
        const addItem = JSON.parse(JSON.stringify(this.achCompaniesObj));
        this.achItemLst.push(ACHItem);
        this.achLst.push(addItem);
        this.resetACHCompaniesObj();
    }

    handleSaveNewProdAcct() {
        const prodAcctItem = {
            label: this.prodAcctObj.prodAcctSecondaryAcct || this.prodAcctObj.prodAcctAccountNumber,
            name: this.prodAcctObj.prodAcctSecondaryAcct || this.prodAcctObj.prodAcctAccountNumber,
        }
        const addItem = JSON.parse(JSON.stringify(this.prodAcctObj));
        this.prodAcctItemLst.push(prodAcctItem);
        this.prodAcctLst.push(addItem);
        this.resetProdAcctObj();
    }

    handleItemRemove(event) {
        const index = event.detail.index;
        this.achItemLst.splice(index, 1);
        this.achLst.splice(index,1);
    }

    handleScannerItemRemove(event) {
        const index = event.detail.index;
        this.scannersItemLst.splice(index, 1);
        this.scannersLst.splice(index, 1);
    }

    handleProfitStarsItemRemove(event) {
        const index = event.detail.index;
        this.profitsStartItemLst.splice(index, 1);
        this.profitsStartLst.splice(index, 1);
    }

    handleUserItemRemove(event) {
        const index = event.detail.index;
        this.adminLst.splice(index, 1);
        this.adminItemLst.splice(index, 1);
    }

    handleProdActRemove(event) {
        const index = event.detail.index;
        this.prodAcctItemLst.splice(index, 1);
        this.prodAcctLst.splice(index,1);
    }

    handleAddAdmin(event) {
        if (event.target.name === SCREEN_TITLE.ADD_ADMIN) {
            this.panelTitle = SCREEN_TITLE.ADD_ADMIN;
        } else {
            this.panelTitle = SCREEN_TITLE.ADD_USER;
        }
    }

    handleDualControlChange(event) {
        this.dualControl = event.detail.value;
    }

    resetData() {
        this.achLst = [];
        this.achItemLst = [];
        this.profitsStartLst = [];
        this.profitsStartItemLst = [];
        this.scannersLst = [];
        this.scannersItemLst = [];
        this.adminLst = [];
        this.adminItemLst = [];
        this.prodAcctLst = [];
        this.prodAcctItemLst = [];
    }

    addTreasuryProduct() {
        try{
            this.treasuryProdObj.achLst = JSON.parse(JSON.stringify(this.achLst));
            this.treasuryProdObj.achItemLst = JSON.parse(JSON.stringify(this.achItemLst));
            this.treasuryProdObj.adminLst = JSON.parse(JSON.stringify(this.adminLst));
            this.treasuryProdObj.adminItemLst = JSON.parse(JSON.stringify(this.adminItemLst));
            this.treasuryProdObj.scannersLst = JSON.parse(JSON.stringify(this.scannersLst));
            this.treasuryProdObj.scannersItemLst = JSON.parse(JSON.stringify(this.scannersItemLst));
            this.treasuryProdObj.profitsStartLst = JSON.parse(JSON.stringify(this.profitsStartLst));
            this.treasuryProdObj.profitsStartItemLst = JSON.parse(JSON.stringify(this.profitsStartItemLst));
            this.treasuryProdObj.prodAcctLst = JSON.parse(JSON.stringify(this.prodAcctLst));
            this.treasuryProdObj.prodAcctItemLst = JSON.parse(JSON.stringify(this.prodAcctItemLst));
            this.treasuryProdObj.bizName = this.bizName;
            if (this.treasuryProdObj.dualNotes) {
                this.treasuryProdObj.dualNotes = this.treasuryProdObj.dualNotes.replace( /(<([^>]+)>)/ig,"");
            }
            this.treasuryProdObj.childWrappers = JSON.parse(JSON.stringify(this.achLst)).concat(JSON.parse(JSON.stringify(this.adminLst)).concat(JSON.parse(JSON.stringify(this.scannersLst)).concat(JSON.parse(JSON.stringify(this.profitsStartLst)).concat(JSON.parse(JSON.stringify(this.prodAcctLst))))));
            this.tableData = this.tableData.map(item => {
                return item.product === this.treasuryProdObj.product ? JSON.parse(JSON.stringify(this.treasuryProdObj)) : item
            });
            this.resetData();
        } catch(e) {
            const event = new ShowToastEvent({
                variant: 'error',
                title: 'Error!',
                message: 'oops! Some unexpected error occurred!',
            });
            this.dispatchEvent(event);
        }
    }

    handleSaveProduct() {
        if (this.treasuryProdObj.product) {
            this.addTreasuryProduct();
        }
        if (this.showSelectProduct) {
            if(this.oppProdIndex < (this.tableData.length - 1)) {
                this.oppProdIndex = this.oppProdIndex + 1;
                this.setTreasuryProductInfo();
            } else {
                this.columns = columns_action;
                this.oppProdIndex = 0;
                this.showSelectProduct = false;
                this.panelTitle = SCREEN_TITLE.TREASURY_PRODUCT;
            }
        } else {
            this.panelTitle = SCREEN_TITLE.TREASURY_PRODUCT;
        }

    }
    handleCancelProduct() {
        // this.resetData();
        this.panelTitle = SCREEN_TITLE.TREASURY_PRODUCT;
    }

    handleNavigationToAgreement() {
        this.panelTitle = SCREEN_TITLE.AGREEMENT_INFORMATION;
    }

    handleNavigationToAccount() {
        this.panelTitle = SCREEN_TITLE.ACCOUNT_INFORMATION;
    }

    handleNavigationToProduct() {
        this.panelTitle = SCREEN_TITLE.TREASURY_PRODUCT;
    }

    handleNavigationToCheck() {
        this.panelTitle = SCREEN_TITLE.CREATE_NEW_TREASURY_APPLICATION;
    }

    handelCancelCreate() {
        this.resetData();
        this.panelTitle = SCREEN_TITLE.ACCOUNT_INFORMATION;
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleSaveApplication() {
        if (!this.checkSaveButton) {
            this.checkSaveButton = true;
            saveApplicationProduct({oppId: this.recordId, accId: this.account.Id, appProds: JSON.stringify(this.tableData)})
            .then(() => {
                this.panelTitle = SCREEN_TITLE.ACCOUNT_INFORMATION;
                const event = new ShowToastEvent({
                    variant: 'success',
                    title: 'Success!',
                    message: label.createSuccess,
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
                window.location.assign(`https://${window.location.hostname}/lightning/r/Opportunity/${this.recordId}/view`);
            })
            .catch((error) => {
                const event = new ShowToastEvent({
                    variant: 'error',
                    title: 'Error!',
                    message: 'oops! Some unexpected error occurred!',
                });
                this.dispatchEvent(event);
                this.dispatchEvent(new CloseActionScreenEvent());
                window.location.assign(`https://${window.location.hostname}/lightning/r/Opportunity/${this.recordId}/view`);
            })
        }
    }
}