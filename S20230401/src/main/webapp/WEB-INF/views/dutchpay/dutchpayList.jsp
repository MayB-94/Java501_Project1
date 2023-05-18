<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardName } ${param.search == null ? '' : '검색 ' }${currentPage == null ? '1' : currentPage } 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/initializer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/layout.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/layout.css">
<style type="text/css">
	button{
		width: auto;
		height: 25px;
		font-size:12px;
		font-family: 'Nanum Gothic';
		color: white;
		text-align: center;
		background: gray;
		border: none;
		border-radius: 14px;
	}
	.btn-write {
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-weight: bolder;
		cursor: pointer;
	}
	.btns-tag{
		padding: 0px 2px;
		background-color: transparent;
		color: var(--subtheme);
		font-weight: bold;
		cursor: pointer;
	}
	.btns-tag::before{
		content: '#';
	}
	
	span.article-title > a:hover {
		color: var(--subtheme);
	}
	
	div.article-info:not(:last-child) {
		border-bottom: 1px solid rgba(128, 128, 128, 0.5);
	}
	
	/* Search style */
	div.board-search > form svg {
		fill: none;
		stroke: var(--subtheme);
		stroke-width: 64px;
		stroke-linecap: round;
		stroke-linejoin: round;
		width: 20px;
		height: 20px;
		margin-right: 5px;
	}
	
	div.board-search > form select {
		outline: none;
		border: 2.5px solid var(--subtheme);
		border-width: 0 0 2.5px 0;
		color: var(--subtheme);
		font-weight: bolder;
		background-color: transparent;
	}
	
	div.board-search > form input[type="text"] {
		outline: none;
		border: 2.5px solid var(--subtheme);
		border-width: 0 0 2.5px 0;
		background-color: transparent;
	}
	
	div.board-search > form button[type="submit"] {
		outline: none;
		border: 0;
		background-color: var(--subtheme);
		color: var(--subtheme-font);
		font-size: 14px;
		font-weight: bold;
		cursor: pointer;
		border-radius: 5px;
	}
	
	/* Paging style */
	div.board_paging {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	button.paging-block, button.paging-page {
		border-radius: 12px;
		min-width: 24px;
		height: 24px;
		cursor: pointer;
		padding: 0;
		background-color: transparent;
		border: 0;
		outline: none;
	}
	button.paging-block *, button.paging-page * {
		pointer-events: none;
	}
	button.paging-block {
		width: 16px;
		height: 16px;
	}
	button.paging-block > svg {
		width: 50%;
		height: 100%;
		fill: none;
		stroke: var(--subtheme);
		cursor: default;
		stroke-width: 64px;
		stroke-linecap: round;
		stroke-linejoin: round;
	}
	button.paging-block:disabled > svg {
		stroke: rgba(var(--subtheme-rgb), 0.5);
	}
	button.paging-page {
		color: var(--theme-font);
		font-size: 16px;
		font-weight: bolder;
	}
	button.paging-page > span {
		color: inherit;
		font-size: inherit;
		font-weight: inherit;
	}
	button.paging-page:hover:not(:disabled) {
		background-color: rgba(var(--theme-font-rgb), 0.25);
	}
	button.paging-block:disabled {
		cursor: default;
	}
	button.paging-page:disabled {
		color: var(--subtheme);
		cursor: default;
	}
</style>
<script type="text/javascript">

	function goWriteForm(p_mem_id) {
		 if ( p_mem_id != null ) {
			location.href="/board/dutchpay/dutchpayWriteForm?mem_id=" +p_mem_id;
		 } else {
			alert('로그인이 필요한 서비스입니다.');
		    location.href = '/login';
		 }
		}   
	
</script>
</head>
<body>
	<header>
<div id="usernav">
			<a href="">이용 약관</a>
			<a href="">개인정보 취급 방침</a>
		</div>
		<div id="topbar">
			<div id="logo-div" class="full-height" style="display: flex; justify-content: flex-start; align-items: center; padding: 0 10px;">
				<a id="logo" class="full-height" href="${pageContext.request.contextPath}/">
					<div style="width: auto; display: flex; flex-direction: column; justify-content: center; align-items: flex-end;">
						<img src="${pageContext.request.contextPath}/image/ShareGo_Img.png" style="height: 30px;">
						<span style="font-size: 24px; font-weight: 900; margin: -5px 0 0 0;">ShareGo</span>
					</div>
				</a>
			</div>
			<div id="topmenu">
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/together?category=1000">함께해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/dutchpay?category=1100">같이사요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/share?category=1200">나눔해요</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/community?category=1300">커뮤니티</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/information?category=1400">정보공유</a>
				<div class="menu-separator"></div>
				<a class="adv-hover menuitem" href="${pageContext.request.contextPath}/board/customer?category=1500">고객센터</a>
				<div id="dropdown">
					<div style="width: 200px;"></div>
					<div class="submenu-items">
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1010">밥 / 카페</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1020">스포츠 / 운동</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1030">쇼핑</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1040">문화생활</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1050">취미생활</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/together?category=1060">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/dutchpay?category=1110">식료품</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/dutchpay?category=1120">의류 / 잡화</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/dutchpay?category=1130">생활용품</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/dutchpay?category=1140">해외배송</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/dutchpay?category=1150">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/share?category=1210">식품</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/share?category=1220">패션 / 잡화</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/share?category=1230">가전 / 가구</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/share?category=1240">기타</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1310">일상수다</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1320">자랑하기</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1330">홍보하기</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/community?category=1340">질문 / 요청</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/information?category=1410">동네정보</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/information?category=1420">구매정보</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/information?category=1430">신규점포</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/information?category=1440">지역활동</a>
						</div>
						<div class="submenu">
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/customer?category=1510">공지</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/customer?category=1520">Q&A</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/customer?category=1530">이벤트</a>
							<a class="submenuitem adv-hover" href="${pageContext.request.contextPath}/board/customer?category=1540">문의 / 건의</a>
						</div>
					</div>
					<div style="width: 200px;"></div>
				</div>
			</div>
			<div id="top-right">
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
		<div class="container padding-10px">
			<div class="article-view">
				<div class="board-title" align="center">
					<h1 class="color-subtheme">${boardName} 게시판</h1>
				</div>
				
				<div class="display-flex justify-content-flex-end align-items-center"><span class="font-size-14px" style="color: rgba(var(--theme-font-rgb), 0.5);">총 ${totalArticle }개의 게시글이 있습니다</span></div>
				<!-- 게시판 목록 출력 -->
				<div class="board-category display-flex justify-content-flex-start font-size-16px font-weight-bolder" align="center">
					<c:forEach var="CM" items="${commList}">
						<div class="item full-width" style="border-bottom: 2px solid var(--subtheme); ${CM.comm_id == category? 'border: 2px solid var(--subtheme); border-bottom: 0px;':''}">
							<a href="${pageContext.request.contextPath}/board/dutchpay?category=${CM.comm_id}" ${CM.comm_id != category ? 'style="color: rgba(var(--theme-font-rgb), 0.5);"' : '' } class="active full-width full-height display-block padding-5px padding-hor-0">${CM.comm_id == 1100 ? '전체' : CM.comm_value}</a>
						</div>
					</c:forEach>
				</div>
				
				<!-- 왼쪽 오른쪽(글쓰기) 버튼 -->
				<div class="board-btns display-flex flex-grow-1" style="margin: 5px 0px;">
					<div class="btns-right" style="display: flex; justify-content: flex-end; flex-grow: 1;">
						<span>
							<%-- <c:if test="${article.category % 100 != 0 && memberInfo != null}"> --%>
								<button class="btn-write adv-hover" onclick="goWriteForm(${memberInfo.mem_id})">글쓰기</button>
							<%-- </c:if> --%>
						</span>
					</div>
				</div>
				<!-- 공지사항 -->
				<div class="notice-customer"></div>
				<div class="notice-board"></div>
				
				<!-- 글 출력 -->
				<div class="board-articleList" style="display: flex; flex-direction: column;">
					<c:forEach var="ART" items="${listArticle }">
					<!-- 글 시작 -->
						<div class="article-info" style="display: flex; padding: 10px; flex-grow: 1;">
							<div class="view-preview" style="display: flex; align-items: center; margin-right: 14px; border: 1px solid rgba(128, 128, 128, 0.5); border-radius: 2.5px; width: 82px; height: 82px;">
								<img class="article-thumbnail" style="width: 80px; height: 80px; object-fit: cover;" src="${pageContext.request.contextPath }/image/ShareGo_Img.png" onload="$(this).attr('src', getThumbnail('<c:out value="${ART.art_content}" escapeXml="true"/>', true));this.onload=null;$(this).removeAttr('onload');" onerror="this.onerror=null;this.src='${pageContext.request.contextPath }/image/ShareGo_Not_Found_Image.png';$(this).removeAttr('onerror');">
							</div>
							<div class="view-inner" style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
								<!-- 글의 첫 줄 -->
								<div class="view-top flex-grow-1 display-flex justify-content-space-between align-items-center">
									<div class="flex-grow-1 display-flex justify-content-flex-start align-items-center">
										<c:if test="${ART.brd_id != category }">
											<span class="category-name color-subtheme font-size-12px font-weight-bold display-flex justify-content-center align-items-center margin-right-5px" style="border-radius: 2.5px; border: 2px solid var(--subtheme); padding: 1.25px 2.5px;">${ART.brd_name}</span>
										</c:if>
										<span class="article-title span-ellipsis font-weight-bolder"><a href="${pageContext.request.contextPath}/board/dutchpay/${ART.art_id}?brd_id=${ART.brd_id}&category=${category}">${ART.art_title}</a></span>
									</div>
									
									<div>
										<c:set var="sysdate" value="<%=new java.util.Date() %>"/>
										<c:set var="interval" value="${sysdate.time - ART.art_regdate.time }"/>
										<fmt:formatNumber var="date" value="${interval / 1000 / 60 / 60 / 24}" type="number" pattern="0"/>
										<span class="font-size-14px" style="color: rgba(var(--theme-font-rgb), 0.5);">
											<c:choose>
												<c:when test="${(interval / 1000) < 60 }">
													<fmt:formatNumber var="date" value="${interval / 1000 }" type="number" pattern="0"/>
													${date}초 전
												</c:when>
												<c:when test="${(interval / 1000 / 60) < 60 }">
													<fmt:formatNumber var="date" value="${interval / 1000 / 60 }" type="number" pattern="0"/>
													${date}분 전
												</c:when>
												<c:when test="${(interval / 1000 / 60 / 60) < 24 }">
													<fmt:formatNumber var="date" value="${interval / 1000 / 60 / 60 }" type="number" pattern="0"/>
													${date}시간 전
												</c:when>
												<c:when test="${(interval / 1000 / 60 / 60 / 24) < 7 }">
													<fmt:formatNumber var="date" value="${interval / 1000 / 60 / 60 / 24 }" type="number" pattern="0"/>
													${date}일 전
												</c:when>
												<c:otherwise>
													<fmt:formatDate var="date" value="${ART.art_regdate }" pattern="yy-MM-dd hh:mm:ss"/>
													${date }
												</c:otherwise>
											</c:choose>
										</span>
									</div>
								</div>
								<div class="view-middle display-flex justify-content-space-between align-items-center padding-5px padding-hor-0">
									<span class="font-weight-bolder">${ART.mem_nickname}</span>
									<div class="display-flex justify-content-flex-end align-items-center">
										<c:if test="${ART.status_name != null}">
											<button class="btn margin-right-5px font-weight-bolder" ${ART.trd_status == 401 ? 'style="background-color: var(--subtheme);"' : '' }>${ART.status_name}</button>
										</c:if>
										<c:choose>
											<%-- <c:when test="${ART.trd_cost == null || ART.trd_cost == 0}">
												<span class="font-size-20px font-weight-bolder color-subtheme">무료</span>
											</c:when> --%>
											<c:when test="${ART.trd_cost != null && ART.trd_cost != 0}">
												<span class="font-size-20px font-weight-bolder color-theme-font"><fmt:formatNumber value="${ART.trd_cost}" pattern="###,###,###,###,###"/> 원 [배송비 포함]</span>
											</c:when>
										</c:choose>
									</div>
								</div>
								<!-- 글의 마지막 줄 -->
								<div class="view-bottom">
									<div class="display-flex justify-content-space-between align-items-center">
										<!-- 태그 출력 및 클릭 시 검색 -->
										<div class="view-tag display-flex justify-content-flex-start flex-grow-1">
											<form action="${pageContext.request.contextPath}/board/dutchpay/searchForm">
												<input type="hidden" name="category" value="${category}">
												<input type="hidden" name="brd_id" value="${ART.brd_id}">
												<input type="hidden" name="search" value="articleTag">
												<c:forEach begin="1" end="5" varStatus="status">
													<c:set var="art_tag" value="art_tag${status.index}"/>
														<c:if test="${ART[art_tag] != null}">
															<button class="btns-tag" name="keyWord" value="${ART[art_tag]}">${ART[art_tag]}</button>
														</c:if>
												</c:forEach>
											</form>
										</div>
										
										<div class="display-flex justify-content-flex-end align-items-center">
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 121.86 122.88" style="width: 12px; height: 12px;">
													<!-- https://uxwing.com/comment-icon/ -->
													<path d="M30.28,110.09,49.37,91.78A3.84,3.84,0,0,1,52,90.72h60a2.15,2.15,0,0,0,2.16-2.16V9.82a2.16,2.16,0,0,0-.64-1.52A2.19,2.19,0,0,0,112,7.66H9.82A2.24,2.24,0,0,0,7.65,9.82V88.55a2.19,2.19,0,0,0,2.17,2.16H26.46a3.83,3.83,0,0,1,3.82,3.83v15.55ZM28.45,63.56a3.83,3.83,0,1,1,0-7.66h53a3.83,3.83,0,0,1,0,7.66Zm0-24.86a3.83,3.83,0,1,1,0-7.65h65a3.83,3.83,0,0,1,0,7.65ZM53.54,98.36,29.27,121.64a3.82,3.82,0,0,1-6.64-2.59V98.36H9.82A9.87,9.87,0,0,1,0,88.55V9.82A9.9,9.9,0,0,1,9.82,0H112a9.87,9.87,0,0,1,9.82,9.82V88.55A9.85,9.85,0,0,1,112,98.36Z"/>
												</svg>
												<span class="margin-hor-2_5px">${ART.reply_count == null ? 0 : ART.reply_count}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: none; stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M255.66 112c-77.94 0-157.89 45.11-220.83 135.33a16 16 0 00-.27 17.77C82.92 340.8 161.8 400 255.66 400c92.84 0 173.34-59.38 221.79-135.25a16.14 16.14 0 000-17.47C428.89 172.28 347.8 112 255.66 112z"/>
													<circle cx="256" cy="256" r="80"/>
												</svg>
												<span class="margin-hor-2_5px">${ART.art_read}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: var(--theme-font); stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M320 458.16S304 464 256 464s-74-16-96-32H96a64 64 0 01-64-64v-48a64 64 0 0164-64h30a32.34 32.34 0 0027.37-15.4S162 221.81 188 176.78 264 64 272 48c29 0 43 22 34 47.71-10.28 29.39-23.71 54.38-27.46 87.09-.54 4.78 3.14 12 7.95 12L416 205"/>
													<path d="M416 271l-80-2c-20-1.84-32-12.4-32-30h0c0-17.6 14-28.84 32-30l80-4c17.6 0 32 16.4 32 34v.17A32 32 0 01416 271zM448 336l-112-2c-18-.84-32-12.41-32-30h0c0-17.61 14-28.86 32-30l112-2a32.1 32.1 0 0132 32h0a32.1 32.1 0 01-32 32zM400 464l-64-3c-21-1.84-32-11.4-32-29h0c0-17.6 14.4-30 32-30l64-2a32.09 32.09 0 0132 32h0a32.09 32.09 0 01-32 32zM432 400l-96-2c-19-.84-32-12.4-32-30h0c0-17.6 13-28.84 32-30l96-2a32.09 32.09 0 0132 32h0a32.09 32.09 0 01-32 32z"/>
												</svg>
												<span class="margin-hor-2_5px">${ART.art_good}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: var(--theme-font); stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M192 53.84S208 48 256 48s74 16 96 32h64a64 64 0 0164 64v48a64 64 0 01-64 64h-30a32.34 32.34 0 00-27.37 15.4S350 290.19 324 335.22 248 448 240 464c-29 0-43-22-34-47.71 10.28-29.39 23.71-54.38 27.46-87.09.54-4.78-3.14-12-8-12L96 307"/>
													<path d="M96 241l80 2c20 1.84 32 12.4 32 30h0c0 17.6-14 28.84-32 30l-80 4c-17.6 0-32-16.4-32-34v-.17A32 32 0 0196 241zM64 176l112 2c18 .84 32 12.41 32 30h0c0 17.61-14 28.86-32 30l-112 2a32.1 32.1 0 01-32-32h0a32.1 32.1 0 0132-32zM112 48l64 3c21 1.84 32 11.4 32 29h0c0 17.6-14.4 30-32 30l-64 2a32.09 32.09 0 01-32-32h0a32.09 32.09 0 0132-32zM80 112l96 2c19 .84 32 12.4 32 30h0c0 17.6-13 28.84-32 30l-96 2a32.09 32.09 0 01-32-32h0a32.09 32.09 0 0132-32z"/>
												</svg>
												<span class="margin-hor-2_5px">${ART.art_bad}</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 검색 -->
				<div class="board-search" align="center" style="height: 20px; margin: 15px;">
					<form action="${pageContext.request.contextPath}/board/dutchpay/articleSearch">
						<input type="hidden" name="category" value="${category}">
						<input type="hidden" name="brd_id" value="${category}">
						<svg viewBox="0 0 512 512">
							<path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z"/>
							<path d="M338.29 338.29L448 448"/>
						</svg>
						<select name="search">
							<option value="article">제목+내용</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="nickname">닉네임</option>
							<option value="articleTag">태그</option>
						</select>
						<input type="text" name="keyWord" placeholder="검색어 입력" required="required"><!--  -->
						<button type="submit" class="adv-hover">검색</button>
					</form>
				</div>
				<!-- 페이징 -->
				<div class="board_paging" align="center" style="font-size: 18px; clear: both;">
					<button class="paging-block display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/dutchpay?currentPage=${page.startPage-page.pageBlock }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.startPage <= page.pageBlock ? 'disabled' : '' }>
						<svg viewBox="0 0 256 512">
							<path d="M 224 32 L 32 256 224 480"/>
						</svg>
					</button>
					<c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
						<button class="paging-page display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/dutchpay?currentPage=${i }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.currentPage == i ? 'disabled' : '' }>
							<span>${i }</span>
						</button>
					</c:forEach>
					<button class="paging-block display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/dutchpay?currentPage=${page.endPage + 1 }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.endPage == page.totalPage ? 'disabled' : '' }>
						<svg viewBox="0 0 256 512">
							<path d="M 32 32 L 224 256 32 480"/>
						</svg>
					</button>
				</div>
				<%-- <c:set var="params" value=""/>
				<c:forEach var='test' items="${param }" varStatus="status">
					<c:choose>
						<c:when test="${status.index == 0 }"><c:set var="params" value="?"/></c:when>
						<c:otherwise><c:set var="params" value="${params}&"/></c:otherwise>
					</c:choose>
					<c:url var="params" value="${params}${test.key }=${test.value }"/>
				</c:forEach> --%>
				<c:out value="${params }"/>
			</div>
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