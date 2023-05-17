<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	function report_process(report_id, mem_id) {
		let submitType = '';
		//if (isset($_POST['member_action'])) submitType = 'MEMBER';
		if (document.activeElement.value == 'member_action') submitType = 'MEMBER';
		else if (document.activeElement.value == 'article_action') submitType = 'ARTICLE';
		else if (document.activeElement.value == 'reply_action') submitType = 'REPLY';
		else if (document.activeElement.value == 'reject_action') submitType = 'REJECT';
		else return false;
		if (!submitType) {
			alert('유효하지 않은 입력이 발생했습니다');
			return false;
		}
		let dataObj = { 'report_id': report_id, 'mem_id': mem_id, 'submit': submitType };
		let sendData = JSON.stringify(dataObj);
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/report/updateProc',
			type: 'post',
			data: sendData,
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 1) {
					if (submitType == 'MEMBER') alert('신고 승인 => 회원이 차단되었습니다');
					else if (submitType == 'ARTICLE') alert('신고 승인 => 게시글이 삭제되었습니다');
					else if (submitType == 'REPLY') alert('신고 승인 => 댓글이 삭제되었습니다');
					else alert('신고가 기각되었습니다');
				}
			}
		});
		
		return false;
	}
	$(() => {
		$('.toggle').load(e => $(e.target).attr('data-toggle', "false"));
		$('.toggle').on('click', e => {
			if (e.target.getAttribute('data-toggle') == "false") e.target.setAttribute('data-toggle', "true");
			else e.target.setAttribute('data-toggle', "false");
		});
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
		
		$('.admin-report-container').on('click', e => {
			let target = $(e.target).closest('.admin-report-container');
			let isToggled = target.attr('data-toggle') == 'true';
			let path = target.find('.admin-report-item').find('path');
			if (isToggled) {
				path.attr('d', 'M 32 224 L 256 32 480 224');
				target.find('.admin-report-info').css('height', 'max-content');
				//target.find('.admin-report-info').animate({'height': 'max-content'}, 250, $.bez([0.33, 1.0, 0.33, 1.0]));
				//target.find('.admin-report-info').css('height', '100px');
			} else {
				path.attr('d', 'M 32 32 L 256 224 480 32');
				//target.find('.admin-report-info').animate({'height': '0'}, 250, $.bez([0.33, 1.0, 0.33, 1.0]));
				target.find('.admin-report-info').css('height', '0');
			}
		});
		$('.admin-report-info').on('click', e => {
			e.stopPropagation();
			
		});
		$('.paging-button').on('click', e => {
			let ajaxUrl = '${pageContext.request.contextPath}/admin/${type}';
			$.ajax({
				url: ajaxUrl,
				type: 'post',
				data: JSON.stringify({ 'page' : parseInt($(e.target).attr('data-page')) }),
				dataType: 'html',
				contentType: 'application/json',
				success: data => {
					$('main').html(data);
					$('main').find('div.admin-container').attr('data-page', parseInt($(e.target).attr('data-page')));
				}
			});
		});
	});
</script>
<!-- <div class="admin-container" data-page="1"> -->
<div class="admin-container full-height" data-page="1">
	<div class="admin-main">
		<div class="admin-main-title-box">
			<h2 class="admin-main-title">신고 관리</h2>
		</div>
		<div class="admin-board-2-head display-flex justify-content-flex-start align-items-center">
			<span class="text-align-center width-50px">번호</span>
			<span class="color-subtheme font-weight-bolder text-align-center width-75px">항목</span>
			<span class="flex-grow-1">신고 내용</span>
			<span class="text-align-center width-100px" style="margin-right: 24px;">신고 시간</span>
		</div>
		<div class="admin-board-2">
			<c:forEach var="report" items="${reports }">
				<c:set var="report_item" value="${reportItems[report.report_id] }"/>
				<div class="admin-report-container toggle" data-id="${report.report_id }" data-toggle="false">
					<div class="admin-report-item">
						<span class="width-50px text-align-center">${report.report_id }</span>
						<span class="color-subtheme font-weight-bold width-75px text-align-center">
							<c:choose>
								<c:when test="${report.type == 'MEMBER' }">회원</c:when>
								<c:when test="${report.type == 'ARTICLE' }">게시글</c:when>
								<c:otherwise>댓글</c:otherwise>
							</c:choose>
						</span>
						<span class="flex-grow-1" style="width: calc(100% - 245px); overflow-x: hidden; text-overflow: ellipsis;">${report.report_content }</span>
						<span class="font-weight-bold font-size-10px width-100px text-align-center"><fmt:formatDate value="${report.report_date }" pattern="yyyy/MM/dd hh:mm:ss"/></span>
						<svg viewBox="0 0 512 256">
							<path d="M 32 32 L 256 224 480 32"/>
						</svg>
					</div>
					<div class="admin-report-info">
						<div class="admin-report-info-box">
							<div class="display-flex justify-content-flex-start align-items-center">
								<span class="color-subtheme font-size-18px font-weight-bolder margin-5px margin-hor-10px">신고자</span>
								<span class="font-weight-bolder">${report.mem_nickname }</span>
								<span class="font-weight-bolder font-size-14px" style="color: rgba(128, 128, 128, 0.5);">(${report.mem_username })</span>
							</div>
							<span class="color-subtheme font-size-18px font-weight-bolder margin-5px margin-hor-10px">신고 대상</span>
							<div class="admin-report-target-box display-flex justify-content-flex-start align-items-stretch padding-5px">
								<div class="admin-report-target-info display-flex flex-direction-column justify-content-flex-start align-items-stretch flex-grow-1 padding-custom2 background-color-theme border-radius-5px">
									<!-- 여기에 신고 대상 내용 간략히... -->
									<c:choose>
										<c:when test="${report.type == 'MEMBER' }">
											<div class="display-flex flex-direction-column justify-content-flex-start align-items-stretch">
												<div class="display-flex justify-content-space-between align-items-center">
													<div class="display-flex justify-content-flex-start align-items-center margin-5px margin-hor-0">
														<div class="width-50px height-50px overflow-hidden border-radius-50 background-color-theme" style="box-shadow: 0 0 2.5px var(--theme-font);">
															<img class="width-inherit height-inherit object-fit-cover" src="${pageContext.request.contextPath }/uploads/profile/${report_item.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';$(this).removeAttr('onerror')"/>
														</div>
														<div class="display-flex flex-direction-column justify-content-flex-start align-items-center">
															<div class="display-flex justify-content-flex-start align-items-center">
																<h3 class="color-theme-font margin-0 margin-left-10px">${report_item.mem_nickname }</h3>
																<span class="font-weight-bolder font-size-14px" style="color: rgba(128, 128, 128, 0.5);">(${report_item.mem_username })</span>
															</div>
															<span class="color-subtheme font-size-14px font-weight-bolder margin-left-10px align-self-flex-start">
																<c:choose>
																	<c:when test="${report_item.mem_authority == 101 }">미 인증 회원</c:when>
																	<c:when test="${report_item.mem_authority == 102 }">차단된 회원</c:when>
																	<c:when test="${report_item.mem_authority == 103 }">일반 회원</c:when>
																	<c:when test="${report_item.mem_authority == 108 }">매니저</c:when>
																	<c:when test="${report_item.mem_authority == 109 }">관리자</c:when>
																</c:choose>
															</span>
														</div>
													</div>
													<span class="font-size-14px font-weight-bolder" style="color: rgba(128, 128, 128, 0.5);"><fmt:formatDate value="${report_item.mem_regdate }" pattern="yyyy년 MM월 dd일"/> 가입</span>
												</div>
												<div class="display-flex justify-content-flex-start align-items-center margin-5px margin-hor-0">
													<hr class="width-25px margin-hor-5px"/>
													<span class="font-weight-bolder margin-hor-5px">신고된 이력</span>
													<hr class="flex-grow-1 margin-hor-5px"/>
												</div>
												<div class="display-flex justify-content-space-between align-items-center margin-5px">
													<div class="display-flex justify-content-flex-start align-items-center">
														<span class="color-warning font-weight-bolder text-align-center">차단 횟수</span>
														<span class="margin-left-5px font-weight-bolder">${report_item.member_report_cnt }</span>
													</div>
													<div class="display-flex justify-content-flex-start align-items-center">
														<span class="color-warning font-weight-bolder text-align-center">삭제된 게시글</span>
														<span class="margin-left-5px font-weight-bolder">${report_item.article_report_cnt }</span>
													</div>
													<div class="display-flex justify-content-flex-start align-items-center">
														<span class="color-warning font-weight-bolder text-align-center">삭제된 댓글</span>
														<span class="margin-left-5px font-weight-bolder">${report_item.reply_report_cnt }</span>
													</div>
												</div>
												<div class="display-flex justify-content-flex-start align-items-center">
													
												</div>
											</div>
										</c:when>
										<c:when test="${report.type == 'ARTICLE' }">
											<div class="display-flex justify-content-flex-start align-items-center">
												<span class="font-size-12px color-theme-font opacity-0_5">
													<c:choose>
														<c:when test="${report_item.brd_id >= 1000 && report_item.brd_id < 1100 }">함께해요</c:when>
														<c:when test="${report_item.brd_id >= 1100 && report_item.brd_id < 1200 }">같이사요</c:when>
														<c:when test="${report_item.brd_id >= 1200 && report_item.brd_id < 1300 }">나눔해요</c:when>
														<c:when test="${report_item.brd_id >= 1300 && report_item.brd_id < 1400 }">커뮤니티</c:when>
														<c:when test="${report_item.brd_id >= 1400 && report_item.brd_id < 1500 }">정보공유</c:when>
														<c:when test="${report_item.brd_id >= 1500 && report_item.brd_id < 1600 }">고객센터</c:when>
													</c:choose>
												</span>
												<span class="font-size-12px color-theme-font opacity-0_5" style="margin: 0 5px;">&gt;</span>
												<span class="font-size-14px color-subtheme font-weight-bolder">
													<c:choose>
														<c:when test="${report_item.brd_id == 1010 }">밥/카페</c:when>
														<c:when test="${report_item.brd_id == 1020 }">스포츠/운동</c:when>
														<c:when test="${report_item.brd_id == 1030 }">쇼핑</c:when>
														<c:when test="${report_item.brd_id == 1040 }">문화 생활</c:when>
														<c:when test="${report_item.brd_id == 1050 }">취미 생활</c:when>
														<c:when test="${report_item.brd_id == 1060 }">기타</c:when>
														<c:when test="${report_item.brd_id == 1110 }">식료품</c:when>
														<c:when test="${report_item.brd_id == 1120 }">의류/잡화</c:when>
														<c:when test="${report_item.brd_id == 1130 }">생활용품</c:when>
														<c:when test="${report_item.brd_id == 1140 }">해외배송</c:when>
														<c:when test="${report_item.brd_id == 1150 }">기타</c:when>
														<c:when test="${report_item.brd_id == 1210 }">식품</c:when>
														<c:when test="${report_item.brd_id == 1220 }">패션/잡화</c:when>
														<c:when test="${report_item.brd_id == 1230 }">가전/가구</c:when>
														<c:when test="${report_item.brd_id == 1240 }">기타</c:when>
														<c:when test="${report_item.brd_id == 1310 }">일상수다</c:when>
														<c:when test="${report_item.brd_id == 1320 }">자랑하기</c:when>
														<c:when test="${report_item.brd_id == 1330 }">홍보하기</c:when>
														<c:when test="${report_item.brd_id == 1340 }">질문/요청</c:when>
														<c:when test="${report_item.brd_id == 1410 }">동네정보</c:when>
														<c:when test="${report_item.brd_id == 1420 }">구매정보</c:when>
														<c:when test="${report_item.brd_id == 1430 }">신규점포</c:when>
														<c:when test="${report_item.brd_id == 1440 }">지역활동</c:when>
														<c:when test="${report_item.brd_id == 1510 }">공지</c:when>
														<c:when test="${report_item.brd_id == 1520 }">QnA</c:when>
														<c:when test="${report_item.brd_id == 1530 }">이벤트</c:when>
														<c:when test="${report_item.brd_id == 1540 }">문의/건의</c:when>
													</c:choose>
												</span>
											</div>
											<div class="display-flex justify-content-flex-start align-items-center">
												<span class="font-weight-bolder font-size-20px padding-5px padding-hor-0">${report_item.art_title }</span>
											</div>
											<div class="display-flex justify-content-space-between align-items-center padding-5px padding-hor-0" style="border-top: 2.5px solid var(--subtheme);">
												<div class="display-flex justify-content-flex-start align-items-center">
													<span class="font-weight-bolder">${report_item.mem_nickname }</span>
													<span class="font-weight-bolder font-size-14px" style="color: rgba(128, 128, 128, 0.5);">(${report_item.mem_username })</span>
												</div>
												<span class="font-size-14px" style="color: rgba(128, 128, 128, 0.5);"><fmt:formatDate value="${report_item.art_regdate }" pattern="yyyy-MM-dd hh:mm:ss"/></span>
											</div>
											<div class="display-flex justify-content-space-between align-items-center" style="border-top: 2.5px solid var(--subtheme);">
												<div class="display-flex justify-content-flex-start align-items-center">
													<c:forEach var="i" begin="1" end="5">
														<c:set var="tagName" value="art_tag${i }"/>
														<c:if test="${report_item[tagName] != null }">
															<span class="color-subtheme font-size-14px font-weight-bolder margin-left-2_5px">#${report_item[tagName] }</span>
														</c:if>
													</c:forEach>
												</div>
												
											</div>
											<div class="padding-custom1">
												${report_item.art_content }
											</div>
										</c:when>
										<c:otherwise>
											<div class="padding-custom1 background-color-theme border-radius-5px display-flex flex-direction-column justify-content-flex-start align-items-stretch">
												<div class="display-flex justify-content-space-between align-items-center">
													<div class="display-flex justify-content-flex-start align-items-center margin-10px margin-hor-0">
														<div class="width-50px height-50px border-radius-50 background-color-theme object-fit-cover" style="box-shadow: 0 0 2.5px var(--theme-font);">
															<img class="width-inherit height-inherit object-fit-cover" src="${pageContext.request.contextPath }/uploads/profile/${report_item.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg';$(this).removeAttr('onerror')"/>
														</div>
														<span class="font-size-16px font-weight-bolder margin-left-10px">${report_item.mem_nickname }</span>
														<span class="font-weight-bolder font-size-14px" style="color: rgba(128, 128, 128, 0.5);">(${report_item.mem_username })</span>
													</div>
													<span class="font-size-14px" style="color: rgba(128, 128, 128, 0.5);"><fmt:formatDate value="${report_item.rep_regdate }" pattern="yyyy-MM-dd hh:mm:ss"/></span>
												</div>
												<div class="padding-custom2">
													${report_item.rep_content }
												</div>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<span class="color-subtheme font-size-18px font-weight-bolder margin-5px margin-hor-10px">신고 사유</span>
							<form method="post" onsubmit="return report_process(${report.report_id}, ${report.mem_id});">
							<!-- <form method="post" onsubmit="return false;"> -->
								<div class="form-box display-flex justify-content-flex-start align-items-stretch padding-2_5px">
									<div class="flex-grow-1 display-flex flex-direction-column justify-content-flex-start align-items-stretch">
										<div class="margin-5px padding-custom2 margin-hor-2_5px border-radius-5px background-color-theme">
											${report.report_content }
										</div>
										<textarea class="margin-2_5px height-100px padding-custom2" style="border-radius: 5px; outline: none; border: 1px solid var(--subtheme);" name="report_reason" required></textarea>
									</div>
									<div class="display-flex flex-direction-column justify-content-flex-start align-items-stretch">
										<button class="warning-button width-50px margin-2_5px padding-custom1" type="submit" name="reject_action" value="reject_action">신고<br>기각</button>
										<button class="flex-grow-1 subtheme-button width-50px margin-2_5px padding-custom1" type="submit" name="member_action" value="member_action">회원<br>차단</button>
										<c:choose>
											<c:when test="${report.type == 'ARTICLE' }">
												<button class="flex-grow-1 theme-button width-50px margin-2_5px padding-custom1" type="submit" name="article_action" value="article_action">게시글<br>삭제</button>
											</c:when>
											<c:otherwise>
												<button class="flex-grow-1 theme-button width-50px margin-2_5px padding-custom1" type="submit" name="reply_action" value="reply_action">댓글<br>삭제</button>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="admin-board-2-page">
			<button class="paging-button paging-prev" type="button" data-page="${startPage - 1 }" ${startPage != 1 ? '' : 'disabled'}>
				<svg>
					<path d="M 11.5 1 L 4.5 8 11.5 14"/>
				</svg>
			</button>
			<c:forEach var="pg" begin="${startPage }" end="${endPage }">
				<button class="paging-button paging-page" type="button" data-page="${pg }" ${pg == page ? 'disabled' : '' }>
					<span>${pg }</span>
				</button>
			</c:forEach>
			<button class="paging-button paging-next" type="button" data-page="${endPage + 1 }" ${endPage != totalPage ? '' : 'disabled'}>
				<svg>
					<path d="M 4.5 1 L 11.5 8 4.5 14"/>
				</svg>
			</button>
		</div>
	</div>
</div>