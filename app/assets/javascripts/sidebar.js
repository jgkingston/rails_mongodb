// Toggle Sidebar
$(document).on('click', '#showLeft', function() {
  
    console.log("looking for menus")
    $(this).toggleClass('active');
    $('#cbp-spmenu-s1').toggleClass('cbp-spmenu-open');
    $('.forest').toggleClass('counter-push-margin');
    $(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');

});
