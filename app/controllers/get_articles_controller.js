import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-articles"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    // console.log("hello from articles controller")
  }

  fire(event) {
    event.preventDefault();

    const keyword = "Elon Musk";
    const apiKey = "2d961af2-1879-4e3d-bca9-8c0b0c45853f";

    const url = `http://eventregistry.org/api/v1/article/getArticles?keyword=${encodeURIComponent(keyword)}&apiKey=${apiKey}`;

    fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then(response => response.json())
      .then(data => console.log(data))
      .catch(error => console.error("Error:", error));
  }
}
