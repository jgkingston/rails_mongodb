
// jQuery AJAX get repos from github api based on owner name
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

$(document).on('click', '.plant-seed', function() {
  console.log("Planting seed...")

  
  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script',
    data: {owner: $(this).attr('owner'), repo: $(this).attr('repo')}
  })
  
});


$(document).on('click', '.commits-log', function() {
  console.log("ready")
  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
  })
});



