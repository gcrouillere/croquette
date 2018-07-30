$(document).ready(function() {

  function changeNavContent() {
    if($(document).scrollTop() > 50) {
      $('.navbar-logo').css({display: 'none'});
      $('.nav-bar-list').css({
        position: 'relative',
        top: '-22px'
      });
      $('.nav-bar-list-mobile').css({
        position: 'relative',
        top: '6px'
      });
      $('.navbar-laptop-lighttheme').css({height: '70px'});
      $('.navbar-laptop-lighttheme').addClass('navbar-on-scroll');
      $('.content').css("padding-top", '110px');
      if ($('.alert.alert-dismissible')) {$('.alert.alert-dismissible').css("top", '70px');}
    } else {
      $('.navbar-logo').css({display: 'flex'});
      $('.nav-bar-list').css({
        position: 'relative',
        top: '0px'
      });
      $('.nav-bar-list-mobile').css({
        position: 'relative',
        top: '19px'
      });
      $('.navbar-laptop-lighttheme').css({height: '186px'});
      $('.navbar-laptop-lighttheme').removeClass('navbar-on-scroll');
      $('.content').css("padding-top", '207px');
      if ($('.alert.alert-dismissible')) {$('.alert.alert-dismissible').css("top", '186px');}
    }
  }

  $(document).scroll(function() {
    changeNavContent();
  });
})
