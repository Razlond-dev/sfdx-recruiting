import { LightningElement, api } from 'lwc';

export default class DatatablePicklist extends LightningElement {
    @api label;
    @api placeholder;
    @api options;
    @api value;
    @api recordId;

    handleChange(event) {
        //show the selected value on UI
        this.value = event.detail.value;

        //fire event to send context and selected value to the data table
        this.dispatchEvent(new CustomEvent('picklistchanged', {
            composed: true,
            bubbles: true,
            cancelable: true,
            detail: {
                recordId: this.recordId, value: this.value
            }
        }));
    }

}