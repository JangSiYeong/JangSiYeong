<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/musicModify.css">

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
				<%@include file="../includes/admin/header.jsp" %>
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>음악 상세</span></div>
                    <div class="admin_content_main">
                   
                   	  <form id="modifyForm" action="/admin/musicModify" method="post">
                   		<div class="form_section">
                   			<div class="form_section_title">
                   				<label>음악 번호</label>
                   			</div>
                   			<div class="form_section_content">
                   				<input class="input_block" name="musicId" readonly="readonly" value="<c:out value='${musicInfo.musicId }'></c:out>">
                   				
                   			</div>
                   		</div>                    
                   		<div class="form_section">
                   			<div class="form_section_title">
                   				<label>음악 제목</label>
                   			</div>
                   			<div class="form_section_content">
                   				<input name="musicTitle" value="<c:out value='${musicInfo.musicTitle }'></c:out>" >
                   				<span id="warn_musicTitle">음악 제목을 입력 해주세요.</span>
                   			</div>
                   		</div>
                   		<div class="form_section">
                   			<div class="form_section_title">
                   				<label>음악 가수</label>
                   			</div>
                   			<div class="form_section_content">
                   				<input name="musicSinger" value="<c:out value='${musicInfo.musicSinger }'></c:out>" >
                   				<span id="warn_musicSinger">음악 가수를 입력 해주세요.</span>
                   			</div>
                   		</div>
                   		<div class="form_section">
                   			<div class="form_section_title">
                   				<label>음악 가사</label>
                   			</div>
                   			<div class="form_section_content">
                   				<textarea name="musicLyrics" ><c:out value='${musicInfo.musicLyrics }'/></textarea>
                   				<span id="warn_musicLyrics">음악 가사를 입력 해주세요.</span>
                   			</div>
                   		</div>
                   		<div class="form_section">
                   			<div class="form_section_title">
                   				<label>음악 국가</label>
                   			</div>
                   			<div class="form_section_content">
                   				<select name="nationId" >
                   					<option value="none" disabled="disabled">=== 선택 ===</option>
                   					<option value="01" <c:out value=" ${musicInfo.nationId eq '01' ?'selected':''}"/>>국내</option>
                   					<option value="02" <c:out value=" ${musicInfo.nationId eq '02' ?'selected':''}"/>>국외</option>
                   				</select>
                   				<span id="warn_nationId">음악 국가를 선택해주세요.</span>
                   			</div>
                   		</div>
                   		
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">취소</button>
	                    		<button id="modifyBtn" class="btn modify_btn">수정</button>
	                    		<button id="deleteBtn" class="btn delete_btn">삭 제</button>
	                    	</div> 
	                    	
	                   </form>
                    </div>                    
                </div>
                
                <form id="moveForm" method="get">
                	<input type="hidden" name="musicId" value='<c:out value="${musicInfo.musicId }"/>'>
                	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
                	<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
                	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                </form>
				<%@include file="../includes/admin/footer.jsp" %>


</body>
<script>
let moveForm = $("#moveForm");
let modifyForm = $("#modifyForm");

/* 음악 관리 페이지 이동 버튼 */
$("#cancelBtn").on("click", function(e){
	
	e.preventDefault();
	
	$("input[name=musicId]").remove();
	moveForm.attr("action", "/admin/musicManage")
	moveForm.submit();
	
});

/* 음악 수정 버튼 작동 및 유효성 검사 */
$("#modifyBtn").on("click", function(e){

		let musicTitle = $(".form_section_content input[name='musicTitle']").val();
		let musicSinger = $(".form_section_content input[name='musicSinger']").val();
		let musicLyrics = $(".form_section_content textarea").val();		

		let	titleCk = false;
		let	SingerCk = false;
		let lyricsCk = false;		
		
		e.preventDefault();
		
		if(!musicTitle){
			$("#warn_musicTitle").css("display", "block");
		} else {
			$("#warn_musicTitle").css("display", "none");
			titleCk = true;
		}
		/* if(!musicSinger){
			$("#warn_musicSinger").css("display", "block");
		} else {
			$("#warn_musicSinger").css("display", "none");
			singerCk = true;
		}
		if(!musicLyrics){
			$("#warn_musicLyrics).css("display", "block");
		} else {
			$("#warn_musicLyrics").css("display", "none");
			lyricsCk = true;
		} */

		
		if(titleCk){
			modifyForm.submit();	
		} else {
			return false;
		}
		
		
		
	});

/* 삭제 버튼 */
$("#deleteBtn").on("click", function(e){
	e.preventDefault();
	let moveForm = $("#moveForm");
	moveForm.find("input").remove();
	moveForm.append('<input type="hidden" name="musicId" value="${musicInfo.musicId}">');
	moveForm.attr("action", "/admin/musicDelete");
	moveForm.attr("method", "post");
	moveForm.submit();
});
</script>

</html>