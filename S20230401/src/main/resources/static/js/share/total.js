/**
 * 
 */

// 스크롤 바
$(window).scroll(() => {
    let scrollTop = $(window).scrollTop();
    let header = $('header');
    if (header != null) {
        if (scrollTop > 21 && !header.hasClass('fix-header')) {
            header.addClass('fix-header');
        }
        else if (scrollTop <= 21 && header.hasClass('fix-header')) {
            header.removeClass('fix-header');
        }
    }
});
$(() => {
    $('#scrollToTop').click(e => $(window).scrollTop(0));
    $('#scrollToBottom').click(e => $(window).scrollTop($(document).height() - 1120));
});