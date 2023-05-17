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