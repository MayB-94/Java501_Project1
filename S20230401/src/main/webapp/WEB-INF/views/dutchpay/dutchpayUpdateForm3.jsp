<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.container {
				height: 500px;
				width: 800px;
				background-color: #FFB85A;
				}
	
</style>
</head>
<body>
<body>
<!-- 확인 버튼 구현  -->
<form action="${pageContext.request.contextPath }/board/dutchpay/dutchpayUpdatePro" method="post"> 
	<div class="container">
	<input type="hidden" name="art_id" value="${updateForm.art_id }" >
	<input type="hidden" name="brd_id" value="${updateForm.brd_id }" > 
	<input type="hidden" name="trd_id" value="${updateForm.trd_id }" ><p>
	
	작성자 : <input type="hidden"    name="member_image" >${updateForm.mem_image }
		   <input type="hidden"    name="member_nickname" >${updateForm.mem_nickname }
		   <input type="hidden"    name="member_username" >(${updateForm.mem_username })<p>
	작성날짜 :	 <fmt:formatDate value="${updateForm.art_regdate}" pattern="yyyy년M월d일  hh시mm분"/><p>
	<table>
		<tr><th>제목</th><td>
			<input type="text"     name="art_title"value="${updateForm.art_title }" required="required" >@${updateForm.art_title }</td></tr>
		<tr><th>태그</th><td>
			<input type="text"     name="art_tag1" value="${updateForm.art_tag1}">
			<input type="text"     name="art_tag2" value="${updateForm.art_tag2}">
			<input type="text"     name="art_tag3" value="${updateForm.art_tag3}"><br>	
			<input type="text"     name="art_tag4" value="${updateForm.art_tag4}">
			<input type="text"     name="art_tag5" value="${updateForm.art_tag5}">
		</td></tr>
		<tr><th>가격</th><td>
			<input type="number"   name="trd_cost" 		  value="${updateForm.trd_cost}"   		  required="required"> 원</td></tr>
		<tr><th>모집인원</th><td>
			<input type="number"   name="trd_max"  		  value="${updateForm.trd_max}"	  		  required="required"> 명 (작성자 제외)</td></tr>
		<tr><th>마감일자</th><td>
			<input type="date" 	   name="trd_saveEnddate" value="${updateForm.trd_enddate}" 	  required="required"><%-- ${updateForm.trd_enddate } --%></td></tr> 
		<tr><th>지역</th><td>
			<select name="reg_id">
			<c:forEach var="L_ud" items="${loc_ud }">
				<option value="${L_ud.reg_id }" ${L_ud.reg_id == updateForm.reg_id ? 'selected' : '' }>${L_ud.reg_name }</option>
			</c:forEach>
			</select></td>
		</tr> 
		<tr><th>거래 상세장소</th><td>
			<input  type="text"    name="trd_loc" value="${updateForm.trd_loc}"></td></tr>
		<tr><th>내용</th><td>
		 	<textarea rows="10" cols="50" name="art_content">${updateForm.art_content}</textarea>
  		</td></tr>

	</table> <!--  brd_id가져오기 -->
		<input type="submit" value="수정확인">
		<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath }/board/dutchpay?category=${updateForm.brd_id}'">
	</div>

</form>
</body>
</html>