<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/share/writeForm.css">
<script type="text/javascript">
	
	// 첫번째 select박스 선택시 실행
	function firstSelect(){
		let locSelect = $('#location-firstSelect').val();
		console.log(locSelect);
		
		$.ajax({
			url:'${pageContext.request.contextPath}/board/share/selectRegion',
			data:{'reg_id':locSelect},
			success: function(data){
				console.log(data);
				let reg_id = $('#reg_id').val();
				let options = '<option value="">선택</option>';
				for(let trade of data){
					options += `<option value="\${trade.reg_id}" \${trade.reg_id == reg_id? 'selected="selected"':''}>\${trade.reg_name}</option>`;
				}
				// 지역 소분류의 옵션을 추가하고, name 속성 부여
				$('#location-secondSelect').html(options);
			}
		});
	}
	
	// 두번째 select박스 선택시
	function secondSelect(){
		// 지역 대분류의  name 속성 제거 소분류 name 추가
		$('#location-firstSelect').removeAttr('name');
		$('#location-secondSelect').attr('name', 'trade.reg_id');
	}
	// checkbox 이벤트
	$(document).ready(()=>{
		$('#btns-checkbox').change(()=>{
			if($('#btns-checkbox').is(':checked')){
				$('#art_isnotice').val('1');
			}else{
				$('#art_isnotice').val('0');
			}
			console.info($('#art_isnotice').val());
		});
	});
	
	// 페이지 로딩 후 지역 표시 
	// 페이지 로딩 후 지역 표시
	// 수정 요망
 	$(()=>{
		firstSelect();
		let locSelect = $('#location-secondSelect').attr('selected', 'selected');
		console.log($('#location-secondSelect').val());
	});
</script>
</head>
<body>
	<div class="container">

		<h1>글 수정</h1>

		<div>
			<form action="${pageContext.request.contextPath}/board/community/bjUpdate" method="post">
				<input type="hidden" 	name="art_id" 			value="${article.art_id}">
				<input type="hidden" 	name="category" 		value="${category}">
				<input type="hidden" 	name="brd_id" 			value="${article.brd_id}">
				<input type="hidden" 	name="trade.trd_id" 	value="${article.trade.trd_id}">
			<!-- 임시 기본값 저장 -->
				<input type="hidden"	id="reg_id"				value="${article.trade.reg_id}">
				<input type="hidden" 	name="trade.trd_cost" 	value="0">
				
				
				<div class="form-group" id="trade-change">
					<section class="category">
						<label for="category">카테고리</label>
						<select id="category" name="brd_id">
							<c:forEach var="categoryList" items="${categoryList}">
								<c:if test="${categoryList.comm_id % 100 > 0}">
									<option value="${categoryList.comm_id}" ${categoryList.comm_id == article.brd_id? 'selected="selected"':'' }>${categoryList.comm_value}</option>
								</c:if>
							</c:forEach>
						</select>
					</section>
					<%-- <section class="status">
						<label for="trade-status">거래 상태</label>
						<select name="trade.trd_status" id="trade-status">
							<c:forEach var="status" items="${statusList}">
								<c:if test="${status.comm_id % 100 > 0}">
									<option value="${status.comm_id}" ${status.comm_id == article.trade.trd_status? 'selected="selected"':''}>${status.comm_value}</option>
								</c:if>
							</c:forEach>
						</select>
					</section> --%>
				</div>

				<div class="form-group">
					<label for="article-title">제목</label>
					<input type="text" id="article-title" name="art_title" required="required" value="${article.art_title}">
				</div>
				<div class="form-group">
					<label for="article-content">내용</label>
					<textarea id="article-content" name="art_content" required="required">${article.art_content}</textarea>
				</div>

				<div class="form-group">
					<label for="tag">태그</label>
					<input type="text" 	name="art_tag1" value="${article.art_tag1}">
					<input type="text" 	name="art_tag2" value="${article.art_tag2}">
					<input type="text" 	name="art_tag3" value="${article.art_tag3}">
					<input type="text" 	name="art_tag4" value="${article.art_tag4}">
					<input type="text" 	name="art_tag5" value="${article.art_tag5}">
				</div>
				
				<!-- <div class="form-group" style="display: flex;"> -->
					<!-- 대분류 -->
					<%-- <div class="form-location">
						<label for="location-firstSelect">지역제한</label>
						<select id="location-firstSelect" name="trade.reg_id" onchange="firstSelect()">
							<option value="">지역 선택</option>
							<c:forEach var="region" items="${regionList}">
								<c:if test="${region.reg_parent eq null}">
									<option id="region-parent" value="${region.reg_id}" ${(Math.floor(article.trade.reg_id / 100)) eq (Math.floor(region.reg_id / 100)) ? 'selected="selected"':''}>${region.reg_name}</option>
								</c:if>
							</c:forEach>
						</select>
						
						<!-- 소분류 -->
						<select id="location-secondSelect" onchange="secondSelect()">
							<option value="">선택</option>
						</select>
					</div>
					<!-- 상세 지역 -->
					<div class="form-locationDetail">
						<label for="location-detail">거래 지역</label>
						<input type="text" id="location-detail" name="trade.trd_loc" value="${article.trade.trd_loc}" required="required" style="width: auto;">
					</div>
				</div>

				<div class="form-group">
					<label for="trade-max">최대 인원</label>
					<input type="number" id="trade-max" name="trade.trd_max" min="1" max="9" required="required" value="${article.trade.trd_max}">
				</div>

				<div class="form-group">
					<label for="trade-deadline">마감일</label>
					<input type="date" id="trade-deadline" name="trd_endDate" required="required" value="<fmt:formatDate value="${article.trade.trd_enddate}" pattern="yyyy-MM-dd"/>">
					
					
				</div> --%>

				<%-- <div class="form-group" style="display: flex;">
					<div class="gender-limit">
						<label for="trade-gender">성별</label>
						<select id="trade-gender" name="trade.trd_gender">
							<option value="">제한 없음</option>
							<option value="201"	${article.trade.trd_gender == '201'? 'selected="selected"':''}>남자</option>
							<option value="202" ${article.trade.trd_gender == '202'? 'selected="selected"':''}>여자</option>
						</select>
					</div>

					<div class="form-age">
						<label for="age-limit">나이</label> 
						최소 <input type="number" name="trade.trd_minage" min="1" max="100" value="${article.trade.trd_minage}">
						최대 <input type="number" name="trade.trd_maxage" min="1" max="100" value="${article.trade.trd_maxage}">
					</div>
				</div> --%>

				<!-- 매니저 이상의 권한만 공지 설정 가능 -->
				<c:if test="${memberInfo.mem_authority >= 108}">
					<div class="form-group checkbox-group">
						<label for="btns-checkbox">공지 여부</label> 
						<input type="hidden" id="art_isnotice" name="art_isnotice" value="0">
						<input type="checkbox" id="btns-checkbox" ${article.art_isnotice > 0? 'checked="checked"':'' }>
					</div>
				</c:if>

				<div class="button-group">
					<button type="submit" class="btns-submit">작성</button>
					<button type="button" class="btns-cancel" onclick="location.href='${pageContext.request.contextPath}/board/share?category='+${category};">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>