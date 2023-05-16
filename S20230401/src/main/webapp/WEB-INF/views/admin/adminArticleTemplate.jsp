<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	const viewNotice = (art_id, brd_id) => {
		$('.admin-side-panel-right').find('.admin-side-panel-view').css('display', 'flex');
		let isDeleted = $('.admin-article-item[data-id="' + art_id + '"][data-board="' + brd_id + '"]').attr('data-deleted') == 'true';
		if (isDeleted) {
			$('.admin-side-panel-view').find('.side-panel-button-delete').hide();
			$('.admin-side-panel-view').find('.side-panel-button-restore').show();
		} else {
			$('.admin-side-panel-view').find('.side-panel-button-delete').show();
			$('.admin-side-panel-view').find('.side-panel-button-restore').hide();
		}
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/view',
			type: 'post',
			data: JSON.stringify({ 'art_id' : art_id, 'brd_id' : brd_id }),
			dataType: 'html',
			contentType: 'application/json',
			success: data => {
				$('.admin-side-panel > .admin-side-panel-content').html(data);
				$('.admin-side-panel-view')
					.find('.side-panel-button-delete').attr({'data-id': art_id, 'data-board': brd_id})
					.end().find('.side-panel-button-restore').attr({'data-id': art_id, 'data-board': brd_id});
			}
		});
	};
	$(() => {
		$('.admin-board-1 .admin-article-item').on('click', e => {
			viewNotice(parseInt($(e.target).attr('data-id')), parseInt($(e.target).attr('data-board')));
			if ($('.admin-side-panel').css('display') != 'none') return;
			$('.admin-side-panel').css({ 'display' : 'flex' });
			$('.admin-side-panel').animate({ 'width' : '75%' }, 250);
		});
		$('.admin-side-panel-close').on('click', e => {
			$('.admin-side-panel').animate({ 'width' : '0' }, 250, () => {
				$('.admin-side-panel').css({ 'display' : 'none' });
				$('.admin-side-panel > .admin-side-panel-content').empty();
			});
		});
		$('.side-panel-button-delete').on('click', e => {
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/${type}/delete',
				type: 'post',
				data: JSON.stringify({ 'art_id' : parseInt($(e.target).attr('data-id')), 'brd_id' : parseInt($(e.target).attr('data-board')) }),
				dataType: 'json',
				contentType: 'application/json',
				success: data => {
					if (data.result < 1) return;
					let currentPageButton = $('.admin-board-1-page').find('.paging-page:disabled');
					let ajaxUrl = '${pageContext.request.contextPath}/admin/${type}';
					$.ajax({
						url: ajaxUrl,
						type: 'post',
						data: JSON.stringify({ 'page' : parseInt(currentPageButton.attr('data-page')) }),
						dataType: 'html',
						contentType: 'application/json',
						success: data => {
							$('main').html(data);
						}
					});
					$('.admin-side-panel').animate({ 'width' : '0' }, 250, () => {
						$('.admin-side-panel').css({ 'display' : 'none' });
						$('.admin-side-panel > .admin-side-panel-content').empty();
					});
				}
			});
		});
		$('.side-panel-button-restore').on('click', e => {
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/${type}/restore',
				type: 'post',
				data: JSON.stringify({ 'art_id' : parseInt($(e.target).attr('data-id')), 'brd_id' : parseInt($(e.target).attr('data-board')) }),
				dataType: 'json',
				contentType: 'application/json',
				success: data => {
					if (data.result < 1) return;
					let currentPageButton = $('.admin-board-1-page').find('.paging-page:disabled');
					let ajaxUrl = '${pageContext.request.contextPath}/admin/${type}';
					$.ajax({
						url: ajaxUrl,
						type: 'post',
						data: JSON.stringify({ 'page' : parseInt(currentPageButton.attr('data-page')) }),
						dataType: 'html',
						contentType: 'application/json',
						success: data => {
							$('main').html(data);
						}
					});
					$('.admin-side-panel-right').find('.admin-side-panel-view').css('display', 'flex');
					$('.admin-side-panel-right').find('.admin-side-panel-modify').css('display', 'none');
					$('.admin-side-panel').animate({ 'width' : '0' }, 250, () => {
						$('.admin-side-panel').css({ 'display' : 'none' });
						$('.admin-side-panel > .admin-side-panel-content').empty();
					});
				}
			});
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
				}
			});
		});
	});
</script>
<div class="admin-container" data-page="1">
	<div class="admin-main">
		<div class="admin-main-title-box">
			<h2 class="admin-main-title">게시글 관리</h2>
		</div>
		<div class="admin-board-1-head">
			<span>제목</span>
			<span>작성일</span>
		</div>
		<div class="admin-board-1">
			<c:forEach var="article" items="${articles }">
				<div class="admin-article-item" data-id="${article.art_id }" data-board="${article.brd_id }" data-deleted="${article.isdelete == 1 ? 'true' : 'false' }" style="${article.isdelete == 1 ? 'opacity: 0.5;' : ''}">
					<span class="admin-article-title display-flex justify-content-flex-start align-items-center">
						<c:if test="${article.isdelete == 1 }">
							<span class="isDelete-tag">
								삭제됨
							</span>
						</c:if>
						<span class="color-subtheme font-size-12px font-weight-bolder margin-right-5px" style="border: 2px solid var(--subtheme); border-radius: 5px; padding: 2.5px 5px;">
							${categories[article.brd_id] }
						</span>
						<span class="span-ellipsis">${article.art_title }</span>
					</span>
					<span class="admin-article-regdate">
						<fmt:formatDate value="${article.art_regdate }" pattern="yyyy-MM-dd hh:mm:ss"/>
					</span>
				</div>
			</c:forEach>
		</div>
		<div class="admin-board-1-page">
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
		<div class="admin-board-1-foot">
			
		</div>
	</div>
	<div class="admin-side-panel">
		<div class="admin-side-panel-header" style="height: 32px; background-color: var(--subtheme);">
			<button class="admin-side-panel-close adv-hover" type="button">
				<svg>
					<path d="M 1 1 L 23 23 M 1 23 L 23 1"/>
				</svg>
			</button>
			<div class="admin-side-panel-right">
				<div class="admin-side-panel-view">
					<button class="admin-side-panel-button side-panel-button-delete adv-hover" type="button">
						<span>삭제</span>
					</button>
					<button class="admin-side-panel-button side-panel-button-restore adv-hover" type="button">
						<span>복구</span>
					</button>
				</div>
			</div>
		</div>
		<div class="admin-side-panel-content">
			
		</div>
	</div>
</div>