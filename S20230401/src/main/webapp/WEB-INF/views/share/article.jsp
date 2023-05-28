<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<%@ include file="/WEB-INF/views/share/modal.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/initializer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/layout.js"></script>
<script type="text/javascript">
   
   // 그 전 페이지의 정보 삭제
   sessionStorage.clear();
   // 세션 스토리지에 pageContext 저장 URL용
   sessionStorage.setItem('contextPath', '${pageContext.request.contextPath}');
   sessionStorage.setItem('artId', '${article.art_id}');
   sessionStorage.setItem('brdId', '${article.brd_id}');
   sessionStorage.setItem('memId', '${article.mem_id}');
   sessionStorage.setItem('category', '${category}');
   sessionStorage.setItem('loginUser', '${memberInfo.mem_id}')

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/share/article.js"></script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/share/article.css">

</head>
<body>
	<main>
		<div class="view-content">
			<!-- 게시글 -->
			<div class="view-article">
				<!-- 게시글의 정보 -->
				<div class="article-header" class="padding-0">
					<input type="hidden" id="article_id"name="art_id"    value="${article.art_id}">
					<input type="hidden" id="brd_id"    name="brd_id"    value="${article.brd_id}">
					<input type="hidden" id="category"    name="category" value="${category}">
					<input type="hidden" id="mem_id"    name="mem_id"    value="${article.mem_id}">
					<input type="hidden" id="article_nickname"          value="${article.member.mem_nickname}">
					<input type="hidden" id="artReport_id"             value="${article.report_id}">
					<input type="hidden" id="login_member"       name="login_member"    value="${memberInfo.mem_id}">
					<input type="hidden" id="login_authority"    name="login_authority"    value="${memberInfo.mem_authority}">
					<!-- 카테고리 표시 -->
					<div class="article-category display-flex justify-content-space-between align-items-center">
						<span class="category-name">
							<a href="${pageContext.request.contextPath}/board/share?category=${article.brd_id - (article.brd_id % 100) }"><span style="color: rgba(var(--theme-font-rgb), 0.5);">나눔해요</span></a>
							<span class="margin-hor-2_5px" style="color: rgba(var(--theme-font-rgb), 0.5);">&gt;</span>
							<a class="font-weight-bolder" style="color: var(--subtheme)" href="${pageContext.request.contextPath}/board/share?category=${article.brd_id}">${article.brd_name}</a>
						</span>
						<span class="only-for-member display-flex justify-content-flex-end align-items-center">
							<!-- 글 수정 삭제 -->
							<c:if test="${article.mem_id == memberInfo.mem_id || memberInfo.mem_authority >= 108}">
								<button id="btns-artUpdate" class="adv-hover" onclick="art_Update()">수정</button>
								<button id="btns-artDelete" class="adv-hover" onclick="art_Delete()">삭제</button>
							</c:if>
							<button class="adv-hover" onclick="location.href='${pageContext.request.contextPath}/board/share?category=${category}';">목록</button>
						</span>
					</div>
				</div>
	         
				<!-- 글 제목 및 상태 -->
				<div class="article-title" style="border: 2px solid rgba(128, 128, 128, 0.5); border-width: 2px 0;">
					<div class="title-status">
						<c:if test="${article.status_name != null}"><button class="btn font-weight-bold">${article.status_name}</button></c:if>
					</div>
					<div class="title-subject">
						<span class="font-size-20px font-weight-bold">${article.art_title}</span>
					</div>
					<!-- 게시글 신고 -->
					<div class="modal-report">
						<c:if test="${not empty memberInfo}">
							<svg id="article-report" viewBox="0 0 512 512" width="30" height="30" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
						</c:if>
					</div>
				</div>
				
				<!-- 작성자 -->
				<div class="article-memberRow display-flex align-items-center" style="border-bottom: 1px solid rgba(128, 128, 128, 0.5);">
					<div class="user-profile-image-in-list">
						<img src="${pageContext.request.contextPath}/uploads/profile/${article.member.mem_image}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
					</div>
					<div class="article-member" style="display: flex; align-items: center;">
						<div class="modal-report display-flex justify-content-flex-start align-items-center padding-0">
						<span id="member_nickname" class="font-weight-bolder margin-right-10px">${article.member.mem_nickname}</span>
						<span id="member_username" style="color: rgba(var(--theme-font-rgb), 0.5);">${article.member.mem_username}</span>
						<c:if test="${not empty memberInfo}">
							<svg id="member-report" viewBox="0 0 512 512" width="24" height="24" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
							<input type="hidden" id="member_id" value="${article.member.mem_id}">
							<input type="hidden" id="memReport_id" value="${article.member.report_id}">
						</c:if>
					   </div>
					</div>
					<div class="article-memberInfo" style="font-size: 14px; flex-grow: 1; text-align: right;">
						<span>추천 ${article.art_good}</span>
						<span>비추천 ${article.art_bad}</span>
						<span>댓글 ${article.rep_cnt == null ? 0:article.rep_cnt}</span>
						<span>조회수 ${article.art_read}</span>
						<span>작성일 <fmt:formatDate value="${article.art_regdate}" pattern="yy.MM.dd HH:mm"/></span>
					</div>
				</div>
				
				<!-- 태그 출력 및 검색 -->
				<div class="article-info">
					<div class="view-tag padding-0">
						<form action="${pageContext.request.contextPath}/board/share/searchForm">
							<input type="hidden" name="category" value="${category}">
							<input type="hidden" name="brd_id" value="${brd_id}">
							<input type="hidden" name="search" value="articleTag">
							<c:forEach begin="1" end="5" varStatus="status">
								<c:set var="art_tag" value="art_tag${status.index}"/>
									<c:if test="${article[art_tag] != null}">
										<button class="btns-tag" name="keyWord" value="${article[art_tag]}">${article[art_tag]}</button>
									</c:if>
							</c:forEach>
						</form>
					</div>
					
					<!-- 본문 내용 -->
					<div class="article_content" style="padding: 20px 10px;">
						${article.art_content }
					</div>
					
					<!-- 거래 관련 내용 -->
					<c:if test="${not empty article.trade.trd_id}">
						<div class="article-trade">
							<div class="share-trdHeader display-flex justify-content-space-between align-items-center">
								<span class="color-subtheme font-size-20px font-weight-bolder">${article.trade.trd_cost > 0 ? article.trade.trd_cost : '무료나눔'}</span>
								<div class="display-flex justify-content-flex-end align-items-center">
									<button class="btn" type="button">개시일 : <fmt:formatDate value="${article.art_regdate}" pattern="yy-MM-dd"/></button>
									<span class="color-theme-font font-weight-bold margin-hor-2_5px" style="color: rgba(var(--theme-font-rgb), 0.5);">~</span>
									<button>마감일 : <fmt:formatDate value="${article.trade.trd_enddate}" pattern="yy-MM-dd"/></button>
								</div>
							</div>
							<div class="share-trdContent display-flex flex-direction-column justify-content-flex-start" style="border-bottom: 1px solid rgba(128, 128, 128, 0.5);">
								<div class="display-flex justify-content-space-between align-items-center">
									<span><span class="color-subtheme font-weight-bolder margin-right-5px">지역제한</span>${article.trade.region.reg_name == null ? '제한없음' : article.trade.region.reg_name}</span>
									<span><span class="color-subtheme font-weight-bolder">상세장소 </span>${article.trade.trd_loc}</span>
								</div>
								<div class="display-flex justify-content-space-between align-items-center">
									<span><span class="color-subtheme font-weight-bolder margin-right-5px">최대 인원</span>${article.trade.trd_max}명</span>
									<span><span class="color-subtheme font-weight-bolder margin-right-5px">최소 나이</span>${article.trade.trd_minage>0? article.trade.trd_minage:'제한없음' }</span>
									<span><span class="color-subtheme font-weight-bolder margin-right-5px">최대 나이</span>${article.trade.trd_maxage>0? article.trade.trd_maxage:'제한없음'}</span>
									<span><span class="color-subtheme font-weight-bolder margin-right-5px">성별 제한</span>${article.trade.trd_gender==201? '남자만':article.trade.trd_gender==202? '여자만':'제한없음'}</span>
								</div>
							</div>
							
							<!-- 참가중인 회원 목록 -->
							<div class="share-userList">
								<h2>거래 참가자 명단</h2><hr />
								<c:forEach var="join" items="${joinList}">
									<div class="userList-memberInfo">
										<div class="user-profile-image-in-list">
											<img src="${pageContext.request.contextPath}/uploads/profile/${join.member.mem_image}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
										</div>
										<div class="userList-details">
											<div class="display-flex justify-content-flex-start align-items-center padding-0">
												<h3 class="font-weight-bolder margin-0">${join.member.mem_nickname}</h3>
												<span class="margin-left-10px" style="color: rgba(var(--theme-font-rgb), 0.5);"><span class="font-weight-bolder margin-right-5px" style="color: rgba(var(--subtheme-rgb), 0.5);">참여일</span><fmt:formatDate value="${join.join_date}" pattern="yy-MM-dd HH:mm:ss"/></span>
											</div>
											<div class="modal-report display-flex justify-content-flex-start align-items-center padding-0">
												<span id="member_nickname" style="color: rgba(var(--theme-font-rgb), 0.5);">${join.member.mem_username}</span>
												<c:if test="${not empty memberInfo}">
													<svg id="member-report" viewBox="0 0 512 512" width="24" height="24" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
												</c:if>
												<input type="hidden" id="member_id" name="mem_id" value="${join.mem_id}">
												<input type="hidden" id="memReport_id" value="${join.member.report_id}">
											</div>
										</div>
										<div class="userList-btns">
											<c:choose>
												<c:when test="${article.mem_id == memberInfo.mem_id || memberInfo.mem_authority >= 108}">
													<button class="btns-action adv-hover" id="btns-drop">추방</button>
												</c:when>
												<c:when test="${join.mem_id == memberInfo.mem_id || memberInfo.mem_authority >= 108}">
													<button class="btns-action adv-hover" id="btns-joinCancel">취소</button>
												</c:when>
											</c:choose>
										</div>
									</div>
									<hr />
								</c:forEach>
								<c:if test="${empty joinList}"><p style="text-align: center;">아직 참가자가 없어요</p></c:if>
							</div>
							
							<!-- 거래 대기열 회원 목록 -->
							<div class="share-userList">
								<h2>거래 신청자 명단</h2><hr />
								<c:forEach var="waiting" items="${waitingList}" varStatus="status">
									<div class="userList-memberInfo">
										<div class="user-profile-image-in-list">
											<img src="${pageContext.request.contextPath}/uploads/profile/${waiting.member.mem_image}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';">
										</div>
										<div class="userList-details">
											<div class="display-flex justify-content-flex-start align-items-center padding-0">
												<h3 class="font-weight-bolder margin-0">${waiting.member.mem_nickname}</h3>
												<span class="margin-left-10px" style="color: rgba(var(--theme-font-rgb), 0.5);"><span class="font-weight-bolder margin-right-5px" style="color: rgba(var(--subtheme-rgb), 0.5);">신청일</span><fmt:formatDate value="${waiting.wait_date}" pattern="yy-MM-dd HH:mm:ss"/></span>
											</div>
											<div class="modal-report display-flex justify-content-flex-start align-items-center padding-0">
												<span id="member_nickname" style="color: rgba(var(--theme-font-rgb), 0.5);">${waiting.member.mem_username}</span>
												<c:if test="${not empty memberInfo}">
													<svg id="member-report" viewBox="0 0 512 512" width="24" height="24" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
												</c:if>
												<input type="hidden" id="member_id" name="mem_id" value="${waiting.mem_id}">
												<input type="hidden" id="memReport_id" value="${waiting.member.report_id}">
											</div>
										</div>
										<div class="userList-btns">
											<c:choose>
												<c:when test="${article.mem_id == memberInfo.mem_id || memberInfo.mem_authority >= 108}">
													<c:if test="${article.trade.trd_max ne joinList.size()}">
														<button class="btns-action" id="btns-accept">승인</button>
													</c:if>
													<button class="btns-action" id="btns-refuse">거절</button>
												</c:when>
												<c:when test="${waiting.mem_id == memberInfo.mem_id || memberInfo.mem_authority >= 108}">
													<button class="btns-action" id="btns-waitCancel">취소</button>
												</c:when>
											</c:choose>
										</div>
									</div><hr />
								</c:forEach>
								<c:if test="${empty waitingList && empty joinList}"><p style="text-align: center;">아직 신청자가 없어요</p></c:if>
							</div>
							
							<!-- 거래 신청, 찜 -->
							<div class="share-btns">
								<c:if test="${memberInfo != null}">
								<!-- 찜 버튼 -->
									<div class="btns-favorite">
										<c:choose>
											<c:when test="${userFavorite > 0}">
												<button class="btns-action" id="btns-favoriteDel">찜 취소</button>
											</c:when>
											<c:when test="${userFavorite == 0}">
												<button class="btns-action" id="btns-favorite">찜</button>
											</c:when>
										</c:choose>
									</div>
								<!-- 거래 버튼 -->
									<div class="btns-trade">
										<c:choose>
											<c:when test="${userWaiting == 0 && userJoin == 0 && joinList.size() < article.trade.trd_max && article.trade.trd_status == 401}">
												<button class="btns-action" id="btns-apply">신청</button>
											</c:when>
											<c:when test="${joinList.size() == article.trade.trd_max || article.trade.trd_status > 401}">
												<button class="btns-action" id="btns-end">모집 완료</button>
											</c:when>
										</c:choose>
									</div>
								</c:if>
								<c:if test="${memberInfo == null}"><div class="login display-flex justify-content-center align-items-center"><a href="${pageContext.request.contextPath}/login"><h3 class="color-subtheme">로그인</h3></a><span> 후 이용 가능합니다</span></div></c:if>
							</div>
						</div>
					</c:if>
				</div>
				
				<div class="article-body" style="border-bottom: 1px solid rgba(128, 128, 128, 0.5);">
					<!-- 추천 비추천 -->
					<div class="share-btns" id="btns-vote">
						<button class="btns-good" id="btns-good">추천 <span>${article.art_good}</span></button>
						<button class="btns-good" id="btns-goodcancel" style="display: none; background-color: #0193F8;">추천 <span>${article.art_good}</span></button>
						<button class="btns-bad" id="btns-bad">비추천 <span>${article.art_bad}</span></button>
						<button class="btns-bad" id="btns-badcancel" style="display: none; background-color: red;">비추천 <span>${article.art_bad}</span></button>
					</div>
				</div>
				
				<!-- 댓글 부분 -->      
				<div class="reply-list padding-hor-0">
					<div class="list-toggle display-flex justify-content-flex-start align-items-center padding-hor-0" style="padding-bottom: 10px; border-bottom: 1px solid rgba(128, 128, 128, 0.5);">
						<c:choose>
							<c:when test="${article.rep_cnt > 0}">
								<span class="font-size-24px font-weight-bolder color-subtheme">댓글</span>
								<span class="font-size-14px font-weight-bold color-theme-font margin-left-10px" style="color: rgba(var(--theme-font-rgb), 0.5);">(${article.rep_cnt})</span>
								<button id="btns-show" style="display: none;">▶ 펼치기</button>
								<button id="btns-hide">▼ 접기</button>
							</c:when>
							<c:otherwise>
								<p style="text-align: center; flex-grow: 1;">이 글은 아직 댓글이 없어요<br> 첫 댓글을 남겨주세요</p>
							</c:otherwise>
						</c:choose>
					</div>
					
					<!-- 댓글 리스트 -->
					<c:forEach var="reply" items="${replyList}" varStatus="status">
						<div class="reply-detail display-flex flex-direction-column justify-content-flex-start align-items-stretch">
							<input type="hidden" id="reply_id" name="rep_id" value="${reply.rep_id}">
							<input type="hidden" id="reply_nickname" value="${reply.member.mem_nickname}">
							<input type="hidden" id="repReport_id"    value="${reply.report_id}">
							<div class="reply-view display-flex flex-direction-column justify-content-flex-start align-items-stretch" style="${(reply.rep_id != reply.rep_parent) ? 'margin-left: 32px; background-color: rgba(var(--subtheme-rgb), 0.125);' : ''}">
								<div class="reply-header display-flex justify-content-flex-start align-items-center">
								<div class="user-profile-image-in-list">
									<img src="${pageContext.request.contextPath}/uploads/profile/${reply.member.mem_image}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg'; $(this).removeAttr('onerror');">
								</div>
								<div class="reply-header-info modal-report display-flex justify-content-flex-start align-items-center">
									<span id="member_nickname" class="font-weight-bolder">${reply.member.mem_nickname}</span>
									<c:if test="${not empty memberInfo}">
										<svg id="member-report" class="margin-hor-5px" viewBox="0 0 512 512" width="24" height="24" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
										<input type="hidden" id="member_id" value="${reply.member.mem_id}">
										<input type="hidden" id="memReport_id" value="${reply.member.report_id}">
									</c:if>
									<span class="color-theme-font font-size-14px" style="color: rgba(var(--theme-font-rgb), 0.5);">(<fmt:formatDate value="${reply.rep_regdate}" pattern="yy-MM-dd :HH:mm:ss"/>)</span>
								</div>
								<div class="flex-grow-1 display-flex justify-content-flex-end align-items-center">
									<c:if test="${memberInfo != null }">
										<button class="btns-repWrite font-weight-bolder">댓글 달기</button>
									</c:if>
									<c:if test="${reply.mem_id == memberInfo.mem_id || memberInfo.mem_authority > 108}">
										<button class="btns-repUpdate font-weight-bolder">수정</button>
										<button class="btns-repComplete font-weight-bolder" style="display: none;" onclick="rep_Update(${status.index})">완료</button>
										<button class="btns-delete font-weight-bolder" onclick="rep_delete(${article.brd_id},${article.art_id},${reply.rep_id})">삭제</button>
										<button class="btns-cancel font-weight-bolder" style="display: none;">취소</button>
									</c:if>
									<div class="modal-report padding-0" style="width: 24px; height: 24px;">
										<c:if test="${not empty memberInfo}">
											<svg id="reply-report" viewBox="0 0 512 512" width="24" height="24" style="fill: none; stroke: var(--warning); stroke-width: 32px; stroke-linecap: round; stroke-linejoin: round; cursor: pointer;"><path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z"/><path d="M250.26 166.05L256 288l5.73-121.95a5.74 5.74 0 00-5.79-6h0a5.74 5.74 0 00-5.68 6z"/><path d="M256 367.91a20 20 0 1120-20 20 20 0 01-20 20z" style="stroke: none; fill: var(--warning);"/></svg>
										</c:if>
									</div>
								</div>
							   </div>
							   <!-- 댓글 본문 -->
							   <div class="reply-inner padding-0" style="flex-grow: 1">
									<!-- 댓글 수정 -->
									<div class="reply-content padding-0">
										<textarea class="rep-content full-width full-height" id="rep-content${status.index}" disabled="disabled" autofocus="autofocus">${reply.rep_content}</textarea>
									</div>
							   </div>
							</div>
							
							<!-- 댓글의 댓글 작성 -->
							<div class="reply-replyWrite" style="display: none; margin-left: 10%">
								<form action="${pageContext.request.contextPath}/board/share/replyForm" method="post">
									<div class="form-box display-flex flex-direction-column justify-content-flex-start align-items-stretch" style="border: 2px solid var(--subtheme); border-radius: 5px;">
										<input type="hidden" id="brd_id${status.index}" name="brd_id"    value="${article.brd_id}">
										<input type="hidden" id="art_id${status.index}" name="art_id"    value="${article.art_id}">
										<input type="hidden" id="rep_id${status.index}" name="rep_id"    value="${reply.rep_id}">
										<input type="hidden" name="category"    value="${category}">
										<input type="hidden" name="rep_parent"value="${reply.rep_parent}">
										<input type="hidden" name="rep_step"   value="${reply.rep_step}">
										<div class="display-flex flex-direction-column justify-content-flex-start align-items-stretch">
										<div class="display-flex justify-content-space-between align-items-center" style="border-bottom: 1px solid rgba(var(--subtheme-rgb), 0.5);">
											<span class="font-size-18px font-weight-bolder">${memberInfo.mem_nickname }</span>
											<input class="reply-primitive-submit" type="submit" value="등록">
										</div>
										<textarea class="reply-primitive-write" style="margin-top: 10px;" placeholder="댓글을 입력하세요" name="rep_content"></textarea>
										</div>
									</div>
								</form>
							</div>
						</div>
					</c:forEach>
					
					<!-- 새로운 댓글 작성 -->
					<div class="reply-write">
						<c:choose>
							<c:when test="${memberInfo != null}">
								<form action="${pageContext.request.contextPath}/board/share/replyForm" method="post">
									<div class="form-box display-flex flex-direction-column justify-content-flex-start align-items-stretch" style="border: 2px solid var(--subtheme); border-radius: 5px;">
										<span><input type="hidden" name="brd_id"    value="${article.brd_id}"></span>
										<span><input type="hidden" name="art_id"    value="${article.art_id}"></span>
										<span><input type="hidden" name="category"    value="${category}"></span>
										<div class="display-flex flex-direction-column justify-content-flex-start align-items-stretch">
											<div class="display-flex justify-content-space-between align-items-center" style="border-bottom: 1px solid rgba(var(--subtheme-rgb), 0.5);">
												<span class="font-size-18px font-weight-bolder">${memberInfo.mem_nickname }</span>
												<input class="reply-primitive-submit" type="submit" value="등록">
											</div>
											<textarea class="reply-primitive-write" style="margin-top: 10px;" placeholder="댓글을 입력하세요" name="rep_content" required="required"></textarea>
										</div>
									</div>
								</form>
							</c:when>
							<c:otherwise>
								<div class="reply-login padding-10px display-flex flex-direction-column justify-content-center align-items-center" style="border-radius: 5px; background-color: rgba(var(--subtheme-rgb), 0.25);">
									<span>본 게시물에 댓글을 작성하실 권한이 없습니다. 로그인 하신 후 댓글을 다실 수 있습니다.</span>
									<span>ShareGo <a href="${pageContext.request.contextPath }/login"><span class="color-subtheme font-weight-bolder">로그인</span></a></span>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		

	</main>


</body>
</html>
<%@ include file="/WEB-INF/views/share/header.jsp" %>
<%@ include file="/WEB-INF/views/share/footer.jsp" %>