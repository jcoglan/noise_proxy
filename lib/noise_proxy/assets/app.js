function updateFromServer() {
  $.get('/api', function(response) {
    for (var key in response)
      $('input[name=' + key + ']').val(response[key]);
  });
}

function pushToServer(form) {
  $.post('/api', $(form).serialize());
}

updateFromServer()

$('form').submit(function(event) {
  event.preventDefault();
  pushToServer(this);
});
