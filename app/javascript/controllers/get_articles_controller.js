import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['list', 'image']
  static values = {
    apiKey: String,
  }

  connect() {
    // this.fire();
    console.log("get articles controller connected")
  }

  changeUrl(event) {
    event.target.src = "https://images.unsplash.com/photo-1682687982502-1529b3b33f85?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  }

  fire() {
    const keywords = [
      "InternationalRelations",
      "Elections",
      "GovernmentPolicies",
      "GlobalAffairs",
      "GovernmentPolicies",
    ];

    const apiKey = this.apiKeyValue;

    // Construct the query object with the OR condition and lang parameter
    const query = {
      $query: {
        $or: keywords.map(keyword => ({ keyword })),
        $and: [{ lang: "eng" }]
      }
    };

    const url = `https://eventregistry.org/api/v1/article/getArticles?query=${encodeURIComponent(JSON.stringify(query))}&apiKey=${apiKey}&includeArticleAuthors=true&includeArticleImage=true`;

    fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    })
    .then(response => response.json())
    .then(data => {
      data.articles.results.forEach((result) => {
        if (result.image) {
          this.#send(result);
        }
      });
    })
    .catch(error => console.error("Error:", error));
  }

  #send(article) {
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    fetch("/articles", {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({
        "author": article.authors[0] ? article.authors[0].name : "Unknown",
        "photo_url": article.image,
        "title": article.title,
        "content": article.body,
        "source": article.source.title
      })
    })
    .then(response => response.json())
    .then((data) => {
      // console.log(data);
      if (data.inserted_item) {
        // beforeend could also be dynamic with Stimulus values
        this.listTarget.insertAdjacentHTML("beforeend", data.inserted_item);
      }
    });
  }
}
