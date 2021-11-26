import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import newCandidateFormInit from '@salesforce/apex/NewCandidateFormController.newCandidateFormInit';
import candidateObject from '@salesforce/schema/Candidate__c';
import jobApplicationObject from '@salesforce/schema/Job_Application__c';
import CV_FIELD from '@salesforce/schema/Job_Application__c.CV__c';
import POSITION_FIELD from '@salesforce/schema/Job_Application__c.Position__c';
import CANDIDATE_FIELD from '@salesforce/schema/Job_Application__c.Candidate__c';
import STAGE_FIELD from '@salesforce/schema/Job_Application__c.Stage__c';
// labels
import Success_text from '@salesforce/label/c.Success_text';
import Error_text from '@salesforce/label/c.Error_text';
import Records_created from '@salesforce/label/c.Records_created';
import Save_text from '@salesforce/label/c.Save_text';
import Back_text from '@salesforce/label/c.Back_text';
import New_Candidate_Form_text from '@salesforce/label/c.New_Candidate_Form_text';
import Job_Application_for_the_Candidate from '@salesforce/label/c.Job_Application_for_the_Candidate';
import Add_Job_Application from '@salesforce/label/c.Add_Job_Application';
import Remove_Job_Application from '@salesforce/label/c.Remove_Job_Application';
import Records_updated_error from '@salesforce/label/c.Records_updated_error';
import Records_access_error from '@salesforce/label/c.Records_access_error';
import Candidate_record_created_success from '@salesforce/label/c.Candidate_record_created_success';
import Candidate_record_create_duplicate_email from '@salesforce/label/c.Candidate_record_create_duplicate_email';
import Candidate_record_created_with_job_app_error from '@salesforce/label/c.Candidate_record_created_with_job_app_error';

const REGEX_URL = new RegExp("^((http|https)://)??(www[.])??([a-zA-Z0-9]|-)+?([.][a-zA-Z0-9(-|/|=|?)??]+?)+?$");
export default class NewCandidateForm extends LightningElement {
  @track candidateFields = []
  @track jobApplicationRequiredFields = [CV_FIELD, POSITION_FIELD, STAGE_FIELD]
  @track fieldSetMembers
  @track candidateId = ''
  candidateCreatedSuccess = false
  candidateObjectApiName = candidateObject.objectApiName
  jobApplicationObjectApiName = jobApplicationObject.objectApiName
  candidateField = CANDIDATE_FIELD
  showJobAppForm = false
  inputsHaveError = false
  labels = {Save_text, Back_text, New_Candidate_Form_text, Job_Application_for_the_Candidate, Add_Job_Application, Remove_Job_Application}

  async connectedCallback() {
    try {
      this.candidateFields = await newCandidateFormInit()
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

  handleCandidateFormSuccess(e) {
    if (this.showJobAppForm) {
      this.candidateId = e.detail.id
      setTimeout(() => {
        this.template.querySelector('[data-id="jobAppForm"]').submit();
      }, 0);
    } else {
      this.dispatchEvent(
        new ShowToastEvent({
          title: Success_text,
          message: Candidate_record_created_success,
          variant: 'success'
        })
      );
    }
  }

  handleJobAppFormSuccess() {
    this.dispatchEvent(
      new ShowToastEvent({
        title: Success_text,
        message: Records_created,
        variant: 'success'
      })
    );
  }

  handleCandidateFormError(e) {
    console.log(e.detail.message);
    if (e.detail.detail.startsWith('duplicate value found')) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Candidate_record_create_duplicate_email,
          variant: 'error'
        })
      );
    } else {
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_updated_error,
          variant: 'error'
        })
      );
    }
  }

  handleJobAppFormError(e) {
    console.log(e.detail.message);
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Candidate_record_created_with_job_app_error,
          variant: 'error'
        })
      );
  }

  handleSave() {
    this.validate()
    if (this.inputsHaveError) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: Error_text,
          message: Records_updated_error,
          variant: 'error'
        })
      );
    } else {
      this.template.querySelector('[data-id="candidateForm"]').submit();
    }
  }

  validateUrl(inputValue) {
    return REGEX_URL.test(inputValue)
  }

  validate() {
    const allValid = [...this.template.querySelectorAll('lightning-input-field')]
      .reduce((validSoFar, inputCmp) => {
        if (inputCmp.fieldName == 'CV__c' && !this.validateUrl(inputCmp.value)) {
          validSoFar = false
        }
        return (validSoFar && inputCmp.reportValidity());
      }, true);
    allValid ? this.inputsHaveError = false : this.inputsHaveError = true 
  }

  handleShowJobAppForm() {
    this.showJobAppForm = true
  }
  handleHideJobAppForm() {
    this.showJobAppForm = false
  }

  handleBack() {
    window.history.back()
  }
}