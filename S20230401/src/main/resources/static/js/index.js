/**
 * 
 */
$(() => {
	$('.board-toggle').click(e => {
		let parent = $(e.target).closest('.board-summary');
		let children = parent.find('.board-summary-part');
		children.toggle();
	});
});


// contextPath 할당
const contextPath = window.location.pathname.split('/')[0];
function userMessage(){
    let url = `${contextPath}/message`
    let name = "message-popup";
    let option = "width=800, height=600, top=200, left=400, location=no";
    window.open(url, name, option);
}