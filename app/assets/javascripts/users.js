
// jQuery AJAX function to call BoardGameGeek API
// $(document).ready(function() {
//   console.log("ready")
//   $.ajax({
//     url: $('.username').attr('ajax_path') ,
//     type: 'GET',
//     dataType: 'script',
//     data: {q: $('.username').attr('bgg_username')}
//   })
// });

$(document).ready(function() {
  console.log("ready")
  $.ajax({
    url: $('.repolist').attr('ajax_path') ,
    type: 'GET',
    dataType: 'script'
    })
});




$(document).on('click', $('.find-toy-btn'), function(){


})




function initialize() {
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(32.802228, -79.957037),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    disableDefaultUI: true,
    styles: [{"stylers":[{"visibility":"off"}]},{"featureType":"road","stylers":[{"visibility":"on"},{"color":"#ffffff"}]},{"featureType":"road.arterial","stylers":[{"visibility":"on"},{"color":"#fee379"}]},{"featureType":"road.highway","stylers":[{"visibility":"on"},{"color":"#fee379"}]},{"featureType":"landscape","stylers":[{"visibility":"on"},{"color":"#f3f4f4"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"color":"#7fc8ed"}]},{},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#83cead"}]},{"elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"weight":0.9},{"visibility":"off"}]}]
  };

  var mapDiv = document.getElementById('map-canvas');
  var map = new google.maps.Map(mapDiv, mapOptions);

  // We add a DOM event here to show an alert if the DIV containing the
  // map is clicked. Note that we do this within the intialize function
  // since the document object isn't loaded until after the window.load
  // event.
  google.maps.event.addDomListener(map, 'click', function(e) {
    placeMarker(e.latLng, map);
  });

  // var map = new google.maps.Map(document.getElementById('map-canvas'),
  //     mapOptions);
}

function placeMarker(position, map) {
  var marker = new google.maps.Marker({
    position: position,
    map: map
  });
  map.panTo(position);
}

function showAlert() {
  window.alert('DIV clicked');
}

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
      'callback=initialize';
  document.body.appendChild(script);
}

window.onload = loadScript;
