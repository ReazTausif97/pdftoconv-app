import { LightningElement ,track} from "lwc";
import createChannelandQueue from "@salesforce/apex/settingConfigController.createChannelandQueue";
import getPermissionSetId from "@salesforce/apex/settingConfigController.getPermissionSetId"

export default class GetStarted extends LightningElement {
  @track permissionSetUrl="/lightning/setup/PermSets/";
  orgUrl;
  showModal = false;
  permissionSetId


  connectedCallback() {
    this.orgUrl = window.location.origin;
   
  }
  renderedCallback(){
 getPermissionSetId().then((res)=>{
      this.permissionSetId = res;
      this.permissionSetUrl="/lightning/setup/PermSets/page?address=%2F"+this.permissionSetId+"%2Fe%3Fs%3DClassAccess";
    })
  }

  handleAddKeyClick() {
    // Dispatch the event to notify parent to switch to Key Setup
    const addKeyEvent = new CustomEvent("addkey");
    this.dispatchEvent(addKeyEvent);
  }

  handleSetupClick() {
    this.showModal = true;
    createChannelandQueue()
      .then(() => {
        this.showModal = false;
      })
      .catch((error) => {
        this.showModal = false;
        console.error("Error in setup:", error);
      });
  }
}