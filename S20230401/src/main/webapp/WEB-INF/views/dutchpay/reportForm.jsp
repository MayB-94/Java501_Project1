<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>신청서</title>
 <style>
      body {
        margin: 0px;
      }
      div {
        margin: 10px;
        padding: 10px;
        border: 10px solid #D9E5FF;
        width: 500px;
      }
      .box1 {
        box-sizing: content-box;
      }
</style>
</head>
<body>

<div class="box1">
		게시물 제목 : ${reportForm.art_title }<br>
		작성자 : ${reportForm.mem_image }${reportForm.mem_nickname }(${reportForm.mem_username })<p>
		신고사유<br> 
		 <textarea rows="10" cols="50" name="report_content"></textarea>

<form method="post">
		
	<input type="hidden" name="brd_id" value="${reportForm.brd_id }">${reportForm.brd_id }
	<input type="hidden" name="art_id" value="${reportForm.art_id }">${reportForm.art_id }
 	<input type="hidden" name="report_id" value="${reportForm.report_id }">${reportForm.report_id }
	
	<input type="submit" value="취소" 	onclick="javascript:self.close();">
 	<input type="submit" value="신고하기" formaction="${pageContext.request.contextPath }/dutchpay/reportInsert"> 
    
	
	
</form>
</div>

</body>
</html>
