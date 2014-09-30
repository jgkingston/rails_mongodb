
// jQuery AJAX get repo from github api
$(document).on('click', '.gather-seeds', function() {
  console.log("Gathering ...")
  $.ajax({
    url: $('.repolist').attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
    })
});


$(document).on('click', '.require-tree', function() {
  var owner = $('#owner').val();
  var repo = $('#repo').val();
  console.log("Requiring tree...")

  if( owner != "" && repo != "") {
    $.ajax({
      url: $(this).attr('ajax_path') ,
      type: 'GET',
      dataType: 'script',
      data: {owner: owner, repo: repo}
    })
  }
});




