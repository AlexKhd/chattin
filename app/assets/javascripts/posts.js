$(document).ready(function () {
  if ( !$( 'li' ).is( '.prev.disabled' ) && ( $( 'ul.pagination' ).length ) ) {
    $('.first-post').closest('div[class = "row"]').hide();
  }
});

$(document).ready(function () {
  $('#new_post').submit(function(e) {
    e.preventDefault();
    if (newPostValidate()) {
      this.submit();
    } else {
      if ($('#post_caption').val().length > 2) {
        alert('no file attached');
      } else {
        $("#post_caption").stop().css("background-color", "red")
          .animate({ backgroundColor: "#FFFFFF"}, 1500);
      }
    }
  });
});

newPostValidate = function() {
  return ($('#post_caption').val().length > 2);
};
