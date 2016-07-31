// slideshow on posts index page
var sliderMini = function() {

  var delay = 5000; // slideshow delay
  var reel = $('#slideshow-reel');
  var slideWidth = $('#slideshow').width();
  var slidesWidth = $('#slideshow-reel .slide').length * slideWidth + 3;
  reel.width(slidesWidth);
  $('#slideshow').on('click', function(e) {
    nextSlide();
  });

  nextSlide = function() {
    var currLeft = $('#slideshow-reel').position().left;
    var slideWidth = $('#slideshow').width();
    if (slidesWidth + currLeft > slideWidth*2) {
      $('#slideshow-reel').animate({
        left: currLeft - slideWidth
      }, 700)
    } else {
      $('#slideshow-reel').animate({
        left: 0
      }, 700)
    }
  };

  // initialize slider
  moveImages = setInterval(function() {
    nextSlide();
  }, delay);
};

$(document).ready(function () {
  if (window.location.pathname == '/posts') {
    if ($(window).width() > 750) {
      console.log($(window).width());
      $('#slideshow-container').show();
      sliderMini();
    };
  };
});

$(document).ready(function () {
  if (window.location.pathname == '/posts') {
    window.onresize = function() {
      if ($(window).width() > 750) {
        $('#slideshow-container').show();
      } else {
        $('#slideshow-container').hide();
      };
    };
  };
});

// remove post from 2nd page & others
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
        if ($('#back-to-top-link').is(":focus")) {
          $('#back-to-top-link').blur()
        }
        readyToClick();
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

readyToClick = function() {
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
};
