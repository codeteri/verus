import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['list']
  static values = {
    apiKey: String,
  }

  connect() {
    console.log("Hello from the index Page")
  }
  
  fire(event) {
    event.preventDefault();
    
    const keyword = "South Africa";
    const apiKey = this.apiKeyValue;
    
    const url = `https://eventregistry.org/api/v1/article/getArticles?keyword=${encodeURIComponent(keyword)}&apiKey=${apiKey}&lang=eng`;
    
    fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
      data.articles.results.forEach((result) => this.#send(result))
    })
    .catch(error => console.error("Error:", error));
  }
  
  #send(article) {
    const csrfToken = document.querySelector("[name='csrf-token']").content
    fetch("/articles", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({
        "author": article.authors[0] ? article.authors[0].name : "Unknown",
        "photo": article.image,
        "title": article.title,
        "content": article.body,
        "source": article.source.title
      })
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values
          this.listTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
      })
  }
}
