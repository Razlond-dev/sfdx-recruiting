import { LightningElement } from 'lwc';
import getCustomSettings from '@salesforce/apex/CustomSettingsController.getCustomSettings';
import updateCustomSettings from '@salesforce/apex/CustomSettingsController.updateCustomSettings';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// labels
import Success_text from '@salesforce/label/c.Success_text';
import Background_color_text from '@salesforce/label/c.Background_color_text';
import Button_color_text from '@salesforce/label/c.Button_color_text';
import Link_color_text from '@salesforce/label/c.Link_color_text';
import Records_updated from '@salesforce/label/c.Records_updated';
import HEX_color_validation_error from '@salesforce/label/c.HEX_color_validation_error';
import Save_text from '@salesforce/label/c.Save_text';
import Records_updated_error from '@salesforce/label/c.Records_updated_error';
import Custom_theme_title from '@salesforce/label/c.Custom_theme_title';
import Error_text from '@salesforce/label/c.Error_text';

export default class CustomTheme extends LightningElement {
  customSettings
  backgroundColor
  buttonColor
  linkColor
  saveLabel = Save_text
  customThemeTitleLabel = Custom_theme_title
  backgroundColorLabel = Background_color_text
  buttonColorLabel = Button_color_text
  linkColorLabel = Link_color_text
  inputsHaveError = false

  async connectedCallback() {
    this.customSettings = await getCustomSettings()

    this.backgroundColor = this.customSettings.Background_Color__c
    this.buttonColor = this.customSettings.Button_Color__c
    this.linkColor = this.customSettings.Link_Color__c
  }

  handleBackgroundColorChange(e) {
    this.backgroundColor = e.target.value
    this.customSettings.Background_Color__c = e.target.value
    this.validate()
  }

  handleButtonColorChange(e) {
    this.buttonColor = e.target.value
    this.customSettings.Button_Color__c = e.target.value
    this.validate()
  }

  handleLinkColorChange(e) {
    this.linkColor = e.target.value
    this.customSettings.Link_Color__c = e.target.value
    this.validate()
  }

  validate() {
    const allValid = [...this.template.querySelectorAll('lightning-input')]
      .reduce((validSoFar, inputCmp) => {
        if (inputCmp.value.charAt(0) !== '#') {
          inputCmp.setCustomValidity(HEX_color_validation_error);
        } else {
          inputCmp.setCustomValidity("");
        }
        inputCmp.reportValidity();
        return validSoFar && inputCmp.checkValidity();
      }, true);
    if (allValid) {
      this.inputsHaveError = false
    } else {
      this.inputsHaveError = true
    }
  }

  async handleSave() {
    try {
      await updateCustomSettings({ updatedSettings: this.customSettings })
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