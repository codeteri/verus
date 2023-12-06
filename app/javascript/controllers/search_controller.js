import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["results"];

  myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
  }
  
  filterFunction() {
    var input, filter, ul, li, a, i;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    div = document.getElementById("myDropdown");
    a = div.getElementsByTagName("a");
    for (i = 0; i < a.length; i++) {
      txtValue = a[i].textContent || a[i].innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        a[i].style.display = "";
      } else {
        a[i].style.display = "none";
      }
    }
  }

  fire() {
    const form = this.element.querySelector("form");
    const query = form.querySelector("input[name='query']").value;

    if (query.length >= 3) {
      $.ajax({
        url: form.action,
        data: { query: query },
        success: (data) => {
          this.resultsTarget.innerHTML = data;
          this.element.classList.remove("d-none");
        },
        error: (error) => {
          console.error("Error fetching search results:", error);
        },
      });
    } else {
      this.resultsTarget.innerHTML = "";
      this.element.classList.add("d-none");
    }
  }
}
