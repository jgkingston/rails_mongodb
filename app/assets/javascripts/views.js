// Load grid view
$(document).on('click', '.grid-view', function() {
  console.log("ready")
  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
  })
});

// Grid Filter
$(document).ready(function(){
  var $container = $('.item-container')

  $container.isotope({
    itemSelector: '.item',
    layoutMode: 'fitRows'   
  }).isotopeSearchFilter();

})

// Load portrait view
$(document).on('click', '.load-portrait', function() {
  console.log("ready")
  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
  })
});






