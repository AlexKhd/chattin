$(document).ready(function () {
  $('body').hover( function(){
    $(this).css('background-color', '#808080');
  },
  function(){
    $(this).css('background-color', '#000');
  });
});

$(document).ready(function () {
  if ( !$( "li" ).is( ".prev.disabled" ) ) {
    $(".first-post").hide();
  }
});
