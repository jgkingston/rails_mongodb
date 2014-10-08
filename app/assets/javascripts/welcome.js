
$( document ).ajaxStart(function() {
    console.log("AJAX!!!")

    $('#spinner').css("display", "block");
      })

    .ajaxStop(function () {
        $('#spinner').css("display", "none");
});

        
    