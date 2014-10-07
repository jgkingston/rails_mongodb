
// jQuery AJAX get repos from github api based on owner name
$(document).on('click', '.gather-seeds', function() {
  
  var owner = $('#owner').val();

  console.log("Gathering seeds ...")

  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script',
    data: {owner: owner}
    })
});


$(document).on('click', '.require-tree', function() {
  
  var ssh = $('#SSH').val();

  var ssh_array = ssh.split("/");

  var owner = ssh_array[3];

  var repo = ssh_array[4].slice(0,-4);

  console.log("Requiring tree...");

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



