import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-likes"
export default class extends Controller {
  connect() {
    console.log("hello")
  }
}
