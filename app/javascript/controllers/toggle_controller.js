import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement", "togglableElementTwo"]

  fire() {
    this.togglableElementTarget.classList.toggle("d-none")
    this.togglableElementTwoTarget.classList.toggle("d-none")
  }
}
