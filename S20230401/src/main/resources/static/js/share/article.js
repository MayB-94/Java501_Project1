/**
 * 
 */
// 세션 스토리지에서 contextPath 호출하여 저장 경로, 글번호, 게시판 번호, 카테고리 번호, 로그인 유저, 작성자
// const contextPath = sessionStorage.getItem("contextPath");
const artId = sessionStorage.getItem("artId");
const brdId = sessionStorage.getItem("brdId");
const memId = sessionStorage.getItem("memId");
const category = sessionStorage.getItem("category");
const loginUser = sessionStorage.getItem("loginUser");
console.info('로그인 유저 : '+loginUser);
// 클릭 이벤트
$(document).ready(()=>{
    // 찜 찜 취소
    $('#btns-favorite, #btns-favoriteDel').click((e)=>{
        if(loginUser > 0){
            if(e.target.id == 'btns-favorite'){
                message = '즐겨찾기 하시겠습니까?';
                action = 'add';
            }
            if(e.target.id == 'btns-favoriteDel'){
                message = '즐겨찾기 목록에서 삭제 하시겠습니까?';
                action = 'del';
            }
            if(confirm(message)){
                location.href = `${contextPath}/board/share/favorite/${action}?art_id=${artId}&brd_id=${brdId}&category=${category}`;
            }
        }else alert('로그인 하세요');
    });
});

// 이동

// 댓글 펼치기
$(document).ready(()=>{
    $('#btns-show, #btns-hide').click(e=>{
        $(e.target).closest('.reply-list')
        .find('#btns-show').toggle().end()
        .find('#btns-hide').toggle().end()
        .find('.reply-detail').toggle().end();
    });
});
// 댓글 기능 - 댓글 수정
$(document).ready(() => {
    $('.btns-repUpdate, .btns-cancel, .btns-repComplete').click(e => {
        console.log($(e.target).closest('.reply-view').find('.rep-content').val());
        let condition = $(e.target).closest('.reply-view').find('.rep-content').prop('disabled');
        $(e.target)
        .closest('.reply-view')
        .find('textarea.rep-content').prop('disabled', condition ? false : true).focus().end()
        .find('.btns-repUpdate').toggle().end()
        .find('.btns-delete').toggle().end()
        .find('.btns-repComplete').toggle().end()
        .find('.btns-cancel').toggle();
    });
});

// 댓글 수정 완료
function rep_Update(pIndex){
    let rep_content = $('#rep-content'+pIndex).val();
    let art_id = $('#art_id'+pIndex).val();
    let brd_id = $('#brd_id'+pIndex).val();
    let rep_id = $('#rep_id'+pIndex).val();
    
    $.ajax({
        url:contextPath+'/board/share/update',
        data:{art_id, brd_id, rep_id, rep_content},
        dataType:'json',
        success:function(data){
            console.log(data)
            // $('body').load(location.href);
            location.reload();
            }
    });
}

// 댓글 기능 - 댓글 삭제
function rep_delete(brd_id, art_id, rep_id) {
    location.href = contextPath+'/board/share/repDelete?art_id='+art_id+'&brd_id='+brd_id+'&rep_id='+rep_id;
}

// 댓글 기능 - 대댓글 작성 토글
$(document).ready(() => {
    $(".btns-repWrite").click(e => {
        console.log(e.target.getAttribute('class')); // 클릭 이벤트 발생시 e.target의 클래스 출력
        $(e.target).closest('.reply-detail').find(".reply-replyWrite").toggle();
    });
});

// 게시글 기능 - 게시글 삭제
function art_Delete(){
    let mem_id = $('#mem_id').val();
    let login_member = $('#login_member').val();
    let login_authority = $('#login_authority').val();
    if(mem_id != login_member && login_authority < 108){
        alert('권한이 없습니다');
        return false;
    }
    if(confirm('삭제 하시겠습니까?')){
        location.href=contextPath+'/board/share/artDelete/'+artId+'?brd_id='+brdId+'&category='+category;
        alert("삭제 되었습니다.");
    }
}
// 게시글 기능 -게시글 수정
function art_Update(){
    if(confirm('수정 하시겠습니까?')){
        location.href=contextPath+'/board/share/artUpdate?art_id='+artId+'&brd_id='+brdId+'&category='+category;
    }
}

// 게시글 기능 - 추천, 비추천 ----------------------------------------------------------ajax사용 추천 취소기능 추가 요망
$(document).ready(() => {
    // 추천 비추천 여부 확인
    checkVote();
    // 클릭 이벤트
    $('#btns-good, #btns-goodcancel, #btns-bad, #btns-badcancel').click(e => { 
        if(loginUser > 0){
            // 변수 선언
            let btns;   let action;     let message;
            let id = e.target.getAttribute('id');
            let buttonTypes = {
                'btns-good'      : {message:'추천 하시겠습니까?', btns:'good', action:'.btns-good'},
                'btns-goodcancel': {message:'취소 하시겠습니까?', btns:'good', action:'.btns-good'},
                'btns-bad'       : {message:'비추천 하시겠습니까?', btns:'bad', action:'.btns-bad'},
                'btns-badcancel' : {message:'취소 하시겠습니까?', btns:'bad', action:'.btns-bad'},
            };

            // 클릭한 버튼의 id와 일치하는 조건에 할당
            if(id in buttonTypes){
                ({message, btns, action} = buttonTypes[id]);
            }
            console.info(btns, action, message);

            if(confirm(message)){
                $.ajax({
                    url:contextPath+'/board/share/vote/'+btns+'?art_id='+artId+'&brd_id='+brdId+'&category='+category,
                    success:function(data){
                        console.log(data)
                        $(e.target).closest('#btns-vote')
                        .find(action).toggle().find('span').text(data).end();
                    }
                })
            }
        }else alert('로그인 하세요');
    });
});

// 추천, 비추천 여부 확인
function checkVote(){
    let cookies = document.cookie.split(';');
    for(let cookie of cookies){
        cookie = cookie.trim();
        // 쿠키 name에 유저가 있는지 확인
        console.info('share|'+loginUser+'=', '굿', cookie.includes(artId+brdId+'good'), '베드', cookie.includes(artId+brdId+'bad'))
        if(cookie.startsWith('share|'+loginUser+'=')){
            // 쿠키 value에 추천 비추천 확인
            if(cookie.includes(artId+brdId+'good')){
                document.getElementById('btns-good').style.display = 'none';
                document.getElementById('btns-goodcancel').style.display = '';
            }
            if(cookie.includes(artId+brdId+'bad')){
                document.getElementById('btns-bad').style.display = 'none';
                document.getElementById('btns-badcancel').style.display = '';
            }
        }
    }
}



// 거래 신청 (modal.jsp)
$(document).ready(()=>{ 
    // 신청 버튼
    $('#btns-apply').click((e)=>{
        if(loginUser > 0){
        	if(loginUser != memId){
	            $('#myModal').css('display', 'flex'); // flex로 변경
        	}else{
        		alert('본인이 작성한 글 입니다.');
        	}
        }else alert('로그인 하세요');
    });

    $('#btns-modalApply').click(()=>{
        if($('#myCheckbox').is(':checked')){
            if(confirm('거래 신청 하시겠습니까?')){
                location.href=contextPath+'/board/share/waiting/add?art_id='+artId+'&brd_id='+brdId+'&category='+category;
            }
        }else alert('동의하지 않으면 신청하실 수 없습니다.')
    });

    // 바깥 영역, 취소 버튼, X 버튼
    $('#myModal').click(e=>{
        if(!$(e.target).closest('.myModal-window').length || $(e.target).is('#btns-modalCancel, #modal-close')){
            $('#myModal').css('display', 'none');
        }
    });
});



// 거래 버튼 이벤트 (승인, 거절, 추방, 취소)
$(()=>{
	$(document).on('click', '#btns-accept, #btns-refuse, #btns-drop, #btns-joinCancel, #btns-waitCancel', userListButtonClick);
});
function userListButtonClick(e){
	if(loginUser > 0){
		let mem_id = $(e.target).closest('.userList-memberInfo').find('#member_id').val();
		let message;
		let action;
		
		switch(e.target.id) {
			case 'btns-accept':
				message = '승인 하시겠습니까?';
				action = 'accept';
				break;
			case 'btns-refuse':
				message = '거절 하시겠습니까?';
				action = 'refuse';
				break;
			case 'btns-waitCancel':
				message = '취소 하시겠습니까?';
				action = 'refuse';
				break;
			case 'btns-drop':
				message = '추방 하시겠습니까?';
				action = 'drop';
				break;
			case 'btns-joinCancel':
				message = '취소 하시겠습니까?';
				action = 'drop';
				break;
		}
		if(confirm(message)) {
			let url = `${contextPath}/board/share/join/${action}?art_id=${artId}&brd_id=${brdId}&mem_id=${mem_id}&category=${category}`;
			location.href = url;
			console.log(url);
		}
	}else {
		alert('로그인 하세요');
	}
}



// 신고 기능
$(()=>{
    let reply_id, member_id, report_id, nickname, action;
    // 신고 아이콘 클릭
    $('#article-report, #reply-report, #member-report').click((e)=>{
        if(loginUser > 0){
            // 게시글 신고
            if($(e.target).is('#article-report')){
                report_id = $(e.target).closest('.view-article').find('#artReport_id').val();

                console.info('신고 번호 조회'+report_id);
                reportCheck(report_id)
                    .then(isReport => {
                        if(!isReport){
                            console.info(isReport);
                            nickname = $(e.target).closest('.view-article').find('#member_nickname').text();
                            $('#report-user').text(nickname);
                            $('#report_id').val(report_id);
                            $('#report-title').text('게시글 신고');
                            action = 'article';
                        }
                }).catch(error => {
                    console.error(error);
                });
                
            }
            // 댓글 신고
            if($(e.target).is('#reply-report')){
                report_id = $(e.target).closest('.reply-detail').find('#repReport_id').val();

                console.info('신고 번호 조회'+report_id);
                reportCheck(report_id)
                    .then(isReport => {
                        if(!isReport){
                            console.info(isReport);
                            reply_id = $(e.target).closest('.reply-detail').find('#reply_id').val();
                            nickname = $(e.target).closest('.reply-detail').find('#member_nickname').text();
                            $('#report-user').text(nickname);
                            $('#report-title').text('댓글 신고');
                            $('#rep_id').val(reply_id);
                            action = 'reply';
                        }
                }).catch(error => {
                    console.error(error);
                });
            }
            // 유저 신고
            if($(e.target).is('#member-report')){
                report_id = $(e.target).closest('.modal-report').find('#memReport_id').val();
                
                console.info('신고 번호 조회'+report_id);
                reportCheck(report_id)
                    .then(isReport => {
                        if(!isReport){
                            console.info(isReport);
                            member_id = $(e.target).closest('.modal-report').find('#member_id').val();
                            nickname = $(e.target).closest('.modal-report').find('#member_nickname').text();
                            $('#report-user').text(nickname);
                            $('#report_id').val(report_id);
                            $('#reportMem_id').val(member_id);
                            $('#report-title').text('유저 신고');
                            action = 'member';
                            console.info(member_id);
                        }
                }).catch(error => {
                    console.error(error);
                });
            }
        
        }else {
            alert('로그인 하세요');
        }
    });

    // 신고 실행
    $('#btns-reportApply').click(()=>{
        if($('#report-Checkbox').is(':checked')){
            if(confirm('신고 하시겠습니까?')){
                if(action === 'article'){
                    console.info('게시글 신고');
                    $('#type').val('article');
                    $('#report-submit').click();
                }else if(action === 'reply'){
                    console.info('댓글 신고');
                    $('#type').val('reply');
                    $('#report-submit').click();
                }else if(action === 'member'){
                    console.info('유저 신고');
                    $('#type').val('member');
                    $('#report-submit').click();
                }
            }
        }else alert('동의하지 않으면 신청하실 수 없습니다.')
    });
    // 취소
    $('#report').click(e=>{
        if(!$(e.target).closest('.myModal-window').length || $(e.target).is('#modal-close, #btns-reportCancel')){
            $('#report').css('display', 'none');
        }
    });
});

// 로그인한 유저의 신고 확인
function reportCheck(report_id){
    console.info('신고 확인에서 아이디 : '+report_id);
    return fetch(`${contextPath}/board/share/isReport?report_id=${report_id}`)
    .then(response => response.json())
    .then(isReport => {
        if(isReport)
            alert('이미 신고 하셨습니다.');
        else
            $('#report').css('display', 'flex');
    })
    .catch(error => {
        console.error(error);
        throw error;
    });
}

// 이미지 에러 처리
$(() => {
    $('.article_content').find('img').error(e => {
        $(e.target).closest('img').attr('src', `${contextPath}/image/ShareGo_Not_Found_Image.png`);
    });
    $('.board-toggle').click(e => {
        let parent = $(e.target).closest('.board-summary');
        let children = parent.find('.board-summary-part');
        children.toggle();
    });
});