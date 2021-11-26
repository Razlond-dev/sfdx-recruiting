import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCandidateFormFields from '@salesforce/apex/CustomCandidateFieldsetController.getCandidateFormFields';
import customCandidateFieldsetInit from '@salesforce/apex/CustomCandidateFieldsetController.customCandidateFieldsetInit';
import updateFieldSetMetadata from '@salesforce/apex/CustomCandidateFieldsetController.updateFieldSetMetadata';
// labels
import Success_text from '@salesforce/label/c.Success_text';
import Error_text from '@salesforce/label/c.Error_text';
import Records_updated from '@salesforce/label/c.Records_updated';
import Save_text from '@salesforce/label/c.Save_text';
import Records_updated_error from '@salesforce/label/c.Records_updated_error';
import Records_access_error from '@salesforce/label/c.Records_access_error';
import Field_API_Name from '@salesforce/label/c.Field_API_Name';
import Field_Label from '@salesforce/label/c.Field_Label';
import Field_Type from '@salesforce/label/c.Field_Type';
import Field_Sets from '@salesforce/label/c.Field_Sets';
import Required_text from '@salesforce/label/c.Required_text';

export default class CustomCandidateFieldset extends LightningElement {
  @track fieldSetNames = []
  @track listOptions = []
  @track fieldSetMembers
  initData
  selectedFieldSet = ''
  labels = {Save_text, Field_API_Name, Field_Label, Field_Type, Required_text, Field_Sets}

  async connectedCallback() {
    try {
      this.initData = await customCandidateFieldsetInit()
      this.selectedFieldSet = this.initData.fieldSetMetadataName
      this.fieldSetMembers = JSON.parse(this.initData.fieldSetMembers)
      this.listOptions = JSON.parse(this.initData.fieldSets)
    } catch (error) {
      console.log(error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_access_error,
          variant: 'error'
        })
      );
    }
  }

  async handleSelectedFieldsetChange(e) {
    try {
      this.selectedFieldSet = e.target.value
      this.fieldSetMembers = JSON.parse(await getCandidateFormFields({fieldSetName: this.selectedFieldSet }))
    } catch (error) {
      console.log(error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_access_error,
          variant: 'error'
        })
      );
    }
  }

  async handleSave() {
    try {
      await updateFieldSetMetadata({fieldValue: this.selectedFieldSet})
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
}