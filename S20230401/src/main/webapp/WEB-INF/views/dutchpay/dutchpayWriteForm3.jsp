<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>글작성</h1>
<form action="${pageContext.request.contextPath }/dutchpay/dutchpayWritePro" method="post" >

		
<table border="1"> 
		<tr><th>제목</th><td><input type="text" name="art_title" required="required">
		
		<tr><th>카테고리</th><td>
			<select name="brd_id">
			<c:forEach var="C" items="${categories }">
				<option value="${C.comm_id }">${C.comm_value }</option>
			</c:forEach>
			</select></td>
		</tr>
		
		<tr><th>태그</th>
		<td><input type="text" name="art_tag1" >
			<input type="text" name="art_tag2" >
			<input type="text" name="art_tag3" ><br>
			<input type="text" name="art_tag4" >
			<input type="text" name="art_tag5" ></td></tr>
		
		<tr><th>가격</th><td><input     type="number" name="trd_cost"     	required="required"> 원</td></tr>
		<tr><th>모집인원</th><td><input  type="number" name="trd_max" 	    	required="required"> 명 (작성자 제외)</td></tr>
	    <tr><th>마감일자</th><td><input  type="date"   name="trd_saveEnddate" 	    required="required"></td></tr>
		
		<tr><th>지역</th><td>
			<select name="reg_id">
			<c:forEach var="L" items="${loc }">
				<option value="${L.reg_id }">${L.reg_name }</option>
			</c:forEach>
			</select></td>
		</tr>
		<tr><th>거래 상세장소</th><td><input  type="text" name="trd_loc"></td></tr> 
		<tr><th>내용</th><td>
		 	<textarea rows="10" cols="50" name="art_content"></textarea>
		
		<tr><td><input type="submit" value="확인"></td></tr>
	</table>
</form>

</body>
</html>