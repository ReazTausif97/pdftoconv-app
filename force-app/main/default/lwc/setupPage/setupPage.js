import { LightningElement, track } from "lwc";

export default class KnowledgeBase extends LightningElement {
  selectedItem = "Get Started";
  isGetStarted = true;
  isKeySetup = false;
  isSettings = false;

  handleSelect(event) {
    const selected = event.detail.name;
    this.setTab(selected);
  }

  setTab(selectedTab) {
    this.isGetStarted = selectedTab === "Get Started";
    this.isKeySetup = selectedTab === "Key Setup";
    this.isSettings = selectedTab === "settings";
    this.selectedItem = selectedTab;
  }

  handleAddKey() {
    // Switch to the Key Setup tab when the "Add Key" button is clicked
    this.setTab("Key Setup");
  }
}