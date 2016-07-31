// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require websocket_rails/main
//= require es5-shim
//= require react
//= require react_ujs
//= require components
//= require_tree .

function scrdown() {
  var elm = $('#chat');
      elm.scrollTop(elm.get(0).scrollHeight);
      var scrollHeight = elm.scrollTop() + elm.height();
      elm.scrollTop(0);
      $('#chat').scrollTop(scrollHeight);
}

$(document).ready(function () {  // auto scroll down chat field after message sent
  $('#send').bind('click', function(){
  scrdown();
  });
});

$(window).scroll(function() {
    if ($('.navbar').offset().top > 50) {
        $('.navbar-fixed-top').addClass('top-nav-collapse');
    } else {
        $('.navbar-fixed-top').removeClass('top-nav-collapse');
    }
});

// Closes the Responsive Menu on Menu Item Click
/*
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
    console.log('collapsing');
});

$(document).ready(function() {
  $( "#user_password" ).datepicker();
});
*/
