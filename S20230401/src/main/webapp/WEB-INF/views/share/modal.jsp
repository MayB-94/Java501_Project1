<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- article -  모달 팝업 -->
	<div class="myModal" id="myModal" style="display: none;">
		<div class="myModal-window">
			<div class="modal-header">
				<div class="modal-title">무료나눔 신청</div>
				<div class="modal-close" id="modal-close">&times;</div>
			</div>
			<div class="modal-body">
				<div class="body-warning">
					<h2>사용시 주의해야 할 점</h2>
					<p>ShareGo는 사용자가 아래와 같이 잘못된 방법이나 행위로 서비스를 이용할 경우 사용에 대한 제재(이용정지, 강제탈퇴 등)를 가할 수 있습니다.</p>
					<ul>
						<li>잘못된 방법으로 서비스의 제공을 방해하거나 당근마켓이 안내하는 방법 이외의 다른 방법을 사용하여 ShareGo 서비스에 접근하는 행위</li>
						<li>다른 이용자의 정보를 무단으로 수집, 이용하거나 다른 사람들에게 제공하는 행위</li>
						<li>서비스를 영리나 홍보 목적으로 이용하는 행위</li>
						<li>음란 정보나 저작권 침해 정보 등 공서양속 및 법령에 위반되는 내용의 정보 등을 발송하거나 게시하는 행위</li>
						<li>소프트웨어를 역설계하거나 소스 코드의 추출을 시도하는 등 ShareGo 서비스를 복제, 분해 또는 모방하거나 기타 변형하는 행위</li>
						<li>관련 법령, ShareGo의 모든 약관 또는 운영정책을 준수하지 않는 행위</li>
					</ul>
					<p>개인정보는 ShareGo 서비스의 원활한 제공을 위하여 사용자가 동의한 목적과 범위 내에서만 이용됩니다. 개인정보 보호 관련 기타 상세한 사항은 ShareGo 개인정보처리방침을 참고하시기 바랍니다.</p>
				</div>
				<div class="body-info">
					<h2>무료 나눔 정보</h2>
					<ul>
						<li>가격 : 무료나눔</li>
						<li>장소 : ${article.trade.trd_loc}</li>
						<li>인원 : ${article.trade.trd_max}</li>
					</ul>
				</div>
			</div>
			<div class="modal-checkbox">
				<input type="checkbox" id="myCheckbox" class="myCheckbox"/>
				<label for="myCheckbox">동의</label>
			</div>
			<div class="modal-button">
				<button class="btns-action" id="btns-modalApply">신청</button>
				<button class="btns-action" id="btns-modalCancel">취소</button>
			</div>
		</div>
	</div>
	<!-- 신고 -->
	<div class="myModal" id="report" style="display: none;">
		<div class="myModal-window">
			
				<div class="modal-header">
					<div class="modal-title">신고</div>
					<div class="modal-close" id="modal-close">&times;</div>
				</div>
				<div class="modal-body">
					<div class="body-warning">
					<div class="body-info">
						<form action="${pageContext.request.contextPath}/board/share/reportForm" method="post" id="form-report">
							<input type="hidden" id="art_id"		name="art_id" 	value="${article.art_id}">
							<input type="hidden" id="brd_id" 		name="brd_id" 	value="${article.brd_id}">
							<input type="hidden" id="category" 		name="category" value="${category}">
							<input type="hidden" id="mem_id" 		name="mem_id" 	value="${article.mem_id}">
							<input type="hidden" id="reportMem_id" 	name="reportMem_id">
							<input type="hidden" id="report_id" 	name="report_id">
							<input type="hidden" id="rep_id" 		name="rep_id">
							<input type="hidden" id="type"			name="type">
							
							<h2 id="report-title">신고</h2>
							<p>유저 닉네임 : <span id="report-user">${article.member.mem_nickname}</span></p>
							<textarea name="report_content" required="required"></textarea>
							<button id="report-submit" style="display: none;"></button>
						</form>
					</div>
						<h2>주의 사항</h2>
						<p>ShareGo은 사용자가 허위적인 신고 혹은 잘못된 방법이나 행위로 신고 서비스를 악용 경우 사용에 대한 제재(이용정지, 강제탈퇴 등)를 가할 수 있습니다.</p>
					</div>
				</div>
				<div class="modal-checkbox">
					<input type="checkbox" id="report-Checkbox" class="myCheckbox"/>
					<label for="report-Checkbox">동의</label>
				</div>
				<div class="modal-button">
					<button type="button" class="btns-action" id="btns-reportApply">신고</button>
					<button type="reset" class="btns-action" id="btns-reportCancel">취소</button>
				</div>
		</div>
	</div>
</body>
</html>