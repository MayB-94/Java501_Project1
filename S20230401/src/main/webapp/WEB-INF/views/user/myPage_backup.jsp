<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<script type="text/javascript">
	$(() => {
		$('.selector').each((index, item) => {
			let selectorID = $(item).attr('id');
			if ($('#' + selectorID).attr('data-toggle') == 'false') $('#' + selectorID + '-document').hide();
		});
		$('.reply-normal').each((index, value) => {
			let target = $(value);
			let str = target.text();
			str = str.match(/\n/)
			target.text(target.text().replace('\n', '\u00a0'));
		});
		$('button.selector').click(e => {
			let groupName = $(e.target).attr('data-group');
			$('button[data-group="' + groupName + '"]').attr('data-toggle', 'false');
			$(e.target).attr('data-toggle', 'true');
			$(e.target).mouseout();
			$(e.target).mouseenter();
			$('div[data-group="' + groupName + '-document"]').not('div#' + $(e.target).attr('id') + '-document').hide();
			$('div#' + $(e.target).attr('id') + '-document').show();
		});
	});
</script>
<!-- ignoring Style -->
<style type="text/css">
	/* Buttons */
	button.theme-button {
		background-color: var(--theme);
		color: var(--theme-font);
		font-weight: bold;
		padding: 0;
		border-radius: 5px;
		outline: none;
		border: 2px solid var(--subtheme);
		cursor: pointer;
	}
	button.subtheme-button {
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-weight: bold;
		padding: 0;
		border-radius: 5px;
		outline: none;
		border: 0;
		cursor: pointer;
	}
</style>
<style type="text/css">
	html {
		min-height: 100%;
	}
	div#user-background {
		width: 100%;
		padding: 20px 0;
		border-bottom: 5px solid var(--subtheme);
	}
	div#user-profile-box {
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
	}
	div#user-image-container {
		width: max-content;
		height: max-content;
		border-radius: 50%;
		overflow: hidden;
		box-shadow: 0 2.5px 2.5px var(--theme-font);
		background-color: white;
	}
	img#user-image {
		object-fit: cover;
		width: 160px;
		height: 160px;
	}
	div#user-nickname-box {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 20px;
	}
	h2#user-nickname {
		margin: 0;
		margin-left: 40px;
	}
	button#user-profile-modify {
		width: 20px;
		height: 20px;
		padding: 0;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-left: 20px;
		background-color: var(--theme);
		outline: none;
		border-radius: 2px;
		border: 0;
		cursor: pointer;
	}
	button#user-profile-modify > * {
		pointer-events: none;
	}
	div#user-reputation {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	div#user-reputation svg {
		width: 16px;
		height: 16px;
	}
	div#user-reputation span {
		font-size: 14px;
		font-weight: bold;
		margin-left: 5px;
	}
	div#user-reputation span:not(:last-child) {
		margin-right: 10px;
	}
	span#user-hierachy {
		font-size: 14px;
		font-weight: bold;
		color: #888888;
		margin: 10px 0 0 0;
	}
	div#user-info-selector {
		display: flex;
		justify-content: center;
		align-items: stretch;
	}
	div#user-info-selector > * {
		flex-grow: 1;
		flex-basis: 0;
	}
	button.rect-button {
		border-radius: 0;
		font-size: 20px;
		font-weight: bold;
		padding: 20px 0;
	}
	button.selector[data-toggle="true"] {
		background-color: var(--theme);
		color: var(--theme-font);
	}
	div#user-info-container {
		width: 100%;
	}
	div#user-info-container > div {
		width: 100%;
	}
	div.document-subtitle-box {
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	h2.document-subtitle {
		margin: 10px;
		color: var(--subtheme);
	}
	span.document-subtitle-desc {
		font-weight: bold;
		margin-left: 10px;
		color: var(--theme-font);
		opacity: 0.5;
	}
	
	/* 게시글 섹션 */
	div.board-summary-article {
		display: grid;
		grid-template-columns: auto auto;
		grid-template-rows: 40px 50px;
		padding: 0 10px;
	}
	div.board-summary-article:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	div.board-summary-article > div.article-part-lt {
		grid-column-start: 1;
		grid-column-end: 2;
		grid-row-start: 1;
		grid-row-end: 2;
		display: flex;
		justify-content: flex-start;
		align-items: center;
		line-height: 20px;
	}
	div.board-summary-article > div.article-part-lt > span {
		font-size: 14px;
	}
	span.article-category {
		border: 0;
		border-radius: 2.5px;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-weight: bold;
		padding: 2.5px 5px;
	}
	div.board-summary-article > div.article-part-lt > span.article-regdate {
		font-weight: bold;
		margin-left: 10px;
	}
	div.board-summary-article > div.article-part-lt > svg {
		width: 14px;
		height: 14px;
	}
	div.board-summary-article > div.article-part-lt > *:not(:last-child) {
		margin-right: 2.5px;
	}
	div.board-summary-article > div.article-part-rt {
		grid-column-start: 2;
		grid-column-end: 3;
		grid-row-start: 1;
		grid-row-end: 2;
		display: flex;
		justify-content: flex-end;
		align-items: center;
	}
	div.board-summary-article > div.article-part-rt > span {
		font-size: 14px;
	}
	div.board-summary-article > div.article-part-rt > span.article-enddate {
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		padding: 1.25px 2.5px;
		font-weight: bold;
		border-radius: 2.5px;
	}
	div.board-summary-article > div.article-part-rt > span.article-enddate-end {
		background-color: var(--theme);
		color: var(--theme-font);
		padding: 1.25px 2.5px;
		font-weight: bold;
		border-radius: 2.5px;
		border: 2px solid var(--subtheme);
	}
	div.board-summary-article > div.article-part-rt > svg {
		width: 14px;
		height: 14px;
	}
	div.board-summary-article > div.article-part-rt > *:not(:last-child) {
		margin-right: 10px;
	}
	div.board-summary-article > div.article-part-b {
		grid-column-start: 1;
		grid-column-end: 3;
		grid-row-start: 2;
		grid-row-end: 3;
		display: flex;
		justify-content: flex-start;
		align-items: center;
		font-size: 18px;
		overflow: hidden;
	}
	div.board-summary-article > div.article-part-b > a {
		text-decoration: none;
		color: inherit;
		text-overflow: ellipsis;
		white-space: nowrap;
		font-weight: bold;
		margin: 10px 0;
	}
	div.board-summary-article > div.article-part-b > a:hover {
		color: var(--subtheme);
	}
	
	/* Reply 섹션 */
	div.article-replies {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		padding: 10px;
	}
	div.article-replies:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	/* span.article-id {
		margin-left: 10px;
		font-size: 18px;
		font-weight: bold;
	} */
	a.article-title {
		margin-left: 10px;
		font-size: 18px;
		font-weight: bold;
	}
	a.article-title:hover {
		color: var(--subtheme);
	}
	div.article-for-reply {
		display: flex;
		justify-content: flex-start;
		align-items: center;
		border-bottom: 0.5px solid rgba(var(--subtheme-rgb), 0.5);
		padding-bottom: 5px;
	}
	div.reply-container {
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	svg.reply-icon {
		fill: none;
		stroke: var(--subtheme);
		stroke-linejoin: round;
		stroke-width: 32px;
		transform: rotate(180deg);
		transform-origin: 50% 50%;
		width: 24px;
		height: 24px;
	}
	span.reply-regdate {
		font-size: 14px;
		font-weight: bold;
		color: var(--subtheme);
	}
	p.reply-normal {
		margin: 10px;
		font-size: 16px;
		font-weight: bold;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	
	/* Trade 섹션 */
	.trade-box:not(:last-child) {
		border-bottom: 2px solid var(--subtheme);
	}
	.trade-item {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		padding: 5px 10px;
	}
	.trade-item:not(:last-child) {
		border-bottom: 1px solid var(--subtheme);
	}
	.trade-item-top {
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 30px;
	}
	.status-tag {
		padding: 2.5px 5px;
		border-radius: 2.5px;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-weight: bold;
	}
	.trade-item-bottom {
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 30px;
	}
	.trade_tags {
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	.art-tag {
		opacity: 0.5;
	}
	.trade-participants {
		color: var(--subtheme);
		font-size: 20px;
		font-weight: bolder;
	}
</style>
</head>
<body>
	<div class="container">
		<div id="user-background">
			<div id="user-profile-box">
				<div id="user-image-container">
					<img id="user-image" src="${pageContext.request.contextPath }/uploads/profile/${memberInfo.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/anonymous.png';">
				</div>
				<div id="user-nickname-box">
					<h2 id="user-nickname">${memberInfo.mem_nickname }</h2>
					<button id="user-profile-modify" class="adv-hover" type="button" onclick="location.href = '${pageContext.request.contextPath }/user/passwordCheck?go=userinfo'" title="유저 정보 수정">
						<!-- https://ionic.io/ionicons -->
						<svg style="width: 16px; height: 16px; fill: var(--theme-font); stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;" viewBox="0 0 512 512">
							<path d="M384 224v184a40 40 0 01-40 40H104a40 40 0 01-40-40V168a40 40 0 0140-40h167.48" fill="none"/>
							<path d="M459.94 53.25a16.06 16.06 0 00-23.22-.56L424.35 65a8 8 0 000 11.31l11.34 11.32a8 8 0 0011.34 0l12.06-12c6.1-6.09 6.67-16.01.85-22.38zM399.34 90L218.82 270.2a9 9 0 00-2.31 3.93L208.16 299a3.91 3.91 0 004.86 4.86l24.85-8.35a9 9 0 003.93-2.31L422 112.66a9 9 0 000-12.66l-9.95-10a9 9 0 00-12.71 0z"/>
						</svg>
					</button>
				</div>
				<div id="user-reputation">
					<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--confirm);">
						<!-- https://freesvg.org/thumbs-up-silhouette -->
						<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
									 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
					</svg>
					<span>${memberInfo.his_good }</span>
					<div style="width: 8px; height: 2px; background-color: var(--theme-font); margin: 0 4px;"></div>
					<span>${memberInfo.his_normal }</span>
					<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--warning); transform: rotate(180deg); transform-origin: 50% 50%;">
						<!-- https://freesvg.org/thumbs-up-silhouette -->
						<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
									 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
					</svg>
					<span>${memberInfo.his_bad }</span>
				</div>
				<span id="user-hierachy">
					<c:choose>
						<c:when test="${memberInfo.mem_authority == 109 }">관리자</c:when>
						<c:when test="${memberInfo.mem_authority == 108 }">매니저</c:when>
						<c:when test="${memberInfo.mem_authority == 103 }">일반 사용자</c:when>
						<c:when test="${memberInfo.mem_authority == 102 }">차단된 사용자</c:when>
						<c:otherwise>인증되지 않은 사용자</c:otherwise>
					</c:choose>
				</span>
			</div>
		</div>
		<div id="user-info-selector">
			<button id="articles-menu" data-group="info-menu" data-toggle="true" class="selector rect-button subtheme-button adv-hover" type="button">게시글</button>
			<button id="replies-menu" data-group="info-menu" data-toggle="false" class="selector rect-button subtheme-button adv-hover" type="button">댓글</button>
			<button id="trades-menu" data-group="info-menu" data-toggle="false" class="selector rect-button subtheme-button adv-hover" type="button">거래내역</button>
		</div>
		<div id="user-info-container">
			<div id="articles-menu-document" data-group="info-menu-document">
				<div class="document-subtitle-box">
					<h2 class="document-subtitle">최근에 작성한 글</h2>
					<span class="document-subtitle-desc">
						최근 작성한 10개의 글이 노출됩니다
					</span>
				</div>
				<c:forEach var="article" items="${articles }">
					<div class="board-summary-article">
						<div class="article-part-lt">
							<span class="article-category">
								${article.brd_name }
							</span>
							<span class="article-regdate">
								<c:choose>
									<c:when test="${((now.time - article.art_regdate.time) / 1000) < 60 }">
										<fmt:formatNumber pattern="0초 전">
											${((now.time - article.art_regdate.time) / 1000 / 60) - ((now.time - article.art_regdate.time) / 1000 / 60) % 1 }
										</fmt:formatNumber>
									</c:when>
									<c:when test="${((now.time - article.art_regdate.time) / 1000 / 60) < 60 }">
										<fmt:formatNumber pattern="0분 전">
											${((now.time - article.art_regdate.time) / 1000 / 60) - ((now.time - article.art_regdate.time) / 1000 / 60) % 1 }
										</fmt:formatNumber>
									</c:when>
									<c:when test="${((now.time - article.art_regdate.time) / 1000 / 60 / 60) < 24 }">
										<fmt:formatNumber pattern="0시간 전">
											${((now.time - article.art_regdate.time) / 1000 / 60 / 60) - ((now.time - article.art_regdate.time) / 1000 / 60 / 60) % 1 }
										</fmt:formatNumber>
									</c:when>
									<c:when test="${((now.time - article.art_regdate.time) / 1000 / 60 / 60 / 24) < 7 }">
										<fmt:formatNumber pattern="0일 전">
											${((now.time - article.art_regdate.time) / 1000 / 60 / 60 / 24) - ((now.time - article.art_regdate.time) / 1000 / 60 / 60 / 24) % 1 }
										</fmt:formatNumber>
									</c:when>
									<c:otherwise>
										<fmt:formatDate value="${article.art_regdate }" pattern="yyyy-MM-dd hh:mm:ss"/>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="article-part-rt">
							<c:if test="${article.trd_id != 0 && article.trd_id != null }">
								<span class="article-enddate${now.time - article.trd_enddate.time >= 0 ? '-end' : '' }">
									<c:choose>
										<c:when test="${article.trd_enddate == null }">
											기한 없음
										</c:when>
										<c:when test="${now.time - article.trd_enddate.time >= 0 }">
											마감
										</c:when>
										<c:when test="${((article.trd_enddate.time - now.time) / 1000) < 60 }">
											<fmt:formatNumber pattern="0초 남음">
												${((article.trd_enddate.time - now.time) / 1000) - ((article.trd_enddate.time - now.time) / 1000) % 1 }
											</fmt:formatNumber>
										</c:when>
										<c:when test="${((article.trd_enddate.time - now.time) / 1000 / 60) < 60 }">
											<fmt:formatNumber pattern="0분 남음">
												${((article.trd_enddate.time - now.time) / 1000 / 60) - ((article.trd_enddate.time - now.time) / 1000 / 60) % 1 }
											</fmt:formatNumber>
										</c:when>
										<c:when test="${((article.trd_enddate.time - now.time) / 1000 / 60 / 60) < 24 }">
											<fmt:formatNumber pattern="0시간 남음">
												${((article.trd_enddate.time - now.time) / 1000 / 60 / 60) - ((article.trd_enddate.time - now.time) / 1000 / 60 / 60) % 1 }
											</fmt:formatNumber>
										</c:when>
										<c:when test="${((article.trd_enddate.time - now.time) / 1000 / 60 / 60 / 24) < 7 }">
											<fmt:formatNumber pattern="0일 남음">
												${((article.trd_enddate.time - now.time) / 1000 / 60 / 60 / 24) - ((article.trd_enddate.time - now.time) / 1000 / 60 / 60 / 24) % 1 }
											</fmt:formatNumber>
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${article.trd_enddate }" pattern="~ yy-MM-dd"/>
										</c:otherwise>
									</c:choose>
								</span>
							</c:if>
							<c:if test="${article.trd_id == 0 || article.trd_id == null }">
								<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--theme-font);">
									<!-- https://freesvg.org/thumbs-up-silhouette -->
									<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
												 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
								</svg>
								<span>${article.art_good }</span>
								<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--theme-font); transform: rotate(180deg); transform-origin: 50% 50%;">
									<!-- https://freesvg.org/thumbs-up-silhouette -->
									<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
												 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
								</svg>
								<span>${article.art_bad }</span>
								<svg viewBox="0 0 121.86 122.88">
									<!-- https://uxwing.com/comment-icon/ -->
									<path d="M30.28,110.09,49.37,91.78A3.84,3.84,0,0,1,52,90.72h60a2.15,2.15,0,0,0,2.16-2.16V9.82a2.16,2.16,0,0,0-.64-1.52A2.19,2.19,0,0,0,112,7.66H9.82A2.24,2.24,0,0,0,7.65,9.82V88.55a2.19,2.19,0,0,0,2.17,2.16H26.46a3.83,3.83,0,0,1,3.82,3.83v15.55ZM28.45,63.56a3.83,3.83,0,1,1,0-7.66h53a3.83,3.83,0,0,1,0,7.66Zm0-24.86a3.83,3.83,0,1,1,0-7.65h65a3.83,3.83,0,0,1,0,7.65ZM53.54,98.36,29.27,121.64a3.82,3.82,0,0,1-6.64-2.59V98.36H9.82A9.87,9.87,0,0,1,0,88.55V9.82A9.9,9.9,0,0,1,9.82,0H112a9.87,9.87,0,0,1,9.82,9.82V88.55A9.85,9.85,0,0,1,112,98.36Z"/>
								</svg>
								<span>${article.rep_count }</span>
							</c:if>
						</div>
						<div class="article-part-b">
							<c:set var="category" value="${article.brd_id - (article.brd_id % 100) }"/>
							<c:choose>
								<c:when test="${category == 1000 }">
									<c:set var="boardName" value="together"/>
								</c:when>
								<c:when test="${category == 1100 }">
									<c:set var="boardName" value="dutchpay"/>
								</c:when>
								<c:when test="${category == 1200 }">
									<c:set var="boardName" value="share"/>
								</c:when>
								<c:when test="${category == 1300 }">
									<c:set var="boardName" value="community"/>
								</c:when>
								<c:when test="${category == 1400 }">
									<c:set var="boardName" value="information"/>
								</c:when>
								<c:otherwise>
									<c:set var="boardName" value="customer"/>
								</c:otherwise>
							</c:choose>
							<a href="${pageContext.request.contextPath}/board/${boardName }/${article.art_id }?brd_id=${article.brd_id }&category=${category }">
								${article.art_title }
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="replies-menu-document" data-group="info-menu-document">
				<div class="document-subtitle-box">
					<h2 class="document-subtitle">최근에 작성한 댓글</h2>
					<span class="document-subtitle-desc">
						최근 작성한 10개의 댓글이 노출됩니다
					</span>
				</div>
				<c:forEach var="reply" items="${replies }">
					<div class="article-replies">
						<div class="article-for-reply">
							<span class="article-category">
								${repParents[reply.brd_id][reply.art_id].brd_name }
							</span>
							<%-- <span class="article_id">
								${repParents[reply.brd_id][reply.art_id].art_id }
							</span> --%>
							<c:set var="category" value="${repParents[reply.brd_id][reply.art_id].brd_id - (repParents[reply.brd_id][reply.art_id].brd_id % 100) }"/>
							<c:choose>
								<c:when test="${category == 1000 }">
									<c:set var="boardName" value="together"/>
								</c:when>
								<c:when test="${category == 1100 }">
									<c:set var="boardName" value="dutchpay"/>
								</c:when>
								<c:when test="${category == 1200 }">
									<c:set var="boardName" value="share"/>
								</c:when>
								<c:when test="${category == 1300 }">
									<c:set var="boardName" value="community"/>
								</c:when>
								<c:when test="${category == 1400 }">
									<c:set var="boardName" value="information"/>
								</c:when>
								<c:otherwise>
									<c:set var="boardName" value="customer"/>
								</c:otherwise>
							</c:choose>
							<a class="article-title" href="${pageContext.request.contextPath }/board/${boardName}/${repParents[reply.brd_id][reply.art_id].art_id}?brd_id=${repParents[reply.brd_id][reply.art_id].brd_id}&category=${category}#reply-${reply.rep_id}">
								${repParents[reply.brd_id][reply.art_id].art_title }
							</a>
						</div>
						<div class="reply-container">
							<!-- https://ionic.io/ionicons -->
							<svg class="reply-icon" viewBox="0 0 512 512">
								<path d="M240 424v-96c116.4 0 159.39 33.76 208 96 0-119.23-39.57-240-208-240V88L64 256z"/>
							</svg>
							<span class="reply-regdate">[
								<fmt:formatDate value="${reply.rep_regdate }" pattern="yyyy-MM-dd hh:mm:ss"/>
							]</span>
							<p class="reply-normal">${reply.rep_content }</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="trades-menu-document" data-group="info-menu-document">
				<c:set var="trd_type">OFFERED,JOINED,WAITING</c:set>
				<c:forTokens var="type" items="${trd_type }" delims=",">
					<div class="trade-box">
						<c:set var="str">
							<c:choose>
								<c:when test="${type == 'OFFERED' }">제안한</c:when>
								<c:when test="${type == 'JOINED' }">참가한</c:when>
								<c:otherwise>신청한</c:otherwise>
							</c:choose>
						</c:set>
						<div class="document-subtitle-box">
							<h2 class="document-subtitle">최근에 ${str } 거래</h2>
							<span class="document-subtitle-desc">
								최근 ${str } 10개의 거래가 노출됩니다
							</span>
						</div>
						<div class="trade-content">
							<c:forEach var="entry" items="${trades[type] }">
								<c:forEach var="trade" items="${entry.value }">
									<div class="trade-item">
										<fmt:formatDate var="enddate" value="${trade.trd_enddate }" pattern="yyyy-MM-dd hh:mm:ss"/>
										<div class="trade-item-top">
											<div class="trade-item-info">
												<span class="status-tag">${trade.trd_statusname }</span>
												<c:set var="category" value="${trade.brd_id - (trade.brd_id % 100) }"/>
												<c:set var="boardName">
													<c:choose>
														<c:when test="${category == 1000 }">together</c:when>
														<c:when test="${category == 1100 }">dutchpay</c:when>
														<c:when test="${category == 1200 }">share</c:when>
														<c:when test="${category == 1300 }">information</c:when>
														<c:when test="${category == 1400 }">customer</c:when>
													</c:choose>
												</c:set>
												<a href="${pageContext.request.contextPath }/board/${boardName }/${trade.art_id }?brd_id=${trade.brd_id }&category=${category }">${trade.art_title }</a>
											</div>
											<span class="trade-enddate">~ ${enddate }</span>
										</div>
										<div class="trade-item-bottom">
											<div class="trade-tags">
												<c:forEach var="i" begin="1" end="5">
													<c:set var="tat" value="art_tag${i }"/>
													<c:if test="${trade[tat] != null }">
														<span class="art-tag">#${trade[tat] }</span>
													</c:if>
												</c:forEach>
											</div>
											<span class="trade-participants">
												${trade.join_count } / ${trade.trd_max }
											</span>
										</div>
									</div>
								</c:forEach>
							</c:forEach>
						</div>
					</div>
				</c:forTokens>
			</div>
		</div>
	</div>
</body>
</html>