$(document).on('turbolinks:load', function() {
    $('.menu-icon').click(function(){
        $('.menu-page').slideToggle();
    });
    $('.post_image').click(function(){
        var src = $(this).attr('src');
        $('.big_image').attr('src',src);
        $('.big_post_image').fadeIn();
    });
    $('.close-modal').click(function(){
        $('.big_post_image').fadeOut();
    });
   
  });