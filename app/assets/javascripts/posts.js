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
          .animate({backgroundColor: "#FFFFFF"}, 1500);
      }
    }
  });
});

newPostValidate = function() {
  return ($('#post_caption').val().length > 2);
};

$(document).ready(function () {
  $(window).scroll(function() {
    if ($(window).scrollTop() > 1300) {
      if ($('#back-to-top-link').hasClass('height0')) {
        $('#back-to-top-link').removeClass('height0')
        $('#back-to-top-link').css('opacity', '1')
        $('#back-to-top-link').blur()
      }
    } else {
      if ($('#back-to-top-link').hasClass('height0')) {
        // do nothing
      } else {
        $('#back-to-top-link').css('opacity', '0')
        setTimeout(function(){
          $('#back-to-top-link').addClass('height0');
        }, 500);
      }
    }
  });
});

$(document).ready(function () {
  var body = $("body, html");
  var top = body.scrollTop();
  if(top !=0) {
    $('#back-to-top-link').on('click', function(e) {
      e.preventDefault();
      $(body).animate({
        scrollTop: 0
      }, 700)
      return false;
    });
  };
});
