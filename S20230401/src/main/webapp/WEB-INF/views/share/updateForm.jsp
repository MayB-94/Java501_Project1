<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/preset.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나눔해요 글 수정 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/layout.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/quill.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-resize.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/quill/image-drop.min.js"></script>
<script type="text/javascript">

	function updateAction () {
		if ($('#article-title').val() == '' || $('#article-title').val() == null) {
			return false;
		}
		if ($('#art_content').val() == '' || $('#art_content').val() == null) {
			return false;
		}
		for (let i = 1; i <= 5; i++) $('#art_tag' + i).removeAttr('value');
		let tagIndex = 1;
		$('.tag-box-tag').each((index, value) => {
			let tag = $(value).find('.tag-box-tag-value').html();
			$('#art_tag' + tagIndex++).val(tag);
		});
		return true;
	}
	const quillInit = (id) => {
		let fontArray = [];
		for (let i = 8; i <= 30; i++) fontArray[fontArray.length] = i + 'px';
		var Size = Quill.import('attributors/style/size');
		Size.whitelist = fontArray;
		Quill.register(Size, true);
		var option = {
			modules: {
				toolbar: [
						[{size: fontArray}],
						[{'color': [
							'#FFFFFF', '#FF0000', '#FFFF00', '#00FF00', '#00FFFF', '#0000FF', '#FF00FF',
							'#E0E0E0', '#E00000', '#E0E000', '#00E000', '#00E0E0', '#0000E0', '#E000E0',
							'#C0C0C0', '#C00000', '#C0C000', '#00C000', '#00C0C0', '#0000C0', '#C000C0',
							'#A0A0A0', '#A00000', '#A0A000', '#00A000', '#00A0A0', '#0000A0', '#A000A0',
							'#808080', '#800000', '#808000', '#008000', '#008080', '#000080', '#800080',
							'#606060', '#600000', '#606000', '#006000', '#006060', '#000060', '#600060',
							'#404040', '#400000', '#404000', '#004000', '#004040', '#000040', '#400040',
							'#202020', '#200000', '#202000', '#002000', '#002020', '#000020', '#200020',
							'#000000', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'
						]}],
						['bold', 'italic', 'underline', 'strike'],
						['image', 'video', 'link'],
						[{list: 'ordered'}, {list: 'bullet'}]
				],
				imageResize: {
					displaySize: true
				},
				imageDrop: true
			},
			placeholder: '내용을 입력해주세요',
			theme: 'snow'
		};
		editor = new Quill('#' + id, option);
	};
	var editor;
	var observers = [];
	const setObserver = (target, index) => {
		const config = { attributes: true, childList: false, characterData: false };
		const tradeFix = (mutationList, observer) => {
			mutationList.forEach(mutation => {
				let tagType = $(mutation.target)[0].tagName.toUpperCase();
				let targetAttr = tagType == 'BUTTON' ? 'disabled' : 'readonly';
				if (mutation.attributeName == targetAttr && $(mutation.target).attr(targetAttr) == false) {
					$(mutation.target).attr(targetAttr, true);
				}
			});
		};
		const observer = new MutationObserver(tradeFix);
		observer.observe(target, config);
		observers.push({[index]: observer});
	};
	$(() => {
		// disable fix용 코드
		$('.trade-info-box').find('button, input, select').each((index, item) => {
			setObserver(item, index);
		});
		// tag loading 코드
		for (let i = 1; i <= 5; i++) {
			let tag_value = $('#art_tag' + i).val();
			if (!tag_value) continue;
			let elem = '<div class="tag-box-tag"><span class="tag-box-tag-value">' + tag_value + '</span><button class="tag-box-tag-remove adv-hover" type="button"><svg class="tag-box-tag-remove-svg" width="10" height="10" viewBox="0 0 12 12" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><path d="M 2 2 L 10 10 M 10 2 L 2 10"/></svg></button></div>';
			$('#tag-box').append(elem);
			$('#tag-box').find('div.tag-box-tag:last-child > button.tag-box-tag-remove').click(e => {
				$(e.target).parent().remove();
			});
		}
		// checkbox 이벤트
		$('#btns-checkbox').change(()=>{
			if($('#btns-checkbox').is(':checked')){
				$('#art_isnotice').val('1');
			}else{
				$('#art_isnotice').val('0');
			}
			console.info($('#art_isnotice').val());
		});
		// Load Editor
		quillInit('articleEditor');
		
		// 게시글 컨텐츠 로드
		let delta = editor.clipboard.convert($('#art_content').val());
		editor.setContents(delta, 'silent');
		
		// input keydown event
		$('form input').keydown(e => {
			if (e.keyCode == 13) e.preventDefault();
		});
		
		// Tag input Effects
		$('#tag-input').keydown(e => {
			if ($('#tag-box').find('.tag-box-tag').length >= 5 && e.keyCode != 8) {
				e.preventDefault();
				e.target.value = null;
				return;
			}
			if (e.keyCode == 32) {
				e.preventDefault();
				if (e.target.value == '' || !e.target.value || e.target.value == null) return;
				$(e.target).blur();
				e.target.value = null;
				$(e.target).focus();
			} else if (e.keyCode == 13) e.preventDefault();
			else if (e.keyCode == 8) {
				if (e.target.selectionStart == 0 && e.target.selectionEnd == 0) {
					$('#tag-box').find('div.tag-box-tag:last-child').remove();
					e.preventDefault();
				}
			}
		});
		$('#tag-input').blur(e => {
			if ($('#tag-box').find('.tag-box-tag').length >= 5) {
				e.target.value = null;
				return;
			}
			if (e.target.value == '' || !e.target.value || e.target.value == null) return;
			let elem = '<div class="tag-box-tag"><span class="tag-box-tag-value">' + e.target.value + '</span><button class="tag-box-tag-remove adv-hover" type="button"><svg class="tag-box-tag-remove-svg" width="10" height="10" viewBox="0 0 12 12" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><path d="M 2 2 L 10 10 M 10 2 L 2 10"/></svg></button></div>';
			$('#tag-box').append(elem);
			$('#tag-box').find('div.tag-box-tag:last-child > button.tag-box-tag-remove').click(e => {
				$(e.target).parent().remove();
			});
			e.target.value = null;
		});
		editor.on('text-change', () => {
			$('#art_content').val(editor.root.innerHTML);
		});
		const selectLocalImage = () => {
			const fileInput = document.createElement('input');
			fileInput.setAttribute('type', 'file');
			fileInput.click();
			fileInput.addEventListener('change', e => {
				const formData = new FormData();
				const file = fileInput.files[0];
				formData.append('uploadFile', file);
				
				$.ajax({
					type: 'post',
					enctype: 'multipart/form-data',
					url: '/board/share/imageUpload',
					data: formData,
					//data: fileInput.value,
					processData: false,
					contentType: false,
					dataType: 'json',
					success: function(data) {
						const range = editor.getSelection();
						//data.uploadPath = data.uploadPath.replace(/\\/g, '/');
						data.url = data.url.toString().replace(/\\/g, '/');
						editor.insertEmbed(range.index, 'image', data.url);
					}
				});
			});
		};
		editor.getModule('toolbar').addHandler('image', () => selectLocalImage());
	});
</script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/share/updateForm.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.core.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/quill/quill.snow.css">
</head>
<body>
	<main>
		<div class="container">
	
			<h1 class="color-subtheme text-align-center">게시글 수정</h1>
	
			<div>
				<form action="${pageContext.request.contextPath}/board/share/updateArticleForm" method="post" onsubmit="return updateAction();">
					<input type="hidden" 	name="category" 		value="${category}">
					<input type="hidden" 	name="art_id" 			value="${article.art_id}">
				<!-- 임시 기본값 저장 -->
					<input type="hidden" 	name="trade.trd_id" value="${article.trade.trd_id }">
					<input type="hidden" 	name="trade.trd_status" value="401">
					
					
					<div class="display-flex justify-content-space-between align-items-center">
						<div class="form-group display-flex justify-content-flex-start align-items-center">
							<label for="category" class="margin-right-5px">카테고리</label>
							<input name="brd_id" type="hidden" value="${article.brd_id }">
							<select name="brd_id" id="brd_id" disabled="disabled">
								<c:forEach var="comm" items="${categoryList}">
									<option value="${comm.comm_id}" ${article.brd_id == comm.comm_id? 'selected':''}>${comm.comm_value }</option>
								</c:forEach>
							</select>
						</div>
						
						
						
						<!-- 매니저 이상의 권한만 공지 설정 가능 -->
						<c:if test="${memberInfo.mem_authority >= 108}">
							<div class="form-group checkbox-group display-flex justify-content-flex-end align-items-center">
								<label for="btns-checkbox" class="margin-right-5px">공지 여부</label>
								<input type="hidden" id="art_isnotice" name="art_isnotice" value="0">
								<input type="checkbox" id="btns-checkbox" name="btns-checkbox">
							</div>
						</c:if>
					</div>
	
					<div class="form-group display-flex justify-content-flex-start align-items-center">
						<label for="article-title" class="margin-right-5px width-50px">제목</label>
						<input type="text" class="flex-grow-1" id="article-title" name="art_title" placeholder="제목" value="${article.art_title }" required="required">
					</div>
					
					<div class="form-group flex-grow-1 display-flex justify-content-flex-end align-items-center">
						<input type="hidden" id="art_tag1" name="art_tag1" value="${article.art_tag1 }">
						<input type="hidden" id="art_tag2" name="art_tag2" value="${article.art_tag2 }">
						<input type="hidden" id="art_tag3" name="art_tag3" value="${article.art_tag3 }">
						<input type="hidden" id="art_tag4" name="art_tag4" value="${article.art_tag4 }">
						<input type="hidden" id="art_tag5" name="art_tag5" value="${article.art_tag5 }">
						<label class="margin-right-5px width-50px">태그</label>
						<div class="input-box display-flex justify-content-flex-start align-items-center" style="border-bottom: 2.5px solid rgba(128, 128, 128, 0.5); margin: 0; flex-grow: 1;" onclick="$('#tag-input').focus();">
							<div id="tag-box">
								<!-- 태그들 들어갈 자리 -->
							</div>
							<input class="art_tag flex-grow-1" style="border-bottom: 0;" type="text" id="tag-input" name="tag-input" maxlength="10" placeholder="태그를 입력한 후 스페이스바를 눌러 추가하세요">
						</div>
					</div>
					
					<!-- 글 내용 -->
					<input type="hidden" id="art_content" name="art_content" value="<c:out value="${article.art_content }" escapeXml="true"/>" required>
					<div id="articleEditor"></div>
					
					<!-- 참가자 있을 시 수정 불가 안내 메시지 -->
					<c:if test="${isAnyoneJoined }">
						<p class="color-warning font-size-18px font-weight-bolder text-align-center">참가자가 있어 거래정보를 수정할 수 없습니다</p>
					</c:if>
					
					<!-- 거래 정보 -->
					<div class="trade-info-box padding-10px display-flex flex-direction-column justify-content-flex-start align-items-stretch" style="border: 2px solid var(--subtheme); border-radius: 5px;${isAnyoneJoined ? ' opacity: 0.5; pointer-events: none;' : ''}">
						<h2 class="text-align-center color-subtheme font-weight-bolder" style="margin: 10px; padding-bottom: 20px; border-bottom: 1px solid rgba(128, 128, 128, 0.5);">거래 정보</h2>
						<div class="display-flex justify-content-space-between align-items-center padding-10px">
							<div class="form-group" style="display: flex;">
								<div class="popup-group">
									<input type="hidden" id="reg_id" name="trade.reg_id" value="${article.trade.reg_id }">
									<label for="reg_id-button">지역 제한</label>
									<c:set var="selectedRegion" value=""/>
									<c:forEach var="region" items="${superRegions }">
										<c:if test="${region.reg_id == article.trade.reg_id }">
											<c:set var="selectedRegion" value="${region.reg_name }"/>
										</c:if>
										<c:forEach var="subRegion" items="${regions[region] }">
											<c:if test="${subRegion.reg_id == article.trade.reg_id }">
												<c:set var="selectedRegion" value="${subRegion.reg_name }"/>
											</c:if>
										</c:forEach>
									</c:forEach>
									<button type="button" id="region" name="reg_id-button" class="togglePopup theme-button" style="border-color: rgba(128, 128, 128, 0.5);" ${isAnyoneJoined ? 'disabled' : '' }>${selectedRegion }</button>
									<div id="region-popup" class="popup-window" style="bottom: 32px; right: auto; left: 81.28px; padding: 0;">
										<div style="position: relative;">
											<button type="button" class="subitem-header adv-hover" onclick="$('#reg_id').removeAttr('value'); $('#region').text(''); $('#region-popup').toggle();">없음</button>
										</div>
										<c:forEach var="region" items="${superRegions }">
											<div style="position: relative;">
												<button type="button" class="subitem-header adv-hover" onclick="$('#reg_id').val(${region.reg_id}); $('#region').text('${region.reg_name }'); $('#region-popup').toggle();">${region.reg_name }</button>
												<c:if test="${not empty regions[region] }">
													<div class="subitem-list">
														<button type="button" class="adv-hover" onclick="$('#reg_id').removeAttr('value'); $('#region').text(''); $('#region-popup').toggle();">없음</button>
														<c:forEach var="subRegion" items="${regions[region] }">
															<button type="button" class="adv-hover" onclick="$('#reg_id').val(${subRegion.reg_id}); $('#region').text('${subRegion.reg_name }'); $('#region-popup').toggle();">${subRegion.reg_name }</button>
														</c:forEach>
													</div>
												</c:if>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
							
							<div class="form-group flex-grow-1 margin-left-10px display-flex justify-content-flex-end align-items-center">
								<label for="trade_trd_loc" class="margin-right-5px">상세 지역</label>
								<input type="text" class="flex-grow-1" name="trade.trd_loc" placeholder="상세한 지역을 기입해주세요" value="${article.trade.trd_loc }" ${isAnyoneJoined ? 'readonly' : '' }>
							</div>
						</div>
						
						<div class="form-group display-flex justify-content-space-between align-items-center padding-10px">
							<div class="form-group display-flex justify-content-flex-start align-items-center">
								<label for="deadline" class="margin-right-5px">마감일</label>
								<fmt:formatDate var="dateValue" value="${article.trade.trd_enddate }" pattern="yyyy-MM-dd hh:mm:ss"/>
								<input type="datetime-local" name="trd_endDate" required="required" value="${dateValue }" ${isAnyoneJoined ? 'readonly' : '' }>
							</div>
							
							<div class="form-group display-flex justify-content-space-between align-items-center padding-10px">
								<label for="trade.trd_cost" class="margin-right-5px">비용</label>
								<input type="number" class="font-size-18px font-weight-bolder" name="trade.trd_cost" value="${article.trade.trd_cost == null ? 0 : article.trade.trd_cost }" min="0" required="required" ${isAnyoneJoined ? 'readonly' : '' }>
							</div>
						</div>
						
						<div class="form-group display-flex justify-content-space-between align-items-center padding-10px">
							<div class="form-group display-flex justify-content-flex-end align-items-center">
								<label for="max-people" class="margin-right-5px">최대 인원</label>
								<input type="number" class="width-50px" name="trade.trd_max" min="2" value="${article.trade.trd_max }" required="required" ${isAnyoneJoined ? 'readonly' : '' }>
							</div>
							
							<div class="form-gender display-flex justify-content-flex-start align-items-center">
								<label for="gender-limit" class="margin-right-5px">성별</label>
								<select name="trade.trd_gender" ${isAnyoneJoined ? 'disabled' : '' }>
									<option value="" ${article.trade.trd_gender == null ? 'selected' : '' }>제한 없음</option>
									<option value="201" ${article.trade.trd_gender == 201 ? 'selected' : '' }>남자</option>
									<option value="202" ${article.trade.trd_gender == 202 ? 'selected' : '' }>여자</option>
								</select>
							</div>
		
							<div class="form-age display-flex justify-content-flex-end align-items-center">
								<label for="age-limit" class="margin-right-5px">나이</label> 
								<input type="number" class="width-50px" name="trade.trd_minage" min="1" max="100" value="${article.trade.trd_minage }" ${isAnyoneJoined ? 'readonly' : '' }>
								<span class="margin-hor-5px font-weight-bolder">~</span>
								<input type="number" class="width-50px" name="trade.trd_maxage" min="1" max="100" value="${article.trade.trd_maxage }" ${isAnyoneJoined ? 'readonly' : '' }>
							</div>
						</div>
					</div>
	
					<div class="button-group">
						<button type="submit" class="btns-submit">작성</button>
						<button type="button" class="btns-cancel" onclick="location.href='${pageContext.request.contextPath}/board/share?category='+${category};">취소</button>
					</div>
				</form>
			</div>
		</div>
	</main>
</body>
</html>
<%@ include file="/WEB-INF/views/share/header.jsp" %>
<%@ include file="/WEB-INF/views/share/footer.jsp" %>