
$(document).ready(function() {
  console.log("ready")
  $.ajax({
    url: $('.repo-events').attr('ajax_path') ,
    type: 'GET',
    dataType: 'script',
    data: {q: $('.repo').attr('repo-name')}
  })
});


