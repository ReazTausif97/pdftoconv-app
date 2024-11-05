({
  handleUploadFinished: function (component, event) {
    var uploadedFiles = event.getParam("files");
      var fileId = uploadedFiles[0].documentId;
    component.set("v.fileContent", fileId);
  },

  handleSave: function (component, event, helper) {
    var action = component.get("c.saveKnowledgeBaseDocument");
    action.setParams({
      name: component.get("v.fileName"),
      fileContent: component.get("v.fileContent")
    });

    action.setCallback(this, function (response) {
      var state = response.getState();
        console.log(response.getState());
      var orgUrl = window.location.origin;

      if (state === "SUCCESS") {
        component.set("v.isOpen", false);
        component.set("v.lwcCreated", true);
        var navEvt = $A.get("e.force:navigateToURL"); //e.force:navigateToSObject
        navEvt.setParams({
          url: orgUrl + "/lightning/n/PDFtoConv__Knowledge_Base_Documents/"

          //"recordId": response.getReturnValue(),
          //"slideDevName": "detail"
        });
        navEvt.fire();
      } else {
        console.log("Failed with state: " + state);
      }
    });

    $A.enqueueAction(action);
  },

  openModal: function (component, event, helper) {
    component.set("v.isOpen", true);
  },

  closeModal: function (component, event, helper) {
    window.history.back();
  }
});