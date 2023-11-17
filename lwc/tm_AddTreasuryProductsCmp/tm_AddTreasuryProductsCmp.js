import { LightningElement, track, wire, api } from 'lwc';
import getProductDetails from '@salesforce/apex/TM_AddProductsController.getProductDetails';
import saveOpportunityItems from '@salesforce/apex/TM_AddProductsController.saveOpportunityItems';
import {FlowNavigationFinishEvent} from 'lightning/flowSupport';

const actions = [
    { label: 'Delete', name: 'delete' },
];

const columns = [
    {
        label: 'Product Name',
        fieldName: 'linkName',
        type: 'url',
        typeAttributes: {
            label: { 
                fieldName: 'Name' 
            },
            target: '_self',
            tooltip: {
                fieldName: 'Name'
            }
        },
        hideDefaultActions: true,
        sortable: true
    },
    {
        label: 'List Price',
        fieldName: 'UnitPrice',
        type: 'currency',
        cellAttributes: {
            alignment: 'left'
        },
        hideDefaultActions: true,
        sortable: true
    },
    {
        label: 'Product',
        fieldName: 'TM_Product__c',
        hideDefaultActions: true,
        sortable: true
    },
    {
        label: 'Product Line',
        fieldName: 'TM_Product_Line__c',
        hideDefaultActions: true,
        sortable: true
    },
    {
        label: 'Product Type',
        fieldName: 'TM_Product_Type__c',
        hideDefaultActions: true,
        sortable: true
    }
];

const oppItem_columns = [
    {
        label: 'Product',
        fieldName: 'linkName',
        type: 'url',
        typeAttributes: {
            label: {
                fieldName: 'Name'
            },
            target: '_self',
            tooltip: {
                fieldName: 'Name'
            }
        },
        hideDefaultActions: true
    },
    {
        label: 'Quantity',
        fieldName: 'Quantity',
        type: 'number',
        cellAttributes: {
            alignment: 'left'
        },
        editable: true,
        typeAttributes: {
            minimumFractionDigits: '2',
            maximumFractionDigits: '3',
        },
        hideDefaultActions: true
    },
    {
        label: 'Sales Price',
        fieldName: 'UnitPrice',
        type: 'currency',
        cellAttributes: {
            alignment: 'left'
        },
        editable: true,
        hideDefaultActions: true
    },
    {
        label: 'Date',
        fieldName: 'ServiceDate',
        type: 'date-local',
        editable: true,
        hideDefaultActions: true
    },
    {
        label: 'Line Description',
        fieldName: 'Description',
        editable: true,
        hideDefaultActions: true
    },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

export default class Tm_AddTreasuryProductsCmp extends LightningElement {

    @api oppId;
    @track columns = columns;
    @track oppItem_columns = oppItem_columns;
    @track addProduct = true;
    @track data = [];
    @track opptItemLst = [];
    @track checkOppItemLst = [];
    @track errors;
    @track defaultSortDirection = 'asc';
    @track sortDirection = 'asc';
    @track inSaving = false;
    @track sortedBy;

    @wire(getProductDetails, { oppId : '$oppId'})
    productDataLst({ data, error }) {
        if (data) {
            const dataLst = [];
            for (const prod of data) {
                const item = JSON.parse(JSON.stringify(prod));
                if (item.Product2) {
                    item.linkName = '/'+item.Product2Id;
                    item.TM_Product__c = item.Product2.TM_Product__c;
                    item.TM_Product_Line__c = item.Product2.TM_Product_Line__c;
                    item.TM_Product_Type__c = item.Product2.TM_Product_Type__c;
                }
                dataLst.push(item);
            }
            this.data = dataLst;
        }
    }

    handleFinishFlow(){
        const navigateNextEvent = new FlowNavigationFinishEvent();
        this.dispatchEvent(navigateNextEvent);
    }

    sortBy(field, reverse, primer) {
        const fieldName = field === 'linkName' ? 'Name' : field;
        const key = primer
            ? function (x) {
                  return primer(x[fieldName]);
              }
            : function (x) {
                  return x[fieldName];
              };
        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.data];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.data = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    handleSaveOppItem() {
        this.inSaving = true;
        const checkData = JSON.parse(JSON.stringify(this.template.querySelector("lightning-datatable").draftValues));
        const addLst = [];
        this.errors = { rows: {}, table: {} };
        const errorsObj = { rows: {}, table: {} };
        this.opptItemLst.forEach(v => {
            const draftItem = checkData.find(item => item.Product2Id === v.Product2Id);
            const addItem = {
                UnitPrice: draftItem ? draftItem.UnitPrice ? draftItem.UnitPrice : v.UnitPrice : v.UnitPrice,
                ServiceDate: draftItem ? draftItem.ServiceDate ? draftItem.ServiceDate : v.ServiceDate : v.ServiceDate,
                Description: draftItem ? draftItem.Description ? draftItem.Description : v.Description : v.Description,
                Quantity: draftItem ? draftItem.Quantity ? Number(draftItem.Quantity) : v.Quantity : v.Quantity,
                Product2Id: v.Product2Id,
                OpportunityId: this.oppId
            }
            addLst.push(addItem);
        })
        addLst.forEach(item => {
            if (!item.Quantity && !(item.UnitPrice || item.UnitPrice === 0)) {
                errorsObj.rows[item.Product2Id] = {
                    title: 'Missing required field.',
                    messages: [
                        'Enter Quantity.',
                        'Enter Sales Price.'
                    ],
                    fieldNames: ['Quantity', 'UnitPrice']
                };
            }else if (!item.Quantity && (item.UnitPrice || item.UnitPrice === 0)) {
                errorsObj.rows[item.Product2Id] = {
                    title: 'Missing required field.',
                    messages: [
                        'Enter Quantity.'
                    ],
                    fieldNames: ['Quantity']
                };
            } else if (item.Quantity && !(item.UnitPrice || item.UnitPrice === 0)) {
                errorsObj.rows[item.Product2Id] = {
                    title: 'Missing required field.',
                    messages: [
                        'Enter Sales Price.'
                    ],
                    fieldNames: ['UnitPrice']
                };
            }
        })
        if (JSON.stringify(errorsObj.rows) === '{}') {
            saveOpportunityItems({oppId: this.oppId, oppItems: JSON.parse(JSON.stringify(addLst))})
                .then((res) => {
                    this.handleFinishFlow()
                })
                .catch((e) => {
                    this.inSaving = false;
                })
        } else {
            this.errors = errorsObj;
            this.inSaving = false;
        }
    }

    handleBack() {
        const checkData = JSON.parse(JSON.stringify(this.template.querySelector("lightning-datatable").draftValues));
        for (const item of this.opptItemLst) {
            const draftData = checkData.find(v => v.Product2Id === item.Product2Id);
            if (draftData) {
                item.Quantity = draftData.Quantity || item.Quantity; 
                item.UnitPrice = draftData.UnitPrice || item.UnitPrice;
                item.ServiceDate = draftData.ServiceDate || item.ServiceDate;
                item.Description = draftData.Description ||  item.Description;
            }
        }
        this.addProduct = true;
    }

    findRowIndexByProduct2Id(Product2Id) {
        let ret = -1;
        this.opptItemLst.some((row, index) => {
            if (row.Product2Id === Product2Id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    deleteRow(row) {
        console.log(row);
        const { Product2Id } = row;
        const index = this.findRowIndexByProduct2Id(Product2Id);
        if (index !== -1) {
            this.opptItemLst = this.opptItemLst
                .slice(0, index)
                .concat(this.opptItemLst.slice(index + 1));
            this.checkOppItemLst = this.opptItemLst.map(v => '/' + v.Product2Id );
        }

    }

    handleRowAction(event) {
        const row = event.detail.row;
        this.deleteRow(row);
    }

    handleInputInfo(){
        const itemLst = [];
        const checkItemLst = [];
        const selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        for (const item of selectedRecords) {
            const oppItem = {
                linkName : item.linkName,
                Name : item.Name,
                UnitPrice: item.UnitPrice,
                ServiceDate: null,
                Quantity: null,
                Product2Id : item.Product2Id,
                OpportunityId : this.oppId,
                Description: null
            }
            checkItemLst.push(item.linkName);
            itemLst.push(oppItem);
        }
        this.checkOppItemLst = JSON.parse(JSON.stringify(checkItemLst));
        if (this.opptItemLst.length > 0) {
            for (const item of itemLst) {
                const oldItem = this.opptItemLst.find(v => v.Product2Id === item.Product2Id);
                if (oldItem) {
                    item.Quantity = oldItem.Quantity || null;
                    item.UnitPrice = oldItem.UnitPrice || 0;
                    item.ServiceDate = oldItem.ServiceDate || null;
                    item.Description = oldItem.Description || null;
                }
            }
        }
        this.opptItemLst = JSON.parse(JSON.stringify(itemLst));
        this.addProduct = false;

        // style.innerText = '.slds-th__action{background-color: #f10000; color: #ffff11;}';
        // this.template.querySelector('lightning-datatable').appendChild(style);
    }

    renderedCallback() {
        if (this.addProductd) {
            return; 
        }
    
        let style = document.createElement('style');
        style.innerText = '.slds-th__action{background-color: #f10000; color: #ffff11;}';
        console.log(document.querySelector('span[title="Quantity"]'));
    }
    
}