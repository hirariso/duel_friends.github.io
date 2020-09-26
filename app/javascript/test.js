$(document).on('turbolinks:load', function () {
    $('.home_image').fadeIn('slow');
    $('.menu-icon').click(function () {
        $('.menu-page').slideToggle();
    });
    $('.post_image').click(function () {
        var src = $(this).attr('src');
        $('.big_image').attr('src', src);
        $('.big_post_image').fadeIn();
    });
    $('.close-modal').click(function () {
        $('.big_post_image').fadeOut();
    });
});