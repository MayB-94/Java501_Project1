/**
 * 
 */
// contextPath 할당
const contextPath = window.location.pathname.split('/')[0];
// 쪽지 작성
function writebox(){
    document.querySelector('.content-write').style.display = 'block';
    document.querySelector('.content-receiver').style.display = 'none';
    document.querySelector('.content-sender').style.display = 'none';
    document.querySelector('.content-storage').style.display = 'none';
    document.querySelector('.content-recycle').style.display = 'none';
}
// 받은 쪽지함
function receivebox(){
    document.querySelector('.content-write').style.display = 'none';
    document.querySelector('.content-receiver').style.display = 'block';
    document.querySelector('.content-sender').style.display = 'none';
    document.querySelector('.content-storage').style.display = 'none';
    document.querySelector('.content-recycle').style.display = 'none';
}

// 보낸 쪽지함
function sentbox(){
    document.querySelector('.content-write').style.display = 'none';
    document.querySelector('.content-receiver').style.display = 'none';
    document.querySelector('.content-sender').style.display = 'block';
    document.querySelector('.content-storage').style.display = 'none';
    document.querySelector('.content-recycle').style.display = 'none';
}

// 쪽지 보관함
function storagebox(){
    document.querySelector('.content-write').style.display = 'none';
    document.querySelector('.content-receiver').style.display = 'none';
    document.querySelector('.content-sender').style.display = 'none';
    document.querySelector('.content-storage').style.display = 'block';
    document.querySelector('.content-recycle').style.display = 'none';
}

// 휴지통
function recyclebox(){
    document.querySelector('.content-write').style.display = 'none';
    document.querySelector('.content-receiver').style.display = 'none';
    document.querySelector('.content-sender').style.display = 'none';
    document.querySelector('.content-storage').style.display = 'none';
    document.querySelector('.content-recycle').style.display = 'block';
}
// 쪽지 클릭 이벤트
$(()=>{
    let mes_id, mem_sender_id, mem_receiver_id;
    $('.list-title').click((e)=>{
        $(e.target).closest('.message-list').find('.list-content').toggle();
        if($(e.target).closest('.message-list').is('#list-receiver')){
            mes_id = $(e.target).closest('.message-list').find('input[name=mes_id]').val();
            mem_sender_id = $(e.target).closest('.message-list').find('input[name=mem_sender_id]').val();
            mem_receiver_id = $(e.target).closest('.message-list').find('input[name=mem_receiver_id]').val();
            $.ajax({
                url:`${contextPath}/message/read`,
                type:'POST',
                data:{
                    mes_id: mes_id, 
                    mem_sender_id: mem_sender_id, 
                    mem_receiver_id: mem_receiver_id},
                success: (data)=>{
                    if(data){
                        $(e.target).closest('.message-list').css('background-color', 'rgba(0, 0, 0, 0.1)');
                    }
                }
            });
        }
    });
});

// 답장
function messageReply(receiver_id, sender_id){
    writebox();
    document.querySelector('#mem_username').setAttribute('value', sender_id);
    document.querySelector('#mem_receiver_id').setAttribute('value', receiver_id);
    $('#mem_username').trigger('input');
}


// 삭제
function messageAction(action, mes_id, mem_sender_id, mem_receiver_id){
    if(action == 'storage'){
        confirmMessage = '보관 하시겠습니까?';
        successMessage = '보관 되었습니다.';
    }else if(action == 'recycle'){
        confirmMessage = '휴지통으로 이동 하시겠습니까?';
        successMessage = '휴지통으로 이동 되었습니다.';
    }else if(action == 'delete'){
        confirmMessage = '삭제 하시겠습니까?';
        successMessage = '삭제 되었습니다.';
    }
    if(confirm(confirmMessage)){
        $.ajax({
            url:`${contextPath}/message/${action}`,
            type:'POST',
            data:{
                mes_id: mes_id, 
                mem_sender_id: mem_sender_id, 
                mem_receiver_id: mem_receiver_id},
            success: (data)=>{
                if(data) {
                    alert(successMessage);
                    location.reload();
                }
            }
        });
    }
}


// 체크
$(()=>{
    let checked = false;
    $('#mem_username').on('input', ()=>{
        let mem_username = $('#mem_username').val();
        if(mem_username.length > 0){
            $.ajax({
                url:`${contextPath}/message/checkUser`,
                type:'POST',
                data:{mem_username: mem_username},
                success: (data)=>{
                    if(data > 0){
                        $('#mem_result').text('가능');
                        $('#mem_receiver_id').val(data);
                        checked = true;
                    }
                    else{
                        $('#mem_result').text('불가능');
                        checked = false;
                    }
                }
            })
        }
    });
    $('#writeForm').submit((e)=>{
        if(!checked) {
            e.preventDefault();
            alert('받는 사람이 존재하지 않습니다.')
        }
    });
});