$(document).ready(function () {
  $('body').hover( function(){
    $(this).css('background-color', '#808080');
  },
  function(){
    $(this).css('background-color', '#000');
  });
});

$(document).ready(function () {
  // hide if prev enabled &
  if ( !$( 'li' ).is( '.prev.disabled' ) && ( $( 'ul.pagination' ).length ) ) {
    $('.first-post').hide();
  }
});
