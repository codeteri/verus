// app/javascript/controllers/content_loader_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "link", "content" ]

  connect() {
    this.linkTargets.forEach((link) => {
      link.addEventListener('click', (event) => {
        event.preventDefault();
        this.loadContent(link.href);
      });
    });
  }

  async loadContent(url) {
    const response = await fetch(url);
    const html = await response.text();
    this.contentTarget.innerHTML = html;
  }
}
