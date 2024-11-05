import { LightningElement, track } from "lwc";
import saveApiKey from "@salesforce/apex/SecretKeyController.saveSecretKey"; // Apex method

export default class KeySetup extends LightningElement {
  @track secretKey = "";
  @track errorMessage = "";
  @track successMessage = "";

  // Handle input field change
  handleInputChange(event) {
    this.secretKey = event.target.value;
    this.errorMessage = "";
    this.successMessage = "";
  }

  // Handle Set Key button click
  handleSetKey() {
    if (this.secretKey === "" || this.secretKey.trim().length === 0) {
      // Validate if the input is empty
      this.errorMessage = "Please enter your secret key.";
    } else {
      // Call Apex to save the key
      saveApiKey({ key: this.secretKey })
        .then(() => {
          // Successfully saved the API key
          this.errorMessage = ""; // Clear any error
          this.successMessage = "Secret Key Saved Successfully";
          // Optionally show success message
        })
        .catch((error) => {
          this.errorMessage = "An error occurred while saving the key.";
          console.error(error);
        });
    }
  }
}