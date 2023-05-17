<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<script type="text/javascript">
	$(() => {
		
	});
</script>
<div class="admin-side-container">
	<div id="art_title">
		<span>${article.art_title }</span>
	</div>
	<div id="art_info">
		<div id="art_tags">
			<c:forEach var="loop" begin="1" end="5">
				<c:set var="indexer" value="art_tag${loop }"/>
				<c:if test="${article[indexer] != null }">
					<span>#${article[indexer] }</span>
				</c:if>
			</c:forEach>
		</div>
		<div id="art_misc" style="display: flex; justify-content: flex-end; align-items: center;">
			<span>
				작성일자:
				<fmt:formatDate value="${article.art_regdate }" pattern="yyyy/MM/dd HH:mm:ss"/>
			</span>
			<span>
				조회수: ${article.art_read }
			</span>
		</div>
	</div>
	<div id="art_content">
		${article.art_content }
	</div>
</div>