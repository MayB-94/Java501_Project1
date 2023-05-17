/**
 * 
 */
 $(window).scroll(() => {
	let scrollTop = $(window).scrollTop();
	let header = $('header');
	let footer = $('footer');
	if (header != null) {
		if (scrollTop > 21 && !header.hasClass('fix-header')) {
			header.addClass('fix-header');
		}
		else if (scrollTop <= 21 && header.hasClass('fix-header')) {
			header.removeClass('fix-header');
		}
	}
	if (footer != null) {
		if (scrollTop < $('body').height() - $(window).height() - footer.height()) {
			$('#scrollToTop').css('bottom', '60px');
			$('#scrollToBottom').css('bottom', '10px');
		} else {
			let interval = scrollTop - ($('body').height() - $(window).height() - footer.height());
			$('#scrollToTop').css('bottom', (interval + 60) + 'px');
			$('#scrollToBottom').css('bottom', (interval + 10) + 'px');
		}
	}
});


// contextPath 할당
const contextPath = window.location.pathname.split('/')[0];
function userMessage(){
    let url = `${contextPath}/message`
    let name = "message-popup";
    let option = "resizable=0, width=800, height=600, top=200, left=400, location=no";
    window.open(url, name, option);
}

$(() => {
	//$('#scrollToTop').click(e => $(window).animate({scrollTop : '0'}, 500));
	$('#scrollToTop').click(e => $(window).scrollTop(0));
	//$('#scrollToBottom').click(e => $(window).animate({scrollTop : ($('body').height() - $(window).height()) + 'px'}, 500));
	$('#scrollToBottom').click(e => $(window).scrollTop($('body').height() - $(window).height()));
});