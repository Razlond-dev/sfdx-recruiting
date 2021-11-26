import { api, LightningElement, track, wire } from 'lwc';
import getPositions from '@salesforce/apex/PositionController.getPositions';
import savePositions from '@salesforce/apex/PositionController.savePositions';
import getPositionsCount from '@salesforce/apex/PositionController.getPositionsCount';
import getCustomSettings from '@salesforce/apex/CustomSettingsController.getCustomSettings';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import statusField from '@salesforce/schema/Position__c.Status__c';
import positionObject from '@salesforce/schema/Position__c';
// labels
import All_Statuses from '@salesforce/label/c.All_Statuses';
import Success_text from '@salesforce/label/c.Success_text';
import Error_text from '@salesforce/label/c.Error_text';
import Records_updated from '@salesforce/label/c.Records_updated';
import Save_text from '@salesforce/label/c.Save_text';
import Records_updated_error from '@salesforce/label/c.Records_updated_error';
import Records_access_error from '@salesforce/label/c.Records_access_error';

export default class PositionsTable extends LightningElement {
  @track statusColumn = {
    type: 'picklist', typeAttributes: {
      placeholder: 'Choose status', options: [],
      value: { fieldName: 'Status__c' },
      recordId: { fieldName: 'Id' }
    }
  }
  @track columns = [];
  @api recordsPerPage
  data;
  draftValues = [];
  selectedStatus = All_Statuses;
  filterOptions = [{ attributes: null, label: All_Statuses, validFor: [], value: All_Statuses }]
  picklistOptions = []
  @api totalRecords;
  saveLabel = Save_text
  customSettings
  customColor
  columnsRendered = false

  @wire(getObjectInfo, { objectApiName: positionObject })
  objectInfo;

  get positionFields() {
    if (this.objectInfo.data) {
      return this.objectInfo.data.fields
    }
  }

  @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: statusField })
  setPicklistOptions({ error, data }) {
    if (data) {
      this.filterOptions = [...this.filterOptions, ...data.values];
      // set options for data table picklist
      this.filterOptions.forEach((option, index) => index === 0 ? null : this.picklistOptions.push({ label: option.label, value: option.value }))
      this.statusColumn.typeAttributes.options = [...this.picklistOptions]
      this.statusColumn.label = this.positionFields.Status__c.label
      this.statusColumn.fieldName = this.positionFields.Status__c.apiName
    } else if (error) {
      console.log(error);
    }
  }

  async connectedCallback() {
    try {
      await this.updateColorThemes()
      this.totalRecords = await getPositionsCount({ selectedStatus: this.selectedStatus })
      this.data = await getPositions({ offsetRange: 0, recordsNum: this.recordsPerPage, selectedStatus: this.selectedStatus });
    } catch (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_access_error,
          variant: 'error'
        })
      );
    }
  }


  async renderedCallback() {
    if (this.positionFields && this.columnsRendered == false) {
      this.columnsRendered = true
      if (this.positionFields.Max_Salary__c) {
        this.columns = [
          { label: this.positionFields.Name.label, fieldName: this.positionFields.Name.apiName, type: 'text' },
          this.statusColumn,
          { label: this.positionFields.Closed_At__c.label, fieldName: this.positionFields.Closed_At__c.apiName, type: 'date' },
          { label: this.positionFields.Opened_At__c.label, fieldName: this.positionFields.Opened_At__c.apiName, type: 'date' },
          { label: this.positionFields.Max_Salary__c.label, fieldName: this.positionFields.Max_Salary__c.apiName, type: 'currency' },
          { label: this.positionFields.Min_Salary__c.label, fieldName: this.positionFields.Min_Salary__c.apiName, type: 'currency' },
        ];
      }
    }
  }

  async updateColorThemes() {
    this.customSettings = await getCustomSettings();
    const topElement = this.template.querySelector("lightning-card")
    topElement.style.setProperty("--background-color", this.customSettings.Background_Color__c)
    topElement.style.setProperty("--button-color", this.customSettings.Button_Color__c)
    topElement.style.setProperty("--link-color", this.customSettings.Link_Color__c)
  }

  handlePicklistChanged(event) {
    const { recordId, value } = event.detail;
    const recordIdDraftValues = this.draftValues.findIndex(pos => pos.Id == recordId);
    if (recordIdDraftValues !== -1) {
      this.draftValues[recordIdDraftValues] = { Id: recordId, Status__c: value };
    } else {
      this.draftValues.push({ Id: recordId, Status__c: value })
    }
  }

  async handleSave() {
    try {
      await savePositions({ data: this.draftValues });
      this.data = await getPositions({ offsetRange: 0, recordsNum: this.recordsPerPage, selectedStatus: this.selectedStatus });
      this.totalRecords = 0
      this.totalRecords = await getPositionsCount({ selectedStatus: this.selectedStatus })
      this.dispatchEvent(
        new ShowToastEvent({
          title: Success_text,
          message: Records_updated,
          variant: 'success'
        })
      );
    } catch (error) {
      console.log(error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_updated_error,
          variant: 'error'
        })
      );
    }
  }

  async handleSelectedStatusChange(event) {
    this.selectedStatus = event.detail.value
    this.totalRecords = 0
    this.totalRecords = await getPositionsCount({ selectedStatus: this.selectedStatus })
    this.data = await getPositions({ offsetRange: 0, recordsNum: this.recordsPerPage, selectedStatus: this.selectedStatus });
  }

  async handlePagination(event) {
    const offset = (event.detail.pageNo - 1) * this.recordsPerPage
    this.data = await getPositions({ offsetRange: offset, recordsNum: this.recordsPerPage, selectedStatus: this.selectedStatus });
  }
}
