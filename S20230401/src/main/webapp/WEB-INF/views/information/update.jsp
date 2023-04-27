<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<form action="${pageContext.request.contextPath }/board/information/modify" method = "post" id = "modify">
      <div id="wrap" >
        <h1>게시글 수정</h1>
            <table>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="art_title" value="${art_title}"></td>
                </tr>
                <tr>
                    <th>태그1</th>
                    <td><input type="text" name="art_tag1" value="${art_tag1}"></td>
                </tr>
                <tr>
                    <th>태그2</th>
                    <td><input type="text" name="art_tag2" value="${art_tag2}"></td>
                </tr>
                <tr>
                    <th>태그3</th>
                    <td><input type="text" name="art_tag3" value="${art_tag3}"></td>
                </tr>
                <tr>
                    <th>태그4</th>
                    <td><input type="text" name="art_tag4" value="${art_tag4}"></td>
                </tr>
                <tr>
                    <th>태그5</th>
                    <td><input type="text" name="art_tag5" value="${art_tag5}"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea rows="15" cols="70" name="art_content">${art_content}</textarea></td>
                </tr>
            </table>
    	<button type="submit">수정하기</button>
    	<button onclick="window.history.back()">뒤로가기</button>
</div>
</form>
</body>
</html>