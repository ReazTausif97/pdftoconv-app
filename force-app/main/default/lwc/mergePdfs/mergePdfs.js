import { LightningElement, wire, track } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import savePDF from "@salesforce/apex/KnowledgeDocumentController.savePDF";
import { refreshApex } from "@salesforce/apex";
import pdflib from "@salesforce/resourceUrl/pdfmng";
import getData from "@salesforce/apex/KnowledgeDocumentController.getAllKnowledgeBase";
import setSync from "@salesforce/apex/KnowledgeDocumentController.setSync";
import checkSync from "@salesforce/apex/KnowledgeDocumentController.checkSync";
import fetchVersionData from "@salesforce/apex/KnowledgeDocumentController.getVersionData";
import { subscribe, unsubscribe, onError } from "lightning/empApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import uploadPDF from "@salesforce/apex/Ingest.uploadPDF";
export default class MergePdfs extends LightningElement {
  docData = [];
  @track isLoaded = false;
  @track isSynced = "";
  @track wiredSyncResult;
  channelName = "/event/PDFtoConv__knowledgeDocumentChangeEvent__e";
  subscription = {};

  connectedCallback() {
    this.refreshData();
    loadScript(this, pdflib).then(() => {
      //this.mergePdf();
    });
    this.registerErrorListener();

    this.handleSubscribe();
  }
  disconnectedCallback() {
    this.handleUnsubscribe();
  }
  refreshData() {
    getData()
      .then((result) => {
        this.docData = JSON.parse(JSON.stringify(result));
        console.log(this.docData, typeof this.docData);
        console.log("Size of File are " + this.docData.length);
        if (this.docData.length == 0) {
          this.isSynced = true;
        }
      })
      .catch((error) => {
        console.log("error while calling ", error);
      });
  }

  @wire(checkSync)
  wiredCheckSync(result) {
    this.wiredSyncResult = result;
    const { data, error } = result;
    if (data) {
      console.log("Data ", data);
      this.isSynced = data;
      console.log("IsSynced ", this.isSynced);
    } else if (error) {
      console.error("Error:", error);
    }
  }
  changeSync() {
    this.isSynced = false;
  }

  handleSubscribe() {
    // Callback invoked whenever a new event message is received
    const messageCallback = (response) => {
      console.log("New message received: ", JSON.stringify(response));
      this.changeSync();
    };

    // Invoke subscribe method of empApi. Pass reference to messageCallback
    subscribe(this.channelName, -1, messageCallback).then((response) => {
      // Response contains the subscription information on subscribe call
      console.log(
        "Subscription request sent to: ",
        JSON.stringify(response.channel)
      );
      this.subscription = response;
      console.log("subscription ", this.subscription);
    });
  }

  handleUnsubscribe() {
    // Invoke unsubscribe method of empApi
    unsubscribe(this.subscription, (response) => {
      console.log("unsubscribe() response: ", JSON.stringify(response));
      // Response is true for successful unsubscribe
    });
  }

  registerErrorListener() {
    // Invoke onError empApi method
    onError((error) => {
      console.log("Received error from server: ", JSON.stringify(error));
      // Error contains the server-side error
    });
  }
  async mergePdf() {
    console.log("merge called");
    const mergedPdf = await PDFLib.PDFDocument.create();
    console.log("Merged PDF Document: ", mergedPdf);
    if (this.docData.length < 1) return;

    for (let i = 0; i < this.docData.length; i++) {
      console.log(this.docData[i]);
      const { Id } = this.docData[i];
      const versionData = await this.getVersionData(Id);
      const tempBytes = Uint8Array.from(atob(versionData), (c) =>
        c.charCodeAt(0)
      );
      console.log("tempBytes: ", tempBytes);

      const pdfDoc = await PDFLib.PDFDocument.load(tempBytes);
      const copiedPages = await mergedPdf.copyPages(
        pdfDoc,
        pdfDoc.getPageIndices()
      );
      copiedPages.forEach((page) => mergedPdf.addPage(page));
    }

    const convertBlobToBase64 = (blob) => {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
          const base64String = reader.result.split(",")[1];
          resolve(base64String);
        };
        reader.onerror = () => {
          reject("Error converting blob to base64");
        };
        reader.readAsDataURL(blob);
      });
    };

    const mergedPdfFile = await mergedPdf.save();
    console.log("after merge complete");
    const blob = new Blob([mergedPdfFile], { type: "application/pdf" });
    const base64String = await convertBlobToBase64(blob);

    await savePDF({ base64Strings: base64String })
      .then(() => {
        console.log("base64string list saved successfully");
      })
      .catch((error) => {
        console.log("Error saving chunk: ", error);
      });
  }
  handleSync() {
    console.log("Handle Sync Called");
    this.isLoaded = true;
    console.log("isLoaded ", this.isLoaded);
    this.refreshData();
    this.mergePdf()
      .then(() => {
        uploadPDF()
          .then(() => {
            console.log("mergePdf finished");
            setSync()
              .then(() => {
                refreshApex(this.wiredSyncResult);
                this.isSynced = true;
              })
              .catch((error) => {
                console.log("error while calling ", error);
              });
            this.isLoaded = false;
            console.log("isLoaded ", this.isLoaded);
          })
          .catch((error) => {
            // Handle the AuraHandledException
            this.handleError(error);
            this.isLoaded = false;
          });
      })
      .catch((error) => {
        console.log("error while calling ", error);
      })
      .catch((error) => {
        console.log("error while calling ", error);
      });
  }

  handleError(error) {
    if (error && error.body && error.body.message) {
      const toastEvent = new ShowToastEvent({
        title: "Error",
        message: error.body.message,
        variant: "error"
      });
      this.dispatchEvent(toastEvent);
    } else {
      console.log("Unexpected error: ", error);
    }
  }

  async getVersionData(contentVersionId) {
    // Fetch the version data (base64 encoded) from the server using the content version Id
    const versionData = await fetchVersionData({
      contentVersionId: contentVersionId
    });
    console.log("versionData ", versionData);
    return versionData;
  }
}