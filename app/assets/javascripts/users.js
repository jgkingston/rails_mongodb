
// jQuery AJAX get repo from github api
$(document).ready(function() {
  $.ajax({
    url: $('.repolist').attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
    })
});



