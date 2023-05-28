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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/share/total.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/share/total.css">

</head>
<body>
	<main>
		<div class="container padding-10px">
			<div class="article-view">
				<div class="board-title margin-50px margin-hor-0" align="center" style="border: 1px solid transparent; border-radius: 20px; background-color: rgba(var(--subtheme-rgb), 0.25)">
					<h1 class="color-subtheme text-align-left padding-10px padding-hor-20px">${boardName} 게시판</h1>
					<p class="translucent-theme-font text-align-left padding-10px padding-hor-20px" style="padding-top: 0;">사용하지 않는 물건들을 다른 사람과 나눠보세요</p>
					<c:forEach var="name" items="${shareName}">
					${name.boardName}
					${name.categoryName}
					</c:forEach>
				</div>
				
				<div class="display-flex justify-content-flex-end align-items-center"><span class="font-size-14px" style="color: rgba(var(--theme-font-rgb), 0.5);">총 ${totalArt }개의 게시글이 있습니다</span></div>
				<!-- 게시판 목록 출력 -->
				<div class="board-category display-flex justify-content-flex-start font-size-16px font-weight-bolder" align="center">
					<c:forEach var="comm" items="${commList}">
						<div class="item full-width" style="border-bottom: 2px solid var(--subtheme); ${comm.comm_id == category? 'border: 2px solid var(--subtheme); border-bottom: 0px;':''}">
							<a href="${pageContext.request.contextPath}/board/share?category=${comm.comm_id}" ${comm.comm_id != category ? 'style="color: rgba(var(--theme-font-rgb), 0.5);"' : '' } class="active full-width full-height display-block padding-5px padding-hor-0">${comm.comm_id == commList.get(0).comm_id ? '전체' : comm.comm_value}</a>
						</div>
					</c:forEach>
				</div>
				
				<!-- 왼쪽 오른쪽(글쓰기) 버튼 -->
				<div class="board-btns display-flex flex-grow-1 margin-10px">
					<div class="btns-right" style="display: flex; justify-content: flex-end; flex-grow: 1;">
						<c:if test="${memberInfo != null}">
							<button class="btn-write adv-hover border-radius-5px" onclick="location.href='${pageContext.request.contextPath}/board/share/write?category=${category}';">
								<svg viewBox="0 0 24 24" width="12" height="12" style="stroke: white; fill: white;"><path d="M21.731 2.269a2.625 2.625 0 00-3.712 0l-1.157 1.157 3.712 3.712 1.157-1.157a2.625 2.625 0 000-3.712zM19.513 8.199l-3.712-3.712-12.15 12.15a5.25 5.25 0 00-1.32 2.214l-.8 2.685a.75.75 0 00.933.933l2.685-.8a5.25 5.25 0 002.214-1.32L19.513 8.2z"></path></svg> 글쓰기
							</button>
						</c:if>
					</div>
				</div>
				<!-- 공지사항 -->
				<div class="notice-customer"></div>
				<div class="notice-board"></div>
				
				<!-- 글 출력 -->
				<div class="board-articleList" style="display: flex; flex-direction: column;">
					<c:forEach var="article" items="${articleList}">
					<!-- 글 시작 -->
						<div class="article-info" style="display: flex; padding: 10px; flex-grow: 1;">
							<div class="view-preview" style="display: flex; align-items: center; margin-right: 14px; border: 1px solid rgba(128, 128, 128, 0.5); border-radius: 2.5px; width: 82px; height: 82px;">
								<img class="article-thumbnail" style="width: 80px; height: 80px; object-fit: cover;" src="${pageContext.request.contextPath }/image/ShareGo_Img.png" onload="$(this).attr('src', getThumbnail('<c:out value="${article.art_content}" escapeXml="true"/>', true));this.onload=null;$(this).removeAttr('onload');" onerror="this.onerror=null;this.src='${pageContext.request.contextPath }/image/ShareGo_Not_Found_Image.png';$(this).removeAttr('onerror');">
							</div>
							<div class="view-inner" style="display: flex; flex-direction: column; justify-content: center; flex-grow: 1;">
								<!-- 글의 첫 줄 -->
								<div class="view-top flex-grow-1 display-flex justify-content-space-between align-items-center">
									<div class="flex-grow-1 display-flex justify-content-flex-start align-items-center">
										<c:if test="${article.brd_id != category }">
											<span class="category-name color-subtheme font-size-12px font-weight-bold display-flex justify-content-center align-items-center margin-right-5px" style="border-radius: 2.5px; border: 2px solid var(--subtheme); padding: 1.25px 2.5px;">${article.brd_name}</span>
										</c:if>
										<span class="article-title span-ellipsis font-weight-bolder"><a href="${pageContext.request.contextPath}/board/share/${article.art_id}?brd_id=${article.brd_id}&category=${category}">${article.art_title}</a></span>
									</div>
									
									<div>
										<c:set var="sysdate" value="<%=new java.util.Date() %>"/>
										<c:set var="interval" value="${sysdate.time - article.art_regdate.time }"/>
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
													<fmt:formatDate var="date" value="${article.art_regdate }" pattern="yy-MM-dd hh:mm:ss"/>
													${date }
												</c:otherwise>
											</c:choose>
										</span>
									</div>
								</div>
								<div class="view-middle display-flex justify-content-space-between align-items-center padding-5px padding-hor-0">
									<span>
										<span class="font-weight-bolder">${article.member.mem_nickname}</span>
										<span id="member_username" style="color: rgba(var(--theme-font-rgb), 0.5);">${article.member.mem_username}</span>
									</span>
									<div class="display-flex justify-content-flex-end align-items-center">
									
 										<%-- <c:if test="${fn:contains(article.status_name, '모집')}"><button>${article.status_name}</button></c:if>
										<c:if test="${fn:contains(article.status_name, '진행')}"><button>${article.status_name}</button></c:if>
										<c:if test="${fn:contains(article.status_name, '완료')}"><button>${article.status_name}</button></c:if>
										<c:if test="${fn:contains(article.status_name, '취소')}"><button>${article.status_name}</button></c:if> --%>
										
										<c:if test="${article.status_name != null}">
											<button class="btn margin-right-5px font-weight-bolder" ${article.trade.trd_status == 401 || article.trade.trd_status == 402 ? 'style="background-color: var(--subtheme);"' : '' }>${article.status_name}</button>
										</c:if>
										
										
										<c:choose>
											<c:when test="${article.trade.trd_cost == 0}">
												<span class="font-size-20px font-weight-bolder color-subtheme">무료</span>
											</c:when>
											<c:when test="${article.trade.trd_cost != null && article.trade.trd_cost != 0}">
												<span class="font-size-20px font-weight-bolder color-theme-font"><fmt:formatNumber value="${article.trade.trd_cost}" pattern="###,###,###,###,###"/> 원</span>
											</c:when>
										</c:choose>
									</div>
								</div>
								<!-- 글의 마지막 줄 -->
								<div class="view-bottom">
									<div class="display-flex justify-content-space-between align-items-center">
										<!-- 태그 출력 및 클릭 시 검색 -->
										<div class="view-tag display-flex justify-content-flex-start flex-grow-1">
											<form action="${pageContext.request.contextPath}/board/share/searchForm">
												<input type="hidden" name="category" value="${category}">
												<input type="hidden" name="brd_id" value="${article.brd_id}">
												<input type="hidden" name="search" value="articleTag">
												<c:forEach begin="1" end="5" varStatus="status">
													<c:set var="art_tag" value="art_tag${status.index}"/>
														<c:if test="${article[art_tag] != null}">
															<button class="btns-tag" name="keyWord" value="${article[art_tag]}">${article[art_tag]}</button>
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
												<span class="margin-hor-2_5px">${article.rep_cnt == null ? 0 : article.rep_cnt}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: none; stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M255.66 112c-77.94 0-157.89 45.11-220.83 135.33a16 16 0 00-.27 17.77C82.92 340.8 161.8 400 255.66 400c92.84 0 173.34-59.38 221.79-135.25a16.14 16.14 0 000-17.47C428.89 172.28 347.8 112 255.66 112z"/>
													<circle cx="256" cy="256" r="80"/>
												</svg>
												<span class="margin-hor-2_5px">${article.art_read}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: var(--theme-font); stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M320 458.16S304 464 256 464s-74-16-96-32H96a64 64 0 01-64-64v-48a64 64 0 0164-64h30a32.34 32.34 0 0027.37-15.4S162 221.81 188 176.78 264 64 272 48c29 0 43 22 34 47.71-10.28 29.39-23.71 54.38-27.46 87.09-.54 4.78 3.14 12 7.95 12L416 205"/>
													<path d="M416 271l-80-2c-20-1.84-32-12.4-32-30h0c0-17.6 14-28.84 32-30l80-4c17.6 0 32 16.4 32 34v.17A32 32 0 01416 271zM448 336l-112-2c-18-.84-32-12.41-32-30h0c0-17.61 14-28.86 32-30l112-2a32.1 32.1 0 0132 32h0a32.1 32.1 0 01-32 32zM400 464l-64-3c-21-1.84-32-11.4-32-29h0c0-17.6 14.4-30 32-30l64-2a32.09 32.09 0 0132 32h0a32.09 32.09 0 01-32 32zM432 400l-96-2c-19-.84-32-12.4-32-30h0c0-17.6 13-28.84 32-30l96-2a32.09 32.09 0 0132 32h0a32.09 32.09 0 01-32 32z"/>
												</svg>
												<span class="margin-hor-2_5px">${article.art_good}</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center margin-hor-2_5px">
												<!-- https://ionic.io/ionicons -->
												<svg viewBox="0 0 512 512" style="width: 16px; height: 16px; fill: var(--theme-font); stroke: var(--theme-font); stroke-linecap: round; stroke-linejoin: round; stroke-width: 32px;">
													<path d="M192 53.84S208 48 256 48s74 16 96 32h64a64 64 0 0164 64v48a64 64 0 01-64 64h-30a32.34 32.34 0 00-27.37 15.4S350 290.19 324 335.22 248 448 240 464c-29 0-43-22-34-47.71 10.28-29.39 23.71-54.38 27.46-87.09.54-4.78-3.14-12-8-12L96 307"/>
													<path d="M96 241l80 2c20 1.84 32 12.4 32 30h0c0 17.6-14 28.84-32 30l-80 4c-17.6 0-32-16.4-32-34v-.17A32 32 0 0196 241zM64 176l112 2c18 .84 32 12.41 32 30h0c0 17.61-14 28.86-32 30l-112 2a32.1 32.1 0 01-32-32h0a32.1 32.1 0 0132-32zM112 48l64 3c21 1.84 32 11.4 32 29h0c0 17.6-14.4 30-32 30l-64 2a32.09 32.09 0 01-32-32h0a32.09 32.09 0 0132-32zM80 112l96 2c19 .84 32 12.4 32 30h0c0 17.6-13 28.84-32 30l-96 2a32.09 32.09 0 01-32-32h0a32.09 32.09 0 0132-32z"/>
												</svg>
												<span class="margin-hor-2_5px">${article.art_bad}</span>
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
					<form action="${pageContext.request.contextPath}/board/share/searchForm">
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
						<input type="text" name="keyWord" placeholder="검색어 입력" required="required">
						<button type="submit" class="adv-hover">검색</button>
					</form>
				</div>
				<!-- 페이징 -->
				<div class="board_paging" align="center" style="font-size: 18px; clear: both;">
					<button class="paging-block display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/share?currentPage=${page.startPage-page.pageBlock }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.startPage <= page.pageBlock ? 'disabled' : '' }>
						<svg viewBox="0 0 256 512">
							<path d="M 224 32 L 32 256 224 480"/>
						</svg>
					</button>
					<c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
						<button class="paging-page display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/share?currentPage=${i }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.currentPage == i ? 'disabled' : '' }>
							<span>${i }</span>
						</button>
					</c:forEach>
					<button class="paging-block display-flex justify-content-center align-items-center" onclick="location.href='${pageContext.request.contextPath }/board/share?currentPage=${page.endPage + 1 }&category=${category}${param.search == null ? '' : '&search='.concat(param.search) }${param.keyWord == null ? '' : '&keyWord='.concat(param.keyWord) }';" ${page.endPage == page.totalPage ? 'disabled' : '' }>
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
	</main>

</body>
</html>
<%@ include file="/WEB-INF/views/share/header.jsp" %>
<%@ include file="/WEB-INF/views/share/footer.jsp" %>