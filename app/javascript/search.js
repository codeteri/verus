$(document).on('turbolinks:load', function() {
  $('.search-input').on('input', function() {
    var query = $(this).val();

    if (query.length >= 3) {
      $.ajax({
        url: '/articles/search.json',
        data: { query: query },
        success: function(data) {
          $('#search-results-container').html(data);
        }
      });
    } else {
      $('#search-results-container').empty();
    }
  });
});