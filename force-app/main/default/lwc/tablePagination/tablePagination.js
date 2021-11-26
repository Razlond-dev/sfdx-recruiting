import { api, LightningElement } from 'lwc';
import Previous_text from '@salesforce/label/c.Previous_text';
import Next_text from '@salesforce/label/c.Next_text';
export default class TablePagination extends LightningElement {
  @api recordsPerPage;
  @api totalRecords;
  pageNo;
  pageLinks = []
  totalPages
  nextLabel = Next_text
  previousLabel = Previous_text

  renderedCallback() {
    this.pageNo = 1
    this.refreshPageLinks()
    this.disableEnableActions()
  }

  handleClick(event) {
    let label = event.target.label
    if (label === this.nextLabel) {
      this.pageNo++
    } else if (label === this.previousLabel) {
      this.pageNo--
    }
    this.preparePaginationList()
  }

  handlePageClick(event) {
    this.pageNo = event.target.label;
    this.preparePaginationList();
  }

  refreshPageLinks() {
    const initialPageLinks = []
    this.totalPages = Math.ceil(this.totalRecords / this.recordsPerPage);
    for (let i = 1; i <= this.totalPages; i++) {
      initialPageLinks.push(i);
    }
    JSON.stringify(this.pageLinks) == JSON.stringify(initialPageLinks) ? null : this.pageLinks = [...initialPageLinks]
  }

  preparePaginationList() {
    this.disableEnableActions()
    this.dispatchEvent(new CustomEvent('pagination', {
      detail: {
        pageNo: this.pageNo
      }
    }));
  }

  disableEnableActions() {
    let buttons = this.template.querySelectorAll("lightning-button");
    this.totalPages = Math.ceil(this.totalRecords / this.recordsPerPage);
    buttons.forEach(bun => {
      if (bun.label === this.pageNo) {
        bun.disabled = true;
      } else {
        bun.disabled = false;
      }

      if (bun.label === this.previousLabel) {
        bun.disabled = this.pageNo === 1 ? true : false;
      } else if (bun.label === this.nextLabel) {
        bun.disabled = this.pageNo === this.totalPages || this.totalPages === 0 ? true : false;
      }
    });
  }
}