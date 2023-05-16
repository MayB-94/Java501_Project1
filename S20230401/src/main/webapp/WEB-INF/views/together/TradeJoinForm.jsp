<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" >
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">

<script>
	$(() => {
		$('#trade_submit').click(e => {
			
		    if (!$('.tradeAgree').is(':checked')) {
		        alert('동의하셔야 신청이 가능합니다.');
		        return;
		      }
			
			let rawData = { mem_id : ${memberInfo.mem_id},
							trd_id : ${article.trd_id}};
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/TradeWaiting",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('신청 완료');
					  window.close();
					  
				  } else {
					  alert('신청 실패');
				  }
	  			
	  			}
			});
		});
		
		$('#trade_cancel').click(() => {
		    if (confirm('정말 취소하시겠습니까?')) {
		        window.close();
		    }
		});
	});
	
</script>
	
</head>
  <style>
    .box1 {
    	margin : 20px;
      	padding : 10px;
      	width : 700px;
      	height: 300px; /* 스크롤 가능한 높이를 지정합니다. */
      	overflow: auto; /* 스크롤을 가능하게 합니다. */
      	border: 2px solid var(--subtheme);
    }
    
    .box2 {
    	margin : 20px;
      	padding : 10px;
      	width : 700px;
      	border: 2px solid var(--subtheme);
    }
    
    .trade_button {
    	padding : 20px;
    
    }
    
  </style>
<body>
	<h2>거래 신청</h2>
    <form action="${pageContext.request.contextPath }/board/ArticleReport" method="POST">  
        <input type="hidden" name="art_id" value="${article.art_id}">
        <input type="hidden" name="brd_id" value="${article.brd_id}">
        <input type="hidden" name="trd_id" value="${article.trd_id}">
        <input type="hidden" name="mem_id" value="${memberInfo.mem_id}">
        
	<div class="box1">
    	<h3>주의사항</h3>
    	<p>
    	회원간의 범죄 및 사기에 대한 신고처리를 담당해 해당유저의 권한을 제어합니다
    	⊙법률 제18572호
		소비자생활협동조합법 
		제1조(목적) 이 법은 상부상조의 정신을 바탕으로 한 소비자들의 상호 간 협동에 기반하여 물품ㆍ용역ㆍ시설 등의 공동구매와 이용, 
		판매를 자주ㆍ자립ㆍ자치적으로 수행하는 생활협동조합활동을 촉진함으로써 조합원의 소비생활 향상과 국민의 복지 및 생활문화 향상에 이바지함을 목적으로 한다. (개정 2021. 12. 7.)
		“조합”이란 제1조의 목적을 달성하기 위하여 이 법에 따라 설립된 소비자생활협동조합을 말한다.
		</p>
    	<ul>
    		<li>잘못된 방법으로 서비스의 제공을 방해하거나 ShareGo이 안내하는 방법 이외의 다른 방법을 사용하여 ShareGo 서비스에 접근하는 행위</li>
			<li>다른 이용자의 정보를 무단으로 수집, 이용하거나 다른 사람들에게 제공하는 행위</li>
			<li>서비스를 영리나 홍보 목적으로 이용하는 행위</li>
			<li>음란 정보나 저작권 침해 정보 등 공서양속 및 법령에 위반되는 내용의 정보 등을 발송하거나 게시하는 행위</li>
			<li>소프트웨어를 역설계하거나 소스 코드의 추출을 시도하는 등 ShareGo 서비스를 복제, 분해 또는 모방하거나 기타 변형하는 행위</li>
			<li>관련 법령, SharGo의 모든 약관 또는 운영정책을 준수하지 않는 행위</li>
    		<li>ShareGo는 범죄 및 사기에 대한 손해배상을 청구하지 않습니다</li>
    		<li>불법 거래 및 사기행위를 행하거나 동참할 시 </li>
    		<li>신청내용에 대한 개인정보 수집 동의</li>
    	</ul>
	</div>   
        		
        <br>
        
    <div class="box2">
    	<h3>거래내역 확인</h3>
       	<ul>
		<li>제목 : ${article.art_title }</li>
		<li>지역제한 :
			<c:choose>
	            <c:when test= "${article.reg_name == null }">
	            	제한없음
	            </c:when>
	            <c:otherwise>
	            	${article.reg_name }
	            </c:otherwise>
	      	</c:choose>
		</li>
		<li>장소 : ${article.trd_loc }</li>
		<li>인원 수 : ${article.trd_max }명</li>
		<li>성별 :
			<c:set var="gender" value ="${article.c2_comm_id }"/>
			<c:choose>
				<c:when test="${gender eq 201 }">남성</c:when>
				<c:when test="${gender eq 202 }">여성</c:when>
				<c:otherwise>성별무관</c:otherwise>
			</c:choose>
		</li>
		<li>나이 제한 : ${article.trd_max }세 ~ ${article.trd_max }세</li>
        </ul>
     </div>
        <br>	
               
               <strong>아래의 약관 내용을 동의하시면 신청하기를 눌러주세요</strong>
               <label>동의   <input  type="radio"  class = "tradeAgree"    name="tradeCheck"></label>
               <label>비동의<input  type="radio"  class = "tradeDisagree" name="tradeCheck" checked></label>
               <br>
               <br>
               <button type="button" class= "trade_button subtheme-button" id="trade_submit" style="padding: 10px">신청</button>
               <button type="button" class= "trade_button subtheme-button" id="trade_cancel" style="padding: 10px">취소</button>
    </form>
    
</body>
</html>