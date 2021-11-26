import LightningDatatable from 'lightning/datatable';
//import the template so that it can be reused
import DatatablePicklistTemplate from './picklist-template.html';
import {
    loadStyle
} from 'lightning/platformResourceLoader';
import CustomDataTableStylesResource from '@salesforce/resourceUrl/customDatatableStyles';

export default class CustomDataTable extends LightningDatatable {
    static customTypes = {
        picklist: {
            template: DatatablePicklistTemplate,
            typeAttributes: ['label', 'placeholder', 'options', 'value', 'recordId'],
        },
    };

    constructor() {
        super();
        Promise.all([
            loadStyle(this, CustomDataTableStylesResource),
        ]).then(() => {})
    }
}