<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	$('.toggle').on('click', e => {
		let elem = $(e.target).closest('.toggle');
		let isTrue = elem.attr('data-toggle') == 'true';
		if (isTrue) elem.attr('data-toggle', 'false');
		else elem.attr('data-toggle', 'true');
	});
	$('.auth-select').on('change', e => {
		let elem = $(e.target).closest('.auth-select');
		let isTrue = elem.attr('data-toggle') == 'true';
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/updateProc',
			type: 'post',
			data: JSON.stringify({ 'change': 'auth', 'value': parseInt(elem.val()), 'mem_id': parseInt(elem.closest('.list-item').attr('data-id')) }),
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) return;
			}
		});
	});
	$('.ban-button').on('click', e => {
		let elem = $(e.target).closest('.ban-button');
		let isTrue = elem.attr('data-toggle') == 'true';
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/updateProc',
			type: 'post',
			data: JSON.stringify({ 'change': 'ban', 'mem_id': parseInt(elem.closest('.list-item').attr('data-id')) }),
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) return;
				if (isTrue) {
					elem.closest('.list-item').css('background-color', 'rgba(128, 128, 128, 0.25)');
					elem.text('해제');
				}
				else {
					elem.closest('.list-item').css('background-color', '');
					elem.text('차단');
				}
			}
		});
	});
	$('.delete-button').on('click', e => {
		let elem = $(e.target).closest('.delete-button');
		let isTrue = elem.attr('data-toggle') == 'true';
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/updateProc',
			type: 'post',
			data: JSON.stringify({ 'change': 'delete', 'mem_id': parseInt(elem.closest('.list-item').attr('data-id')) }),
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) return;
				if (isTrue) {
					elem.closest('.list-item').css('background-color', 'rgba(var(--warning-rgb), 0.25)');
					elem.closest('.list-item').find('.ban-button').attr('disabled', true);
					elem.closest('.list-item').find('.auth-select').attr('disabled', true);
					elem.closest('.list-item').find('.ban-button').css('opacity', 0.5);
					elem.text('복구');
				}
				else {
					if (elem.closest('.list-item').find('.ban-button').attr('data-toggle') == 'false') elem.closest('.list-item').css('background-color', '');
					else elem.closest('.list-item').css('background-color', 'rgba(128, 128, 128, 0.25)');
					elem.closest('.list-item').find('.ban-button').attr('disabled', false);
					elem.closest('.list-item').find('.auth-select').attr('disabled', false);
					elem.closest('.list-item').find('.ban-button').css('opacity', '');
					elem.text('삭제');
				}
			}
		});
	});
	$(() => {
		$('.admin-board-2').scroll(e => {
			$('.admin-board-2-head').scrollLeft($(e.target).scrollLeft());
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
<div class="admin-container" data-page="1">
	<div class="admin-main">
		<div class="admin-main-title-box">
			<h2 class="admin-main-title">회원 관리</h2>
		</div>
		<div>
			<div class="admin-board-2-head display-flex justify-content-flex-start align-items-center">
				<span class="font-size-14px span-ellipsis text-align-center width-50px">회원<br/>번호</span>
				<span class="font-size-14px span-ellipsis width-100px text-align-center">아이디</span>
				<span class="font-size-14px span-ellipsis width-100px text-align-center">닉네임</span>
				<span class="font-size-14px span-ellipsis text-align-center flex-grow-1">이메일</span>
				<span class="font-size-14px span-ellipsis width-75px text-align-center">차단 횟수</span>
				<span class="font-size-14px span-ellipsis width-75px text-align-center">삭제된 글</span>
				<span class="font-size-14px span-ellipsis width-75px text-align-center">삭제된 댓글</span>
				<div class="flex-shrink-0 display-flex justify-content-flex-end align-items-center">
					<span class="color-subtheme font-size-14px font-weight-bolder span-ellipsis width-75px text-align-center">권한 관리</span>
					<button type="button" class="subtheme-button margin-left-5px" style="padding: 2.5px 5px; background-color: transparent; color: var(--subtheme); cursor: default;" disabled>차단</button>
					<button type="button" class="warning-button margin-left-5px" style="padding: 2.5px 5px; background-color: transparent; color: var(--warning); cursor: default;" disabled>삭제</button>
				</div>
			</div>
			<div class="admin-board-2 display-flex flex-direction-column justify-content-flex-start align-items-stretch">
				<c:forEach var="member" items="${members }">
					<div class="list-item display-flex justify-content-flex-start align-items-center padding-5px padding-hor-0" data-id="${member.mem_id }" style="${member.isdelete == 1 ? 'background-color: rgba(var(--warning-rgb), 0.25);' : (member.mem_authority == 102 ? 'background-color: rgba(128, 128, 128, 0.25);' : '')  }">
						<div class="flex-grow-1 display-flex justify-content-flex-start align-items-center">
							<span class="font-size-14px span-ellipsis text-align-center width-50px">${member.mem_id }</span>
							<span class="font-size-14px span-ellipsis width-100px text-align-center">${member.mem_username }</span>
							<span class="font-size-14px span-ellipsis width-100px text-align-center">${member.mem_nickname }</span>
							<span class="font-size-14px span-ellipsis text-align-center flex-grow-1">${member.mem_email }</span>
							<span class="color-warning font-size-14px font-weight-bolder span-ellipsis width-75px text-align-center">${member.member_report_cnt }</span>
							<span class="color-warning font-size-14px font-weight-bolder span-ellipsis width-75px text-align-center">${member.article_report_cnt }</span>
							<span class="color-warning font-size-14px font-weight-bolder span-ellipsis width-75px text-align-center">${member.reply_report_cnt }</span>
						</div>
						<div class="flex-shrink-0 display-flex justify-content-flex-end align-items-center">
							<select class="auth-select font-size-12px width-75px" data-id="${member.mem_id }" ${memberInfo.mem_authority < member.mem_authority ? 'disabled' : '' }>
								<option class="font-size-12px" value="103" ${member.mem_authority == 103 ? 'selected' : '' }>일반 회원</option>
								<c:if test="${memberInfo.mem_authority == 109 }">
									<option class="font-size-12px" value="108" ${member.mem_authority == 108 ? 'selected' : '' }>매니저</option>
									<option class="font-size-12px" value="109" ${member.mem_authority == 109 ? 'selected' : '' }>관리자</option>
								</c:if>
							</select>
							<button type="button" data-toggle="${member.mem_authority == 102 ? 'true' : 'false' }" class="ban-button subtheme-button toggle margin-left-5px" style="padding: 2.5px 5px; ${memberInfo.mem_authority < member.mem_authority ? ' opacity: 0.25;' : (member.isdelete == 1 ? 'opacity: 0.5;' : '') }" ${memberInfo.mem_authority < member.mem_authority ? 'disabled' : (member.isdelete == 1 ? 'disabled' : '' )}>${member.mem_authority == 102 ? '해제' : '차단' }</button>
							<button type="button" data-toggle="${member.isdelete == 1 ? 'true' : 'false' }" class="delete-button warning-button toggle margin-left-5px" style="padding: 2.5px 5px; ${memberInfo.mem_authority < member.mem_authority ? ' opacity: 0.25;' : '' }" ${memberInfo.mem_authority < member.mem_authority ? 'disabled' : '' }>${member.isdelete == 1 ? '복구' : '삭제' }</button>
						</div>
					</div>
				</c:forEach>
			</div>
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