<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	$('.delete-reply-button').on('click', e => {
		let target = $(e.target).closest('.delete-reply-button');
		let isDeleted = target.attr('data-toggle') == 'true';
		let art_id = parseInt($(e.target).closest('.delete-reply-button').attr('data-art-id'));
		let brd_id = parseInt($(e.target).closest('.delete-reply-button').attr('data-brd-id'));
		let rep_id = parseInt($(e.target).closest('.delete-reply-button').attr('data-id'));
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/reply/delete',
			type: 'post',
			data: JSON.stringify({ 'art_id': art_id, 'brd_id': brd_id, 'rep_id': rep_id }),
			dataType: 'json',
			contentType: 'application/json',
			success: data => {
				if (data.result == 0) return;
				target.find('span').text(isDeleted ? '삭제' : '복구');
				let box = target.closest('.reply-item');
				let isSub = target.attr('data-id') != target.attr('data-parent');
				if (isDeleted) {
					if (isSub) box.css('background-color', 'rgba(var(--subtheme-rgb), 0.125)');
					else box.css('background-color', 'var(--theme)');
					box.css('opacity', '');
					target.attr('data-toggle', 'false');
				}
				else {
					box.css('background-color', 'rgba(var(--warning-rgb), 0.125)');
					box.css('opacity', 0.5);
					target.attr('data-toggle', 'true');
				}
			}
		});
	});
	$(() => {
		
	});
</script>
<div class="admin-side-container">
	<div id="art_title" class="display-flex align-items-center" style="justify-content: space-between;">
		<span>${article.art_title }</span>
		<span class="font-weight-bold translucent-color" style="font-size: 14px;">
			<fmt:formatDate value="${article.art_regdate }" pattern="yyyy/MM/dd HH:mm:ss"/>
		</span>
	</div>
	<div id="art_info">
		<div class="display-flex justify-content-flex-start align-items-center">
			<div class="display-flex justify-content-center align-items-center width-50px height-50px border-radius-50 overflow-hidden margin-5px" style="box-shadow: 0 0 2.5px var(--theme-font);">
				<img class="width-inherit height-inherit object-fit-cover" src="${pageContext.request.contextPath }/uploads/profile/${article.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg'; $(this).removeAttr('onerror')"/>
			</div>
			<span class="font-size-14px font-weight-bolder margin-right-5px">${article.mem_nickname }</span>
			<span class="translucent-color font-size-14px font-weight-bolder">(${article.mem_username })</span>
		</div>
		<div id="art_misc" style="display: flex; justify-content: flex-end; align-items: center;">
			<span>
				조회수: ${article.art_read }
			</span>
		</div>
	</div>
	<div class="display-flex justify-content-flex-start align-items-center">
		<div id="art_tags">
			<c:forEach var="loop" begin="1" end="5">
				<c:set var="indexer" value="art_tag${loop }"/>
				<c:if test="${article[indexer] != null }">
					<span class="color-subtheme font-size-14px font-weight-bold margin-right-2_5px">#${article[indexer] }</span>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<div id="art_content">
		${article.art_content }
	</div>
	<div class="margin-10px margin-hor-0 display-flex justify-content-flex-start align-items-center" style="border: 2.5px solid var(--subtheme); border-width: 2.5px 0;">
		<h2 class="color-subtheme margin-0 padding-10px">댓글</h2>
		<span class="translucent-color font-weight-bolder">(${article.rep_count })</span>
	</div>
	<div class="display-flex flex-direction-column justify-content-flex-start align-items-stretch padding-5px">
		<c:forEach var="reply" items="${replies }">
			<div class="reply-item display-flex flex-direction-column justify-content-flex-start align-items-stretch padding-10px" style="border: 1px solid var(--subtheme); border-radius: 5px; margin: 5px; ${reply.rep_id != reply.rep_parent ? 'margin-left: 25px; background-color: rgba(var(--subtheme-rgb), 0.125);' : '' } ${reply.isdelete == 1 ? 'opacity: 0.5; background-color: rgba(var(--warning-rgb), 0.125);' : '' }">
				<div class="display-flex justify-content-space-between align-items-center">
					<div class="display-flex justify-content-flex-start align-items-center">
						<div class="display-flex justify-content-center align-items-center width-50px height-50px border-radius-50 overflow-hidden margin-5px" style="box-shadow: 0 0 2.5px var(--theme-font);">
							<img class="width-inherit height-inherit object-fit-cover" src="${pageContext.request.contextPath }/uploads/profile/${reply.mem_image }" onerror="this.onerror=null; this.src='${pageContext.request.contextPath }/image/abstract-user.svg'; $(this).removeAttr('onerror')"/>
						</div>
						<span class="font-weight-bolder margin-right-5px">${reply.mem_nickname }</span>
						<span class="translucent-color font-size-14px">(${reply.mem_username })</span>
					</div>
					<div>
						<span class="translucent-color font-size-14px font-weight-bolder margin-right-10px"><fmt:formatDate value="${reply.rep_regdate }" pattern="yy-MM-dd hh:mm:ss"/></span>
						<button type="button" class="delete-reply-button warning-button font-size-14px font-weight-bolder" style="padding: 5px 10px;" data-id="${reply.rep_id }" data-parent="${reply.rep_parent }" data-art-id="${reply.art_id }" data-brd-id="${reply.brd_id }" data-toggle="${reply.isdelete == 1 ? 'true' : 'false' }">
							<span>${reply.isdelete == 1 ? '복구' : '삭제' }</span>
						</button>
					</div>
				</div>
				<div class="reply-content padding-custom2">
					${reply.rep_content }
				</div>
			</div>
		</c:forEach>
	</div>
</div>