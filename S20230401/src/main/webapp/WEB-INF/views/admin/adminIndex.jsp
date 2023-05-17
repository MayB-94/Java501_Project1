<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<script type="text/javascript">
	$(() => {
		$('.radio-button').on('click', e => {
			let group = $(e.target).attr('data-group');
			$('.radio-button[data-group="' + group + '"]').not($(e.target)).css('background-color', '').attr({
				'data-selected' : 'false',
				'disabled' : false
			});
			$(e.target).css('background-color', '').attr({
				'data-selected' : 'true',
				'disabled' : true
			});
		});
		$('.side-menu').on('click', e => {
			let ajaxUrl = '${pageContext.request.contextPath}/admin/' + $(e.target).attr('data-value');
			$.ajax({
				url: ajaxUrl,
				dataType: 'html',
				success: data => {
					$('main').html(data);
				}
			});
		});
		$('.side-menu[data-value="notice"]').click();
	});
</script>
<style type="text/css">
	html {
		width: 100%;
		height: 100%;
	}
	body {
		width: 100%;
		height: 100%;
		display: grid;
		grid-template-columns: 200px 1fr;
		grid-template-areas: "aside main";
	}
	aside {
		grid-area: aside;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: stretch;
	}
	main {
		grid-area: main;
		background-color: var(--theme);
		color: var(--theme-font);
		height: 100%;
	}
	
	aside > div#admin-profile {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		align-self: center;
	}
	aside > div#admin-profile > * {
		margin: 5px 0;
	}
	div#admin-profile > div.image-container {
		width: 75px;
		height: 75px;
		border-radius: 50%;
		overflow: hidden;
		box-shadow: 0 0 2.5px var(--subtheme-font);
		display: flex;
		justify-content: center;
		align-items: center;
	}
	div#admin-profile > div.image-container > img {
		width: 75px;
		height: 75px;
		object-fit: cover;
	}
	div#admin-profile > span#admin-nickname {
		font-size: 20px;
		font-weight: bolder;
		color: var(--subtheme-font);
	}
	div#admin-profile > span#admin-role {
		font-size: 16px;
		font-weight: bold;
		color: var(--subtheme-font);
		opacity: 0.5;
	}
	
	/* Admin menu */
	aside > div#admin-menu {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		margin: 5px 0;
	}
	aside > div#admin-menu > button.side-menu {
		display: block;
		text-align: center;
		font-size: 16px;
		font-weight: bold;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		padding: 5px 0;
		border: 0;
		outline: none;
		cursor: pointer;
		height: 50px;
	}
	aside > div#admin-menu > button.side-menu[data-selected="true"] {
		background-color: var(--theme);
		color: var(--theme-font);
	}
	
	/* Admin action */
	aside > div#admin-action {
		display: flex;
		flex-direction: column;
		justify-content: flex-end;
		align-items: stretch;
	}
	aside > div#admin-action > button.admin-action-button {
		display: flex;
		justify-content: center;
		align-items: center;
		margin: 2.5px 5px;
		padding: 5px 10px;
		border: 2px solid var(--subtheme-font);
		outline: none;
		background: var(--subtheme);
		border-radius: 5px;
		font-size: 16px;
		font-weight: bold;
		color: var(--subtheme-font);
		cursor: pointer;
	}
	aside > div#admin-action > button.admin-action-button > * {
		pointer-events: none;
	}
	aside > div#admin-action > button.admin-action-button > span {
		font-size: inherit;
		font-weight: inherit;
		color: inherit;
	}
	aside > div#admin-action > button.admin-action-button > svg {
		 fill: none;
		 stroke: var(--subtheme-font);
		 stroke-linecap: round;
		 stroke-linejoin: round;
		 stroke-width: 32;
		 width: 24px;
		 height: 24px;
	}
	
	/* notice template */
	div.admin-container {
		position: relative;
		display: flex;
		justify-content: flex-start;
		align-items: stretch;
		padding: 75px;
		height: 100%;
	}
	div.admin-main {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		flex-grow: 1;
		overflow-y: auto;
	}
	div.admin-main-title-box {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	h2.admin-main-title {
		color: var(--subtheme);
		font-weight: bolder;
	}
	div.admin-main-title-box > button {
		border: 2px solid var(--subtheme);
		background-color: var(--theme);
		color: var(--theme-font);
		padding: 2.5px 5px;
		border-radius: 5px;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 14px;
		font-weight: bold;
		cursor: pointer;
	}
	div.admin-side-panel {
		position: absolute;
		height: 100%;
		top: 0;
		right: 0;
		width: 0;
		display: none;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		overflow-y: auto;
		background-color: var(--theme);
		border-left: 5px solid var(--subtheme);
		transition: width .25s cubic-bezier(.33, 1, .33, 1);
	}
	button.admin-side-panel-close {
		background-color: var(--subtheme);
		border: 0;
		outline: none;
		cursor: pointer;
		height: 100%;
	}
	div.admin-side-panel-header {
		display: flex;
		justify-content: space-between;
		align-items: stretch;
	}
	div.admin-side-panel-header > div.admin-side-panel-right {
		display: flex;
		justify-content: flex-end;
		align-items: stretch;
	}
	div.admin-side-panel-header > div.admin-side-panel-right > div.admin-side-panel-view {
		display: flex;
		justify-content: flex-end;
		align-items: stretch;
	}
	div.admin-side-panel-header > div.admin-side-panel-right > div.admin-side-panel-modify {
		display: none;
		justify-content: flex-end;
		align-items: stretch;
	}
	div.admin-side-panel-right button.admin-side-panel-button {
		display: flex;
		justify-content: center;
		align-items: center;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-size: 14px;
		font-weight: bold;
		border: 0;
		outline: none;
		cursor: pointer;
	}
	div.admin-side-panel-right button.admin-side-panel-button > * {
		pointer-events: none;
	}
	div.admin-side-panel-right button.admin-side-panel-button > span {
		font-size: inherit;
		font-weight: inherit;
		color: inherit;
		padding: 5px 10px;
	}
	button.admin-side-panel-close > svg {
		width: 24px;
		height: 24px;
		stroke: var(--subtheme-font);
		stroke-width: 2px;
		stroke-linecap: round;
		stroke-linejoin: round;
		pointer-events: none;
	}
	div.admin-board-1 {
		border: 2px solid var(--subtheme);
		border-left: 0;
		border-right: 0;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
	}
	div.admin-board-1-head {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	div.admin-board-1-head > span {
		font-size: 14px;
		font-weight: bolder;
		padding: 2.5px 5px;
		color: var(--subtheme);
	}
	div.admin-board-1 > div.admin-article-item {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		cursor: pointer;
		height: 32px;
	}
	div.admin-board-1 > div.admin-article-item:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	div.admin-board-1 > div.admin-article-item > * {
		pointer-events: none;
	}
	
	span.isDelete-tag {
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		border: 0;
		border-radius: 2.5px;
		padding: 2.5px 5px;
		font-size: 12px;
		font-weight: bold;
		margin-right: 5px;
	}
	
	div.admin-article-category {
		width: 75px;
		border-radius: 2.5px;
		padding: 2.5px 5px;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-size: 12px;
		font-weight: bold;
		text-align: center;
	}
	span.admin-article-title {
		font-size: 16px;
		font-weight: bold;
		flex-grow: 1;
	}
	span.admin-article-regdate {
		font-size: 12px;
		opacity: 0.5;
	}
	
	div.admin-board-1-page, div.admin-board-2-page {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	button.paging-button {
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 5px;
		width: 25px;
		height: 25px;
		margin: 2.5px;
		background-color: var(--theme);
		color: var(--theme-font);
		font-size: 14px;
		outline: none;
		border: 0;
		padding: 0;
	}
	button.paging-button:not(:disabled) {
		cursor: pointer;
	}
	button.paging-button * {
		pointer-events: none;
	}
	button.paging-button > span {
		background-color: inherit;
		color: inherit;
		font-size: inherit;
	}
	button.paging-button > svg {
		width: 16px;
		height: 16px;
		stroke: var(--subtheme);
		stroke-width: 2px;
		stroke-linejoin: round;
		stroke-linecap: round;
		fill: none;
	}
	button.paging-prev, button.paging-next {
		
	}
	button.paging-prev:disabled, button.paging-next:disabled {
		opacity: 0.5;
	}
	button.paging-page {
		
	}
	button.paging-page:disabled {
		font-weight: bolder;
		color: var(--subtheme);
	}
</style>
<!-- for viewNotice -->
<style type="text/css">
	div.admin-side-container {
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		padding: 10px;
		height: 100%;
	}
	div#art_title {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		border: 2px solid var(--subtheme);
		border-left: 0;
		border-right: 0;
	}
	div#art_title > span {
		margin: 5px 10px;
		font-size: 24px;
		font-weight: bold;
	}
	div#art_info {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px solid var(--subtheme);
	}
	div#art_info > div#art_tags {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		margin: 5px 10px;
	}
	div#art_info > div#art_tags > span {
		font-size: 14px;
		font-weight: bold;
		color: var(--subtheme);
	}
	div#art_info > div#art_tags > span:not(:last-child) {
		margin-right: 10px;
	}
	div#art_info > div#art_misc {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		margin: 5px 10px;
	}
	div#art_info > div#art_misc > span {
		font-size: 14px;
		font-weight: bold;
	}
	div#art_info > div#art_misc > span:not(:last-child) {
		margin-right: 10px;
	}
	div#art_content {
		padding: 5px 10px;
	}
	
	img {
		max-width: 100%;
	}
</style>
<style type="text/css">
	div.admin-board-2-head {
		
	}
	div.admin-board-2-head > span {
		color: var(--subtheme);
		font-weight: bolder;
		white-space: nowrap;
		padding: 0 2.5px;
		display: block;
	}
	div.admin-board-2 {
		border: 2.5px solid var(--subtheme);
		border-width: 2.5px 0;
	}
	div.admin-board-2 div.list-item:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	div.admin-report-container {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		cursor: pointer;
	}
	div.admin-report-container:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	div.admin-report-container > div.admin-report-item {
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	div.admin-report-item {
		pointer-events: none;
		user-select: none;
	}
	div.admin-report-item > span {
		white-space: nowrap;
		padding: 0 2.5px;
	}
	div.admin-report-item > svg {
		width: 16px;
		height: 8px;
		margin: 0 4px;
		fill: none;
		stroke: var(--subtheme);
		stroke-width: 64px;
		stroke-linecap: round;
		stroke-linejoin: round;
	}
	div.admin-report-info {
		background-color: rgba(var(--subtheme-rgb), 0.25);
		border-radius: 2.5px;
		margin: 5px 0;
		height: 0;
		overflow: hidden;
		cursor: default;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
	}
</style>
</head>
<body>
	<aside>
		<div id="admin-profile" class="padding-20px padding-hor-0">
			<div class="image-container background-color-theme">
				<img src="${pageContext.request.contextPath }/uploads/profile/${memberInfo.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
			</div>
			<span id="admin-nickname">${memberInfo.mem_nickname }</span>
			<span id="admin-role">
				<c:choose>
					<c:when test="${memberInfo.mem_authority == 109 }">관리자</c:when>
					<c:otherwise>매니저</c:otherwise>
				</c:choose>
			</span>
		</div>
		<div id="admin-menu">
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="true" data-value="notice">공지사항 관리</button>
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="false" data-value="event">이벤트 관리</button>
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="false" data-value="report">신고 관리</button>
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="false" data-value="member">회원 관리</button>
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="false" data-value="article">게시글 관리</button>
			<button class="side-menu radio-button adv-hover" data-group="menu" data-selected="false" data-value="suggest">건의글 관리</button>
		</div>
		<div id="admin-action" class="padding-20px padding-hor-0">
			<button class="admin-action-button adv-hover" type="button" onclick="location.href = '${pageContext.request.contextPath}/';">
				<span>메인 페이지</span>
			</button>
			<button class="admin-action-button adv-hover" type="button" onclick="location.href = '${pageContext.request.contextPath}/logout';">
				<svg class="admin-action-button-content" viewBox="0 0 512 512">
					<!-- https://ionic.io/ionicons -->
					<path d="M336 112a80 80 0 00-160 0v96"/>
					<rect x="96" y="208" width="320" height="272" rx="48" ry="48"/>
				</svg>
				<span style="margin-left: 10px;">로그아웃</span>
			</button>
		</div>
	</aside>
	<main class="overflow-y-auto">
		
	</main>
</body>
</html>