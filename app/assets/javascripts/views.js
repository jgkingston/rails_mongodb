// Load grid view
$(document).on('click', '.grid-view', function() {

  

  console.log("ready")
  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
  })

  $('.search-bar').css("display", "block")
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

  if ($('#showLeft').hasClass('active')) {

    $(this).toggleClass('active');
    $('#cbp-spmenu-s1').toggleClass('cbp-spmenu-open');
    $('.forest').toggleClass('counter-push-margin');
    $(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
  }

  $.ajax({
    url: $(this).attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
  })

  $('.search-bar').css("display", "none")
});

// Scroll to info panel on small screen in portrait view on click

$(document).on('click', '.portrait', function() {
  
  var height = $('.right-info').scrollTop()
 
  $('body').animate({ 

    scrollTop: $('.right-info').offset().top

  }, 300);

});




