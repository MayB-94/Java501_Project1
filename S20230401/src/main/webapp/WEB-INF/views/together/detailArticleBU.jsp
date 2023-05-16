<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../preset.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>

<script>
	
// 댓글 수정 버튼
	$(() => {
			$('.btns-repUpdate font-weight-bolder').click(e => {								// 수정버튼을 누른다
				if ($(e.target).closest('.reply_box').find('.rep_content2').css('display') == 'none') { // 댓글 textbox가 none이면?
					$(e.target).closest('.reply_box').find('.rep_content1').toggle();			// 내용은 none으로
					$(e.target).closest('.reply_box').find('.rep_content2').toggle();			// textbox는 block으로
					$(e.target).closest('.reply_box').find('.reply_cancel').toggle();			// 취소버튼 보이게
					$(e.target).closest('.reply_box').find('.reply_delete').toggle();			// 삭제버튼 숨기기
				} else {								// 댓글 textbox가 block이라면? 							// 댓글 textbox가 block이라면?
				
				let rawData = {art_id : ${detailArticle.art_id}, brd_id:${detailArticle.brd_id},
							   rep_id : $(e.target).closest('.reply_box').find('input[name="rep_id"]').val(),
							   rep_content : $(e.target).closest('.reply_box').find('.rep_content2').val()};
				
				let sendData = JSON.stringify(rawData);
				
				$.ajax({
					  url : "/board/updateReply",
					  type : 'post',
					  data : sendData,
					  dataType :'json',
					  contentType : 'application/json',
					  success : data => {
						  
						  if (data.result == 1) {	// 성공
							  	alert('수정 완료')
							  	$(e.target).closest('.reply_box').find('.rep_content1').text(data.content);
							  	$(e.target).closest('.reply_box').find('.rep_content2').val(data.content);
							  	
								$(e.target).closest('.reply_box').find('.rep_content1').toggle();		// 내용은 block으로
								$(e.target).closest('.reply_box').find('.rep_content2').toggle();		// textbox는 none으로
								$(e.target).closest('.reply_box').find('.reply_cancel').toggle();		// 취소버튼 보이게
								$(e.target).closest('.reply_box').find('.reply_delete').toggle();
						  } else 
							    alert('수정 실패');
					  }
				  }
				);
			}
		});
	});
	
	// 댓글 취소 버튼
	$(() => {
		$('.reply_cancel').click(e => {
			$(e.target).closest('.reply_box').find('.rep_content1').toggle();			// 내용은 block으로
			$(e.target).closest('.reply_box').find('.rep_content2').toggle();			// 텍스트 박스는 none으로?
			$(e.target).closest('.reply_box').find('.reply_cancel').toggle();			// 취소버튼 보이게
			$(e.target).closest('.reply_box').find('.reply_delete').toggle();			// 삭제버튼 안보이게
		});
	});
	
	// 게시글 신고 팝업창
	
	$(() => {
		  $('.article_report').click(e => {
	
		    let art_id = $('#art_id').val();
		    let brd_id = $('#brd_id').val();
		    let report_id = $('#report_id').val();
		    
		      
		    let popUrl = "/board/ArticleReportForm?art_id=" + art_id + "&brd_id=" + brd_id + (!report_id ? "" : "&report_id=" + report_id);
		    let popOption = "width=650px,height=550px,top=300px,left=300px,scrollbars=yes";
		      
		    window.open(popUrl, "신고하기", popOption);
		    
			});
		});
	
	// 댓글 신고
	
	$(() => {
		  $('.reply_report').click(e => {
	
		    let art_id = $('#art_id').val();
		    let brd_id = $('#brd_id').val();
		    let rep_id = $(e.target).closest('.reply_box').find('input[name="rep_id"]').val();
		    let report_id = $('#report_id').val();
		    
		      
		    let popUrl = "/board/ReplyReportForm?art_id=" + art_id + "&brd_id=" + brd_id + "&rep_id=" + rep_id + (!report_id ? "" : "&report_id=" + report_id)
		    let popOption = "width=650px,height=550px,top=300px,left=300px,scrollbars=yes";
		      
		    window.open(popUrl, "신고하기", popOption);
		    
			});
		});
	

	// 거래 신청 팝업창
	
		$(() => {
		  $('.article_submit').click(e => {
	
		    let art_id = $('#art_id').val();
		    let brd_id = $('#brd_id').val();
		    let mem_id = $('#login_mem_id').val();
		    
		    let existingIds = []; // 기존에 저장된 mem_id 배열
		    $('.joinList input[name="mem_id"]').each(function() {
		      existingIds.push($(this).val());
		    });
		    $('.waitingList input[name="mem_id"]').each(function() {
			  existingIds.push($(this).val());
			});
		    console.log(existingIds);
		    
		    // 새로운 mem_id가 배열에 이미 존재하는지 확인
		    if(existingIds.includes(mem_id)) {
		      alert('이미 신청한 회원입니다.');
		    } else {

		    let popUrl = "/board/TradeJoinForm?art_id=" + art_id + "&brd_id=" + brd_id
		    let popOption = "width=650px,height=550px,top=300px,left=300px,scrollbars=yes";
		      
		    window.open(popUrl, "신청하기", popOption);
		   		}	
		    	
			});
		});
	
	
		// 거래 신청자 취소 (ajax)
		$(() => {
			$('.article_cancel').click(e => {
				
				if(confirm('정말 취소하시겠습니까 ?') == true) {
				
				let rawData = { trd_id : ${detailArticle.trd_id},
								mem_id : ${memberInfo.mem_id == null ? 'null' : memberInfo.mem_id}}
			
				let sendData = JSON.stringify(rawData);
		
				$.ajax({
				  url : "/board/joinDelete",
				  type : 'post',
				  data : sendData,
				  dataType :'json',
				  contentType : 'application/json',
				  success : data => {
						  console.log(data.result);
					  if(data.result == 1) {
						  alert('취소 완료'); 
					  } else {
						  alert('취소 실패');
					  }
		  			
		  			}
				});
				} else {
					return;
				}
			});
		});
		
		

	
	// 수락버튼 -> 대기명단 => 신청자명단으로(ajax)
		
		$(() => {
			$('.joinAccept').click(e => {
				
				if(confirm('정말 수락하시겠습니까 ?') == true) {
				
				
				let rawData = { mem_id : $(e.target).closest('.waitingList').find('input[name="mem_id"]').val(),
								trd_id : ${detailArticle.trd_id} }
			
				let sendData = JSON.stringify(rawData);
		
				$.ajax({
				  url : "/board/joinAccept",
				  type : 'post',
				  data : sendData,
				  dataType :'json',
				  contentType : 'application/json',
				  success : data => {
						  console.log(data.result);
					  if(data.result == 1) {
						  alert('수락 완료');
						  
					  } else {
						  alert('수락 실패');
					  }
		  			
		  			}
				});
				} else {
					return;
				}
			});
		});
		
		
	// 거래 대기자 거절 (ajax)
		$(() => {
			$('.joinRefuse').click(e => {
				
				if(confirm('정말 취소하시겠습니까 ?') == true) {
				
				let rawData = { mem_id : $(e.target).closest('.waitingList').find('input[name="mem_id"]').val(),
								trd_id : ${detailArticle.trd_id} }
			
				let sendData = JSON.stringify(rawData);
		
				$.ajax({
				  url : "/board/joinRefuse",
				  type : 'post',
				  data : sendData,
				  dataType :'json',
				  contentType : 'application/json',
				  success : data => {
						  console.log(data.result);
					  if(data.result == 1) {
						  alert('취소 완료');
						  
					  } else {
						  alert('취소 실패');
					  }
		  			}
				});
				} else {
					return;
				}
			});
		});
	
	
	// 관심목록 넣기
		$(() => {
			$('.article_favorite').click(e => {
				let rawData = { art_id : ${article.art_id}, brd_id : ${article.brd_id},
								mem_id : ${memberInfo.mem_id == null ? 'null' : memberInfo.mem_id}};
				let sendData = JSON.stringify(rawData);
		
				$.ajax({
				  url : "/board/favoriteArticle",
				  type : 'post',
				  data : sendData,
				  dataType :'json',
				  contentType : 'application/json',
				  success : data => {
						  console.log(data);
					  if(data == "1") {
						  alert('관심목록에 등록되었습니다');
					  } else if (data == "-1"){
						  alert('이미 등록된 게시글입니다');
					  } else 
						  alert('등록 실패');
		  			  }
				});
			});
		});
	
		// 관심목록 삭제
		$(() => {
			$('.article_?').click(e => {
				let rawData = { art_id : ${article.art_id}, brd_id : ${article.brd_id},
								mem_id : ${memberInfo.mem_id == null ? 'null' : memberInfo.mem_id}};
				let sendData = JSON.stringify(rawData);
		
				$.ajax({
				  url : "/board/favoriteArticleDelete",
				  type : 'post',
				  data : sendData,
				  dataType :'json',
				  contentType : 'application/json',
				  success : data => {
						  console.log(data);
					  if(data == "1") {
						  alert('관심목록에서 삭제되었습니다');
					  } else if (data == "-1"){
						  alert('이미 등록된 게시글입니다');
					  } else 
						  alert('삭제 실패');
		  			  }
				});
			});
		});
	
	
	// 댓글 입력시 확인
 	$(() => {
		$('.replySubmit').click(e => {
			
			let rep_content = $(e.target).closest('.insertReply').find('input[name="rep_content"]').val();
			
		    if (rep_content == null || rep_content.trim() === '') {
		        alert('내용을 작성하세요')
		        return false;
		      }
		      
		      if (confirm('댓글을 입력하시겠습니까?')) {
		      } else {
		        return false;
		      }
		    });
		  });
	
	
	// 대댓글 입력
 	$(() => {
		$('.re_replySubmit').click(e => {
			
			let rep_content = $(e.target).closest('.insertRe_Reply').find('input[name="rep_content"]').val();
			
		    if (rep_content == null || rep_content.trim() === '') {
		        alert('내용을 작성하세요')
		        return false;
		      }
		      
		      if (confirm('댓글을 입력하시겠습니까?')) {
		      } else {
		        return false;
		      }
		    });
		  });
 	
 	
 	
	// 거래 게시자가 거래 취소 (404) (ajax)
	$(() => {
		$('.trade_cancel').click(e => {
			
			if(confirm('정말 취소하시겠습니까 ?') == true) {
			
			let rawData = { mem_id : ${memberInfo.mem_id == null ? 'null' : memberInfo.mem_id},
							trd_id : ${detailArticle.trd_id} }
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/tradeCancel",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data);
				  if(data == 1) {
					  alert('취소 완료'); 
				  } else {
					  alert('취소 실패');
				  }
	  			
	  			}
			});
			} else {
				return;
			}
		});
	});
	
	
	// 게시글 추천
	$(() => {
		$('.article_good_Up').click(e => {
			
			if(confirm('정말 추천하시겠습니까 ?') == true) {
			
			let rawData = { art_id : ${detailArticle.art_id}, brd_id : ${detailArticle.brd_id} }
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/articleGoodUp",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('추천 완료');
					  
				  } else {
					  alert('한 시간에 한번씩만 가능합니다.');
				  }
	  			}
			});
			} else {
				return;
			}
		});
	});
	
	
	// 게시글 비추천
	$(() => {
		$('.article_bad_Up').click(e => {
			
			if(confirm('정말 비추천하시겠습니까 ?') == true) {
			
			let rawData = { art_id : ${detailArticle.art_id}, brd_id : ${detailArticle.brd_id} }
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/articleBadUp",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('비추천 완료');
					  
				  } else {
					  alert('한 시간에 한번씩만 가능합니다.');
				  }
	  			}
			});
			} else {
				return;
			}
		});
	});
	
	// 댓글 추천
	$(() => {
		$('.reply_good').click(e => {
			
			if(confirm('정말 추천하시겠습니까 ?') == true) {
			
			let rawData = { art_id : ${detailArticle.art_id}, brd_id : ${detailArticle.brd_id}, 
							rep_id : $(e.target).closest('.reply_box').find('input[name="rep_id"]').val()}
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/replyGoodUp",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('추천 완료');
					  
				  } else {
					  alert('한 시간에 한번씩만 가능합니다.');
				  }
	  			}
			});
			} else {
				return;
			}
		});
	});
	
	
	// 댓글 비추천
	$(() => {
		$('.reply_bad').click(e => {
			
			if(confirm('정말 비추천하시겠습니까 ?') == true) {
			
			let rawData = { art_id : ${detailArticle.art_id}, brd_id : ${detailArticle.brd_id}, 
							rep_id : $(e.target).closest('.reply_box').find('input[name="rep_id"]').val()}
		
			let sendData = JSON.stringify(rawData);
	
			$.ajax({
			  url : "/board/replyBadUp",
			  type : 'post',
			  data : sendData,
			  dataType :'json',
			  contentType : 'application/json',
			  success : data => {
					  console.log(data.result);
				  if(data.result == 1) {
					  alert('비추천 완료');
					  
				  } else {
					  alert('한 시간에 한번씩만 가능합니다.');
				  }
	  			}
			});
			} else {
				return;
			}
		});
	});
		
	
	function deleteReply(brd_id, art_id, rep_id, mem_id) {
	  if (confirm("댓글을 삭제하시겠습니까?")== true) {
	    location.href = '/board/deleteReply?brd_id=' + brd_id + '&art_id=' + art_id + '&rep_id=' + rep_id + '&mem_id=' + mem_id;
	  } else {
		  return false;
	  }
	}
	
	$(() => {
		  $('.reply_button').click(e => {
		    $(e.target).closest('.R').find('.insertRe_Reply').toggle();	
		  });
		});

		
</script>

</head>
<body>
	<h2>상세게시글</h2>

	<p>
		<input type="button" value="전체"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1000';">
		<input type="button" value="밥 & 카페"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1010';">
		<input type="button" value="스포츠"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1020';">
		<input type="button" value="쇼핑"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1030';">
		<input type="button" value="문화생활"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1040';">
		<input type="button" value="취미생활"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1050';">
		<input type="button" value="기타"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1060';">
	<p>
		<input type="button" value="목록"
			onclick="location.href='${pageContext.request.contextPath }/board/together?category=1000';">
		<c:choose>
			<c:when test="${memberInfo.mem_id == detailArticle.mem_id}">
				<input type="button" value="수정하기"
					onclick="${pageContext.request.contextPath }location.href='/board/updateFormArticle?brd_id=${detailArticle.brd_id }&art_id=${detailArticle.art_id }';">
				<input type="button" value="삭제하기"
					onclick="${pageContext.request.contextPath }location.href='/board/deleteArticle?brd_id=${detailArticle.brd_id }&art_id=${detailArticle.art_id }';">
			</c:when>
		</c:choose>

		<input type="hidden" name="art_id" 		 id="art_id" 		value="${detailArticle.art_id }">
		<input type="hidden" name="brd_id" 		 id="brd_id" 		value="${detailArticle.brd_id }">
		<input type="hidden" name="mem_id" 		 id="mem_id" 		value="${detailArticle.mem_id }">
		<input type="hidden" name="report_id"	 id="report_id"     value="${detailArticle.report_id }">
		<input type="hidden" name="login_mem_id" id="login_mem_id"  value="${memberInfo.mem_id }">
		<input type="hidden" name="trd_id" 		 id="trd_id" 		value="${detailArticle.trd_id }">
		<input type="hidden" name="trd_max" 	 id="trd_max" 		value="${detailArticle.trd_max }">
		
	<table border="1">
		<tr>
			<th>거래상태</th>
			<td width="500">${detailArticle.c1_comm_value }
		</tr>
		<tr>
			<th>제목</th>
			<td>${detailArticle.art_title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${detailArticle.mem_nickname }</td>
		</tr>

		<tr>
			<th>태그1</th>
			<td>${detailArticle.art_tag1 }</td>
		</tr>
		<tr>
			<th>태그2</th>
			<td>${detailArticle.art_tag2 }</td>
		</tr>
		<tr>
			<th>태그3</th>
			<td>${detailArticle.art_tag3 }</td>
		</tr>
		<tr>
			<th>태그4</th>
			<td>${detailArticle.art_tag4 }</td>
		</tr>
		<tr>
			<th>태그5</th>
			<td>${detailArticle.art_tag5 }</td>
		</tr>
		<tr>
			<th>장소</th>
			<td>${detailArticle.trd_loc }</td>
		</tr>
		<tr>
			<th>지역제한</th>
			<td>${detailArticle.reg_name }</td>
		</tr>
		<tr>
			<th>모집인원</th>
			<td>${detailArticle.trd_max }(본인 포함)</td>
		</tr>
		<tr>
			<th>나이제한</th>
			<td>${detailArticle.trd_minage }세~ ${detailArticle.trd_maxage }세</td>
		</tr>
		<tr>
			<th>성별</th>
			<td><c:set var="gender" value="${detailArticle.c2_comm_id }" />
				<c:choose>
					<c:when test="${gender eq 201 }">남성</c:when>
					<c:when test="${gender eq 202 }">여성</c:when>
					<c:otherwise>성별무관</c:otherwise>
				</c:choose></td>
		</tr>
		<tr>
			<th>추천수</th>
			<td>${detailArticle.art_good }</td>
		</tr>
		<tr>
			<th>비추천수</th>
			<td>${detailArticle.art_bad }</td>
		</tr>
		<tr>
			<th>작성 시간</th>
			<td>${detailArticle.rest_regdate }일전</td>
		</tr>
		<tr>
			<th>마감 일자</th>
 			<td>${detailArticle.trd_finish }까지</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${detailArticle.art_read }</td>
		</tr>
		<tr>
			<th>관심목록 수</th>
			<td>${detailArticle.favoriteCount }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${detailArticle.art_content }</td>
		</tr>
	</table>
	<br>
	<c:choose>
		<c:when test="${memberInfo.mem_id != null}">
			<input type="button" class="article_favorite" 	value="관심목록">
			<input type="button" class="article_good_Up" 	value="추천">
			<input type="button" class="article_bad_Up" 	value="비추천"	>
			<input type="button" class="article_report" 	value="신고하기">
		</c:when>
	</c:choose>
	<br>
	<br>


	<table class="joinList" border="1">
		<tr>
			<th colspan="3" width="500px">함께해요 참여자 목록</th>
		</tr>
		<tr>
			<th colspan="2">신청자</th>
			<th>신청일자</th>
		</tr>
		<c:forEach var="joinList" items="${joinList }">
			<input type="hidden" name="mem_id" value="${joinList.mem_id }">
			<tr>
				<td><img
					src="${pageContext.request.contextPath}/image/picture/${joinList.mem_image}"
					width="30" height="30" alt="-"></td>
				<td>${joinList.mem_nickname }(${joinList.mem_username })</td>
				<td><fmt:formatDate value="${joinList.join_date}" pattern="yy년 MM월 dd일 : HH:mm:ss" /></td>
			</tr>
		</c:forEach>
	</table>

	<div class="joinList">
		<c:forEach var="joinList" items="${joinList }">
			<input type="hidden" name="mem_id" value="${joinList.mem_id }">
		</c:forEach>
		<c:choose>
			<c:when test="${memberInfo.mem_id == detailArticle.mem_id }">
				<c:choose>
					<c:when test="${detailArticle.trd_status == '401' }">
						<input type="button" class="trade_cancel" value="거래 취소">
					</c:when>	
					<c:when test="${detailArticle.trd_status == '404' }">
						<span> 거래를 취소하셨습니다. </span>
					</c:when>
				</c:choose>	
			</c:when>	
			<c:when test="${memberInfo.mem_id != null}">
				<c:choose>
					<c:when test="${detailArticle.trd_status == '401' }">
						<input type="button" class="article_submit" value="신청하기">
						<input type="button" class="article_cancel" value="취소하기">
					</c:when>
					<c:when test="${detailArticle.trd_status == '404' }">
						<span> 거래가 취소된 게시글입니다. </span>
					</c:when>
					<c:otherwise>	
						<span> 거래 신청이 마감된 게시글입니다. </span>
					</c:otherwise>
				</c:choose>
			</c:when>
		</c:choose>
	</div>
	<br>
	<br>


	<c:choose>
		<c:when test="${memberInfo.mem_id == detailArticle.mem_id}">
			<table class="waitingList" border="1">
				<tr>
					<th colspan="5" width="500px">함께해요 참여 대기 목록</th>
				</tr>
				<tr>
					<th colspan="2">대기자</th>
					<th colspan="2">신청 대기 일자</th>
				</tr>
				<c:forEach var="waitingList" items="${waitingList }">
					<input type="hidden" name="mem_id" value="${waitingList.mem_id }">
					<tr>
						<td><img
							src="${pageContext.request.contextPath}/image/picture/${waitingList.mem_image}"
							width="30" height="30" alt="-"></td>
						<td>${waitingList.mem_nickname }(${waitingList.mem_username })
						</td>
						<td><fmt:formatDate value="${waitingList.wait_date}"
								pattern="yy년 MM월 dd일 : HH:mm:ss" />
							<button type="button" class="joinAccept">수락</button>
							<button type="button" class="joinRefuse">취소</button></td>
					</tr>
				</c:forEach>
			</table>
		</c:when>
	</c:choose>
	<br>


	<div class="waitingList">
		<c:forEach var="waitingList" items="${waitingList }">
			<input type="hidden" name="mem_id" value="${waitingList.mem_id }">
			<c:choose>
				<c:when test="${memberInfo.mem_id == waitingList.mem_id}">
					<table>
						<tr>
							<td colspan="2">현재 요청 대기 중인 거래입니다.</td>
						</tr>
						<tr>
							<td>취소하시겠습니까?</td>
							<td><button type="button" class="joinRefuse">취소하기</button></td>
						</tr>
					</table>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<br>











	<table>
		<tr>
			<td>댓글 (${detailArticle.repCount })</td>
		</tr>
		<!-- 댓글입력 -->
		<tr>
			<td>
				<div class="insertReply">
					<form action="/board/insertReply" id="insertReply" method="post">
						<!-- form 'action' = '데이터가 도착할 URL을 써준다' 'method' = '데이터를 전달할 방식을 써준다'-->
						<!-- get 방식으로 넘길 땐 주소값 뒤에 ? 로 파라미터 값을 적어주고 / post 방식으로 넘길 땐 form 안에 input으로 값을 적어서 넘겨준다-->
						<input type="hidden" name="art_id" 		value="${detailArticle.art_id }">
						<input type="hidden" name="brd_id" 		value="${detailArticle.brd_id }">
						<input type="hidden" name="mem_id" 		value="${detailArticle.mem_id }">
						<input type="hidden" name="rep_id" 		value="${reply.rep_id }">
						<input type="hidden" name="rep_parent" 	value="${reply.rep_parent }">
						<c:choose>
							<c:when test="${memberInfo.mem_id != null}">
								<input type="text" name="rep_content" placeholder="댓글을 입력하세요"
									style="margin: 10px; width: 1225px; height: 20px; font-size: 12px;"></input>
								<div style="display: block;" id="replyButton">
									<input type="submit" class="replySubmit" value="댓글">
									<input type="reset"  class="replyReset"  value="취소">
								</div>
							</c:when>
							<c:otherwise>
								<span> 로그인이 필요합니다 </span>
							</c:otherwise>
						</c:choose>

						<!-- name = 데이터를 전달 받는 column 이름, value= 들어갈 데이터의 값, id = javascript로 꾸밀 때 지정해주는 이름(?) -->
					</form>
				</div>
			</td>
		</tr>
	</table>
	<br>

	<!-- 댓글리스트 -->
	<div class="R">
	<c:forEach var="reply" items="${replyList }" varStatus="status">
		<c:choose>
			<c:when test="${reply.isdelete == 1 }">
				<div class = "replyList"> 					
					<input type="hidden" name="art_id" value="${reply.art_id }">
					<input type="hidden" name="brd_id" value="${reply.brd_id }">
					<input type="hidden" name="mem_id" value="${reply.mem_id }">
					<input type="hidden" name="rep_id" value="${reply.rep_id }">
					<span><img src="${pageContext.request.contextPath}/image/picture/${reply.mem_image}"
						width="30" height="30" alt="-"></span>
					<span>${reply.mem_nickname }</span>
					<span>(${reply.mem_username })</span>
					<fmt:formatDate value="${reply.rep_regdate}" pattern="yy년 MM월 dd일 : HH:mm:ss" /><p>
					<span> 삭제된 댓글입니다. </span>
					<span style="float: right;">비추천수 : ${reply.rep_bad } </span> 
					<span style="float: right;">추천수 : ${reply.rep_good }&nbsp;</span>
				</div>
			</c:when>
			<c:otherwise>
				<div class="reply_box"
					style=" ${reply.rep_step > 1 ? 'margin-left: 50px' : ''}">
					<input type="hidden" name="art_id" value="${reply.art_id }">
					<input type="hidden" name="brd_id" value="${reply.brd_id }">
					<input type="hidden" name="mem_id" value="${reply.mem_id }">
					<input type="hidden" name="rep_id" value="${reply.rep_id }">
					<span><img src="${pageContext.request.contextPath}/image/picture/${reply.mem_image}"
						width="30" height="30" alt="-"></span>
					<span>${reply.mem_nickname }</span>
					<span>(${reply.mem_username })</span>
					<fmt:formatDate value="${reply.rep_regdate}" pattern="yy년 MM월 dd일 : HH:mm:ss" />
					<p>
					<span class="rep_content1"> ${reply.rep_content}</span> 
					<input	type="text" class="rep_content2" style="display: none; margin: 10px; 
					width: 1225px; height: 20px; font-size: 12px;'" value="${reply.rep_content }">
					<span style="float: right;">비추천수 : ${reply.rep_bad } </span> 
					<span style="float: right;">추천수 : ${reply.rep_good }&nbsp;</span>
					</p>
					<p>
								<input class="reply_button" type="button" value="답글작성" style="display: inline;"
								data-id="${status.count }">
						<c:choose>
							<c:when test="${memberInfo.mem_id == reply.mem_id}">
								<input class="reply_modify" type="button" value="수정">
								<input class="reply_cancel" type="button" value="취소" style="display: none;">
								<input class="reply_delete" type="button" value="삭제" style="display: inline;"
									onclick="deleteReply(${reply.brd_id}, ${reply.art_id}, ${reply.rep_id}, ${reply.mem_id});">
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${memberInfo.mem_id != null}">
								<input class="reply_bad"    style="float: right;" type="button" value="비추천">
								<input class="reply_good"   style="float: right;" type="button" value="추천">
								<input class="reply_report" style="float: right;" type="button" value="신고">
							</c:when>
						</c:choose>
					</p>
				</div>
		
				<div class="insertRe_Reply" style="display: none; ${reply.rep_step > 1 ? 'margin-left: 50px' : ''}"
						data-id="${status.count }">
					<form action="/board/insertReply" id="insertRe-Reply" method="post">
							<input type="hidden" name="art_id" value="${detailArticle.art_id }">
							<input type="hidden" name="brd_id" value="${detailArticle.brd_id }">
							<input type="hidden" name="mem_id" value="${detailArticle.mem_id }">
							<input type="hidden" name="rep_id" value="${reply.rep_id }">
							<input type="hidden" name="rep_parent" value="${reply.rep_parent }">
						<div class="Re-ReplyBox">
						<c:choose>
							<c:when test="${memberInfo.mem_id != null}">
								<input type="text" name="rep_content" placeholder="댓글을 입력하세요"
									style="margin: 10px; width: 1225px; height: 20px; font-size: 12px;"></input>
								<div style="display: block;" id="replyButton">
									<input type="submit" class="re_replySubmit" value="댓글"> 
									<input type="reset"  class="re_replyReset"  value="취소">
								</div>
							</c:when>
							<c:otherwise>
								<span> 로그인이 필요합니다 </span>
							</c:otherwise>
						</c:choose>
						</div>
					</form>
				</div>
				<br>
			</c:otherwise>
		</c:choose>		
	</c:forEach>
	</div>


</body>
</html>