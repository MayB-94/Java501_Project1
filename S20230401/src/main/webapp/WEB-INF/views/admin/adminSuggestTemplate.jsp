<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	const viewNotice = (art_id) => {
		$.ajax({
			url: '${pageContext.request.contextPath}/admin/${type}/view',
			type: 'post',
			data: JSON.stringify({ 'art_id' : art_id }),
			dataType: 'html',
			contentType: 'application/json',
			success: data => {
				$('.admin-side-panel > .admin-side-panel-content').html(data);
			}
		});
	};
	$(() => {
		$('.admin-board-1 .admin-article-item').on('click', e => {
			viewNotice(parseInt($(e.target).attr('data-id')));
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
			<h2 class="admin-main-title">문의 및 건의글 관리</h2>
		</div>
		<div class="admin-board-1-head">
			<span>제목</span>
			<span>작성일</span>
		</div>
		<div class="admin-board-1">
			<c:forEach var="article" items="${articles }">
				<div class="admin-article-item" data-id="${article.art_id }" data-deleted="${article.isdelete == 1 ? 'true' : 'false' }" style="${article.isdelete == 1 ? 'opacity: 0.5;' : ''}">
					<span class="admin-article-title">
						${article.art_title }
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
				
			</div>
		</div>
		<div class="admin-side-panel-content">
			
		</div>
	</div>
</div>