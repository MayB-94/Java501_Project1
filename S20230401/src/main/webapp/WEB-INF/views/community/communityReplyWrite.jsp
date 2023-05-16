<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript">
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
</script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/layout.css">
<style type="text/css">
	body {
		width: 100%;
		display: grid;
		grid-template-columns: 200px 1fr 200px;
		grid-template-rows: 100px 1fr 200px;
		grid-template-areas:
			"header header header"
			"leftside main rightside"
			"footer footer footer";
	}
	header {
		grid-area: header;
		height: 100px;
		background-color: var(--theme);
		border-bottom: 0.5px solid #CCCCCC;
		z-index: 99;
	}
	aside {
		background-color: var(--backtheme);
	}
	aside#leftside {
		grid-area: leftside;
		/* TEST */
		height: 5000px;
	}
	main {
		grid-area: main;
		background-color: var(--theme);
		/* TEST */
		height: 5000px;
	}
	aside#rightside {
		grid-area: rightside;
		/* TEST */
		height: 5000px;
	}
	footer {
		grid-area: footer;
		height: 200px;
		border-top: 0.5px solid #CCCCCC;
		background-color: var(--theme);
	}
	
	header > div#usernav {
		width: 100%;
		display: flex;
		justify-content: flex-end;
		align-items: center;
		background-color: var(--backtheme);
	}
	header > div#usernav > a {
		font-size: 14px;
		color: var(--subtheme);
		font-weight: bold;
		margin: 0 5px;
	}
	header > div#topbar > div#logo-div, header > div#topbar > div#top-right { width: 200px; }
	header > div#topbar > div#top-right {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	header > div#topbar {
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: calc(100% - 21px);
	}
	header > div#topbar > div#topmenu {
		display: flex;
		height: 100%;
		justify-content: flex-start;
		align-items: stretch;
	}
	header > div#topbar > div#topmenu > div.menu-separator {
		width: 0;
		height: 20px;
		border: 1px solid #888888;
		opacity: 0.25;
		margin: 29.5px 0;
	}
	header > div#topbar > div#topmenu > a.menuitem {
		display: block;
		font-size: 18px;
		background-color: var(--theme);
		padding: 0 10px;
		line-height: 79px;
		font-weight: bold;
		width: 120px;
		text-align: center;
	}
	div#dropdown {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		position: absolute;
		top: 100px;
		left: 0;
		width: 100%;
		height: 0px;
		background-color: var(--theme);
		border-bottom: 0.5px solid #CCCCCC;
		transition: height .125s cubic-bezier(.5,1,.5,1);
		overflow: hidden;
	}
	header > div#topbar > div#topmenu > a.menuitem:hover ~ div#dropdown,
	header > div#topbar > div#topmenu > div.menu-separator:hover ~ div#dropdown,
	header > div#topbar > div#topmenu > div#dropdown:hover {
		height: 192.5px;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items {
		display: flex;
		justify-content: flex-start;
		align-items: stretch;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items > div.submenu {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: stretch;
		width: 120px;
		margin: 0 1px;
	}
	header > div#topbar > div#topmenu > div#dropdown > div.submenu-items > div.submenu > a.submenuitem {
		display: block;
		width: 100%;
		height: 32px;
		line-height: 32px;
		font-size: 16px;
		background-color: var(--theme);
		text-align: center;
	}
	.fix-header {
		top: -21px;
		position: fixed;
		grid-area: none;
		width: 100%;
	}
	
	/* Dark And Light Mode Switcher */
	#viewMode {
		border: 2px solid var(--subtheme-font);
		border-radius: 14.5px;
		width: 54px;
		height: 29px;
		background-color: var(--subtheme);
		position: relative;
	}
	#viewModeButton {
		border: 0;
		background-color: var(--subtheme-font);
		width: 20px;
		height: 20px;
		border-radius: 10px;
		position: absolute;
		top: 2.5px;
		left: 2.5px;
		transition: left .25s cubic-bezier(.5, 1, .5, 1);
	}
	#viewMode[data-toggle="true"] > #viewModeButton {
		left: 27.5px;
	}
	
	/* User Info Popup */
	div.popup-group {
		position: relative;
	}
	div.popup-group > button.togglePopup {
		width: 50px;
		height: 50px;
		/*border-radius: 25px;
		background-color: var(--subtheme);*/
		overflow: hidden;
	}
	div.popup-group > div.popup-window {
		position: absolute;
		padding: 10px 20px;
		border-radius: 5px;
		background-color: var(--theme);
		/* border: 2px solid var(--theme-font); */
		border: 2px solid #CCCCCC;
		top: 64.5px;
		right: 0px;
	}
	
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
	button#login-button {
		width: 100px;
		height: 32px;
		line-height: 32px;
		text-align: center;
		font-size: 16px;
	}
	button.init-button {
		border: 0;
		background-color: var(--theme);
		padding: 0;
		margin: 0;
		outline: none;
		cursor: pointer;
	}
	button > svg {
		pointer-events: none;
	}
	button#scrollToTop, button#scrollToBottom {
		position: fixed;
		width: 40px;
		height: 40px;
		outline: none;
		border: 0.5px solid var(--subtheme);
		border-radius: 10px;
		background-color: var(--theme);
		cursor: pointer;
		opacity: 0.5;
		box-shadow: 0 5px 5px var(--theme-font);
	}
	button#scrollToTop {
		bottom: 60px;
		right: 10px;
	}
	button#scrollToBottom {
		bottom: 10px;
		right: 10px;
	}
	
	
	/* Footer */
	#footer-info {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
</style>
</head>
<body>
	<header>
		<div id="usernav">
			<!-- <a href="">로그인</a>
			<a href="">회원가입</a>
			<a href="">마이페이지</a> -->
			<a href="">이용 약관</a>
			<a href="">개인정보 취급 방침</a>
		</div>
		<div id="topbar">
			<div id="logo-div" class="full-height" style="display: flex; justify-content: flex-start; align-items: center; padding: 0 10px;">
				<a id="logo" class="full-height" href="/">
					<!-- <img class="full-height" src="image/ShareGo_forLight.png"/> -->
					<div style="width: auto; display: flex; flex-direction: column; justify-content: center; align-items: flex-end;">
						<img src="${pageContext.request.contextPath}/image/ShareGo_Img.png" style="height: 30px;">
						<span style="font-size: 24px; font-weight: 900; margin: -5px 0 0 0;">ShareGo</span>
					</div>
				</a>
			</div>
			<div id="topmenu">
				<a class="adv-hover menuitem" href="">함께해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">같이사요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">나눔해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/community?category=1300">커뮤니티</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">정보공유</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="">고객센터</a>
				<div id="dropdown">
					<div style="width: 200px;"></div>
					<div class="submenu-items">
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">밥 / 카페</a>
							<a class="submenuitem adv-hover" href="">스포츠 / 운동</a>
							<a class="submenuitem adv-hover" href="">쇼핑</a>
							<a class="submenuitem adv-hover" href="">문화생활</a>
							<a class="submenuitem adv-hover" href="">취미생활</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">식료품</a>
							<a class="submenuitem adv-hover" href="">의류 / 잡화</a>
							<a class="submenuitem adv-hover" href="">생활용품</a>
							<a class="submenuitem adv-hover" href="">해외배송</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">식품</a>
							<a class="submenuitem adv-hover" href="">패션 / 잡화</a>
							<a class="submenuitem adv-hover" href="">가전 / 가구</a>
							<a class="submenuitem adv-hover" href="">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1310">일상수다</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1320">자랑하기</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1330">홍보하기</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1340">질문 / 요청</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">동네정보</a>
							<a class="submenuitem adv-hover" href="">구매정보</a>
							<a class="submenuitem adv-hover" href="">신규점포</a>
							<a class="submenuitem adv-hover" href="">지역활동</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="">공지</a>
							<a class="submenuitem adv-hover" href="">Q&A</a>
							<a class="submenuitem adv-hover" href="">이벤트</a>
							<a class="submenuitem adv-hover" href="">문의 / 건의</a>
						</div>
					</div>
					<div style="width: 200px;"></div>
				</div>
			</div>
			<div id="top-right">
				<c:if test="${memberInfo != null }">
					<!-- 메세지 추가 -->
					<div class="userMessage" onclick="userMessage()">
						<svg class="userMessage-popup" viewBox="0 0 512 512" style="width: 30; height: 30;"><rect x="48" y="96" width="416" height="320" rx="40" ry="40" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M112 160l144 112 144-112"/></svg>
					</div>
				</c:if>
				<!-- <button id="viewMode">
					<div id="viewModeButton"></div>
				</button> -->
				<div></div>
				<div class="popup-group">
					<c:choose>
						<c:when test="${memberInfo == null }">
							<button id="login" class="togglePopup init-button">
								<svg width="40" height="40" viewBox="0 0 512 512" style="margin: 5px;">
									<path d="M258.9 48C141.92 46.42 46.42 141.92 48 258.9c1.56 112.19 92.91 203.54 205.1 205.1 117 1.6 212.48-93.9 210.88-210.88C462.44 140.91 371.09 49.56 258.9 48zm126.42 327.25a4 4 0 01-6.14-.32 124.27 124.27 0 00-32.35-29.59C321.37 329 289.11 320 256 320s-65.37 9-90.83 25.34a124.24 124.24 0 00-32.35 29.58 4 4 0 01-6.14.32A175.32 175.32 0 0180 259c-1.63-97.31 78.22-178.76 175.57-179S432 158.81 432 256a175.32 175.32 0 01-46.68 119.25z"/>
									<path d="M256 144c-19.72 0-37.55 7.39-50.22 20.82s-19 32-17.57 51.93C191.11 256 221.52 288 256 288s64.83-32 67.79-71.24c1.48-19.74-4.8-38.14-17.68-51.82C293.39 151.44 275.59 144 256 144z"/>
								</svg>
							</button>
							<div id="login-popup" class="popup-window">
								<button id="login-button" class="subtheme-button adv-hover" onclick="location.href = '${pageContext.request.contextPath }/login';">
									로그인
								</button>
							</div>
						</c:when>
						<c:otherwise>
							<button id="userInfo" class="togglePopup adv-hover">
								<div id="user-profile">
									<img src="${pageContext.request.contextPath }/uploads/profile/${memberInfo.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
								</div>
							</button>
							<div id="userInfo-popup" class="popup-window">
								<div>
									<div style="display: flex; justify-content: flex-start; align-items: center; margin-bottom: 10px; padding: 10px; border-bottom: 2px solid var(--subtheme);">
										<div style="width: 75px; height: 75px; border-radius: 50%; margin-right: 10px; overflow: hidden; box-shadow: 0 2.5px 2.5px var(--theme-font); background-color: white;">
											<img style="object-fit: cover;" class="full-width full-height" src="${pageContext.request.contextPath }/uploads/profile/${memberInfo.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/anonymous.png';">
										</div>
										<div style="display: flex; flex-direction: column; justify-content: space-evenly; align-items: flex-start;">
											<h2 style="margin: 0; margin-left: 5px;">${memberInfo.mem_nickname }</h2>
											<div style="display: flex; justify-content: flex-start; align-items: center;">
												<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
													<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--confirm); width: 16px; height: 16px; margin: 0 5px;">
														<!-- https://freesvg.org/thumbs-up-silhouette -->
														<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
																	 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
													</svg>
													<span style="font-size: 16px;">${memberInfo.his_good }</span>
												</div>
												<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
													<div style="width: 8px; height: 2px; background-color: var(--theme-font); margin: 0 4px;"></div>
													<span style="font-size: 16px;">${memberInfo.his_normal }</span>
												</div>
												<div style="display: flex; justify-content: center; align-items: center; flex-grow: 1;">
													<svg viewBox="596.9167 0.0194 1565.0834 1639.8086" style="fill: var(--warning); width: 16px; height: 16px; transform: rotate(180deg); transform-origin: 50% 50%; margin: 0 5px;">
														<!-- https://freesvg.org/thumbs-up-silhouette -->
														<path d="M1520.5629,60.7246c9.2529,0,22.9001-2.2927,31.0228,1.2784c4.0228,1.7685,10.0901,1.592,14.4762,2.7188 c5.8456,1.5018,11.6852,2.95,17.423,4.8376c19.8309,6.524,38.4539,17.5962,54.3069,31.1189 c15.4873,13.2107,28.811,28.8823,38.5651,46.7913c10.3126,18.9348,15.6564,39.2017,20.9418,59.9346 c5.438,21.3307,6.3975,44.4503,6.5536,66.3782c0.1575,22.0935-1.3568,45.1182-6.2789,66.6433 c-4.7166,20.626-9.5502,40.6268-17.2726,60.4215c-8.1235,20.8223-19.2517,40.6216-29.2167,60.5945 c-9.6312,19.3036-18.8459,38.775-28.1715,58.2219c-9.0332,18.8382-17.9552,38.7832-24.1283,58.7702 c-6.0906,19.7205-11.4923,40.3191-10.5479,61.155c0.3005,6.6298,1.0413,21.0134,7.0928,25.2928 c3.0446,2.1529,8.7776,0.9438,12.2129,0.8727c6.3768-0.1321,12.7501-0.3911,19.1221-0.6643 c46.1556-1.9804,92.4683-1.7981,138.6613-1.7421c45.6135,0.0554,91.168,0.327,136.7052,3.2466 c22.5062,1.4431,45.473,2.3863,67.7657,5.9072c20.1079,3.1758,39.5485,8.5963,55.7,21.558 c15.6963,12.5963,29.2531,29.2695,40.9388,45.5461c11.8752,16.5402,23.2302,34.9225,30.1526,54.1568 c3.2183,8.9421,6.8928,18.6378,7.8779,28.1332c1.1016,10.6202-0.9648,19.2577-6.2202,28.4807 c-10.1318,17.7805-24.4211,32.9326-35.489,50.126c-5.583,8.6729-9.6936,17.2821-8.1272,27.8564 c1.5747,10.6291,6.9783,20.636,12.1709,29.8923c9.8293,17.5203,21.5195,34.1235,30.4695,52.1269 c4.1145,8.2762,7.9856,17.6038,7.1602,27.0314c-0.873,9.9706-6.8962,18.98-12.7485,26.7786 c-12.3955,16.5182-27.3953,30.9061-39.7224,47.4825c-5.7537,7.7368-11.4421,16.1678-11.7715,26.1475 c-0.349,10.5802,2.4435,20.917,6.0121,30.7833c7.3593,20.3463,17.4034,40.3459,23.2218,61.1707 c6.0962,21.8181-0.4746,39.7147-13.5889,57.3821c-12.5927,16.9652-28.8911,30.9794-43.8359,45.7869 c-14.4075,14.2753-27.1533,28.6671-27.001,50.0262c0.078,10.9647,0.1594,21.9293,0.2654,32.8938 c0.1068,11.0503,1.4434,22.9386-1.6632,33.6997c-5.4886,19.0134-21.4039,36.1284-34.7365,50.1152 c-14.4594,15.1687-30.6368,28.7886-47.7722,40.8331c-17.229,12.1102-34.8148,20.5139-55.1942,25.6375 c-20.9213,5.2599-42.9412,7.8329-64.4313,9.6827c-90.5679,7.7957-181.6688,2.4065-272.3201-0.8159 c-44.7479-1.5908-89.6749-4.4669-134.2426-8.8455c-10.2728-1.0093-20.5367-1.4325-30.8199-2.1771 c-10.1438-0.7345-20.5139-3.3689-30.5206-5.2036
																	 c-21.0529-3.8597-42.129-7.6986-63.1381-11.7871 c-42.7938-8.328-85.7592-15.8619-128.62-23.8524c-21.6165-4.0298-43.25-7.9535-64.874-11.9396 c-10.5157-1.9385-21.0328-3.881-31.521-5.9642c-3.2131-0.6381-6.5777-1.077-7.1765-4.8949 c-0.9216-5.8757-0.113-12.4637-0.1102-18.4089c0.0895-185.7694,0.0862-371.5388,0.087-557.3082 c0.0001-11.146,0.0001-22.2924,0.0002-33.4384c0-2.7115-0.8728-7.2691,0.6964-9.6804c1.8351-2.8201,9.785-1.3683,12.4819-1.3834 c9.8492-0.0552,19.8955,0.8073,29.6094-1.1854c9.9312-2.0372,19.0519-6.6622,27.5282-12.1067 c34.0913-21.8972,59.651-57.7686,81.01-91.4886c23.2795-36.7521,43.9276-75.4404,62.1334-114.9429 c18.3373-39.788,34.3848-80.5327,51.8765-120.6971c17.0248-39.0923,48.2561-65.2728,80.8578-91.2554 c16.4827-13.1361,32.6666-26.548,46.3193-42.7003c13.8022-16.3293,24.9845-34.8267,33.7615-54.2959 c18.1166-40.1859,30.1417-84.3115,36.2227-127.9681c6.2136-44.6116,12.6005-89.2005,14.9655-134.2462 c0.3915-7.4563,1.6073-14.5817,7.3704-19.8748c2.4473-2.2476,5.3876-3.8947,8.4872-5.0599 C1513.9449,63.4004,1519.2778,63.2971,1520.5629,60.7246C1530.4342,60.7246,1519.7723,62.3071,1520.5629,60.7246z M654.1641,898.2689c0,113.5108,0,227.0218,0,340.5325c0,46.5209,0,93.0417,0,139.5626c0,23.2604,0,46.5209,0,69.7813 c0,12.0956,0,24.1909,0,36.2863c0,5.5826,0,11.165,0,16.7476c2.9518,0.6001,3.0689,7.4297,3.9023,9.6901 c5.8673,15.9106,20.7537,29.5836,36.6451,35.1024c9.34,3.2439,18.8117,3.2965,28.5798,3.3029 c11.0439,0.0074,22.0878,0.012,33.1318,0.0145c46.0164,0.0112,92.0328-0.0095,138.0493,0.0101 c19.0814,0.0082,36.9496-6.9194,49.56-21.6554c13.4414-15.7072,14.5669-34.699,14.5618-54.4558 c-0.012-46.6202-0.0196-93.2406-0.025-139.8608c-0.0109-93.2407-0.0132-186.4812-0.0248-279.7219 c-0.0057-46.3734,1.1533-92.9179-0.0865-139.2733c-0.5342-19.9727-7.4376-38.3519-23.3443-51.1132 c-15.4163-12.3679-33.5844-13.338-52.5065-13.3804c-46.3998-0.1041-92.7999-0.1375-139.1995-0.0057 c-20.9935,0.0595-42.7304-1.9652-61.1382,10.0648c-7.4174,4.8474-13.9482,11.0446-18.7111,18.5484 c-2.1867,3.4451-3.9904,7.1271-5.4059,10.9533C657.395,891.446,656.8574,897.8079,654.1641,898.2689 C654.1641,1099.2389,655.7422,897.9987,654.1641,898.2689z"/>
													</svg>
													<span style="font-size: 16px;">${memberInfo.his_bad }</span>
												</div>
											</div>
										</div>
									</div>
									<button style="width: 240px; height: 32px; font-size: 16px; font-weight: bold; border-radius: 5px; margin: 5px 10px;" class="theme-button" onclick="location.href = '${pageContext.request.contextPath }/';">
										마이 페이지
									</button>
									<c:if test="${memberInfo.mem_authority >= 108 }">
										<button style="width: 240px; height: 32px; font-size: 16px; font-weight: bold; border-radius: 5px; margin: 5px 10px;" class="theme-button" onclick="location.href = '${pageContext.request.contextPath }/admin';">
											관리자 페이지
										</button>
									</c:if>
									<button style="width: 240px; height: 32px; font-size: 16px; font-weight: bold; border-radius: 5px; margin: 5px 10px; margin-bottom: 10px;" class="subtheme-button" onclick="location.href = '${pageContext.request.contextPath }/logout';">
										로그아웃
									</button>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</header>
	<aside id="leftside">
		
	</aside>
	<main>
		<div class="container" style="position: relative; left: 400px;"  >
		<span>댓글쓰기</span>
		<form action="bjcommunitywrite" method="post" name="frm">
			<div>작성자 : ${memberInfo.mem_nickname }</div>
			<div>
			<input type="hidden" name="mem_id" value="${memberInfo.mem_id}">
			</div>
			<div>내용</div>
			<div><textarea rows="20" cols="100" name="rep_content"></textarea></div>
			<div><input type="submit" value="완료"/></div>
			
		</form>
		</div>
		
		
		
		
		<button id="scrollToTop" class="adv-hover">
			<svg style="fill: var(--subtheme); stroke: var(--subtheme); stroke-width: 2px; stroke-linecap: round; stroke-linejoin: round;" width="20" height="10" viewBox="0 0 32 16">
				<path d="M 15 1 L 1 15 31 15 Z"/>
			</svg>
		</button>
		<button id="scrollToBottom" class="adv-hover">
			<svg style="fill: var(--subtheme); stroke: var(--subtheme); stroke-width: 2px; stroke-linecap: round; stroke-linejoin: round;" width="20" height="10" viewBox="0 0 32 16">
				<path d="M 15 15 L 1 1 31 1 Z"/>
			</svg>
		</button>
	</main>
	<aside id="rightside">
		
	</aside>
	<footer>
		<div id="footer-info" class="full-height">
			<span style="font-size: 40px; font-weight: 900; margin: 0 10px; text-align: left; opacity: 0.5;">ShareGo</span>
			<div style="font-size: 12px; flex-grow: 1;">
				<p>서울특별시 마포구 신촌로 176</p>
				<p>02-313-1711</p>
				<p>choongang@naver.com</p>
			</div>
			<div>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M480 257.35c0-123.7-100.3-224-224-224s-224 100.3-224 224c0 111.8 81.9 204.47 189 221.29V322.12h-56.89v-64.77H221V208c0-56.13 33.45-87.16 84.61-87.16 24.51 0 50.15 4.38 50.15 4.38v55.13H327.5c-27.81 0-36.51 17.26-36.51 35v42h62.12l-9.92 64.77H291v156.54c107.1-16.81 189-109.48 189-221.31z" fill-rule="evenodd"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="stroke: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M349.33 69.33a93.62 93.62 0 0193.34 93.34v186.66a93.62 93.62 0 01-93.34 93.34H162.67a93.62 93.62 0 01-93.34-93.34V162.67a93.62 93.62 0 0193.34-93.34h186.66m0-37.33H162.67C90.8 32 32 90.8 32 162.67v186.66C32 421.2 90.8 480 162.67 480h186.66C421.2 480 480 421.2 480 349.33V162.67C480 90.8 421.2 32 349.33 32z"/>
						<path d="M377.33 162.67a28 28 0 1128-28 27.94 27.94 0 01-28 28zM256 181.33A74.67 74.67 0 11181.33 256 74.75 74.75 0 01256 181.33m0-37.33a112 112 0 10112 112 112 112 0 00-112-112z"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M508.64 148.79c0-45-33.1-81.2-74-81.2C379.24 65 322.74 64 265 64h-18c-57.6 0-114.2 1-169.6 3.6C36.6 67.6 3.5 104 3.5 149 1 184.59-.06 220.19 0 255.79q-.15 53.4 3.4 106.9c0 45 33.1 81.5 73.9 81.5 58.2 2.7 117.9 3.9 178.6 3.8q91.2.3 178.6-3.8c40.9 0 74-36.5 74-81.5 2.4-35.7 3.5-71.3 3.4-107q.34-53.4-3.26-106.9zM207 353.89v-196.5l145 98.2z"/>
					</svg>
				</a>
				<a href="" style="margin: 10px;">
					<svg style="fill: var(--theme-font);" width="30" height="30" viewBox="0 0 512 512">
						<path d="M496 109.5a201.8 201.8 0 01-56.55 15.3 97.51 97.51 0 0043.33-53.6 197.74 197.74 0 01-62.56 23.5A99.14 99.14 0 00348.31 64c-54.42 0-98.46 43.4-98.46 96.9a93.21 93.21 0 002.54 22.1 280.7 280.7 0 01-203-101.3A95.69 95.69 0 0036 130.4c0 33.6 17.53 63.3 44 80.7A97.5 97.5 0 0135.22 199v1.2c0 47 34 86.1 79 95a100.76 100.76 0 01-25.94 3.4 94.38 94.38 0 01-18.51-1.8c12.51 38.5 48.92 66.5 92.05 67.3A199.59 199.59 0 0139.5 405.6a203 203 0 01-23.5-1.4A278.68 278.68 0 00166.74 448c181.36 0 280.44-147.7 280.44-275.8 0-4.2-.11-8.4-.31-12.5A198.48 198.48 0 00496 109.5z"/>
					</svg>
				</a>
			</div>
		</div>
	</footer>
</body>
</html>