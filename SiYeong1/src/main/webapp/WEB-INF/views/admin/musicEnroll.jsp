<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/musicEnroll.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
 
    			<%@include file="../includes/admin/header.jsp" %>
                
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>음악 등록</span></div>
                    
                    <div class="admin_content_main">
                    	<form action="/admin/musicEnroll.do" method="post" id="enrollForm">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>음악 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="musicTitle">
                    				<span id="warn_musicTitle">음악 제목을 입력 해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>음악 가수</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="musicSinger" type="text">
                    				<span id="warn_musicSinger">음악 가수를 입력 해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>음악 가사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="musicLyrics" type="text">
                    				<span id="warn_musicLyrics">음악 가사를 입력 해주세요.</span>
                    			</div>
                    		</div>
                    		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>음악 국가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<select name="nationId">
                    					<option value="none" selected>=== 선택 ===</option>
                    					<option value="01">국내</option>
                    					<option value="02">국외</option>
                    				</select>
                    				<span id="warn_nationId">음악 국가를 선택해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
                    			</div>
                    			<div class="form_section_content">
									
                    			</div>
                    		</div>  
                    		
                   		</form>
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">취 소</button>
	                    		<button id="enrollBtn" class="btn enroll_btn">등 록</button>
	                    	</div> 
                    </div>
                </div>
                
                <%@include file="../includes/admin/footer.jsp" %>
 
</body>


<script>
 
/* 등록 버튼 */
$("#enrollBtn").click(function(){    
    /* 검사 통과 유무 변수 */
    let titleCheck = false;            // 음악 제목
    let singerCheck = false;            // 음악 가수
    let lyricsCheck = false;            // 음악 가사
    let nationCheck = false;       	    // 음악 국가
 
    /* 입력값 변수 */
    let musicTitle = $('input[name=musicTitle]').val();        // 제목
    let musicSinger = $('input[name=musicSinger]').val();        // 가수
    let musicLyrics = $('input[name=musicLyrics]').val();        // 가사
    let nationId = $('select[name=nationId]').val();        // 국가

    /* 공란 경고 span태그 */
    let wMusicTitle = $('#warn_musicTitle');
    let wMusicSinger = $('#warn_musicSinger');
    let wMusicLyrics = $('#warn_musicLyrics');
    let wNationId = $('#warn_nationId');

    
    /*  제목 공란 체크 */
    if(musicTitle ===''){
        wMusicTitle.css('display', 'block');
        titleCheck = false;
    } else{
        wMusicTitle.css('display', 'none');
        titleCheck = true;
    }
    /* 가수 공란 체크 */
    if(musicSinger ===''){
        wMusicSinger.css('display', 'block');
        singerCheck = false;
    } else{
        wMusicSinger.css('display', 'none');
        singerCheck = true;
    }
    /* 가사 공란 체크 */
    if(musicLyrics ===''){
        wMusicLyrics.css('display', 'block');
        lyricsCheck = false;
    } else{
        wMusicLyrics.css('display', 'none');
        lyricsCheck = true;
    }
    
    /* 소속 국가 공란 체크 */
    if(nationId ==='none'){
        wNationId.css('display', 'block');
        nationCheck = false;
    } else{
        wNationId.css('display', 'none');
        nationCheck = true;
    }    
       
    
    /* 최종 검사 */
    if(titleCheck && singerCheck && lyricsCheck && nationCheck ){
        $("#enrollForm").submit();    
    } else{
        return;
    }
    
});
 
/* 취소 버튼 */
$("#cancelBtn").click(function(){
    location.href="/admin/musicManage"
});
 
/* 이미지 업로드 */
$("input[type='file']").on("change", function(e){
	
	let formData = new FormData();
	let fileInput = $('input[name="uploadFile"]');
	let fileList = fileInput[0].files;
	let fileObj = fileList[0];

	/*
	if(!fileCheck(fileObj.name, fileObj.size)){
		return false;
	}
	*/
	
	formData.append("uploadFile", fileObj);
	
	$.ajax({
		url: '/admin/uploadAjaxAction',
    	processData : false,
    	contentType : false,
    	data : formData,
    	type : 'POST',
    	dataType : 'json',
    	success : function(result){
	    		console.log(result);
	    },
    	error : function(result){
    		alert("이미지 파일이 아닙니다.");
    	}
	});
});

/* var, method related with attachFile */
let regex = new RegExp("(.*?)\.(jpg|png)$");
let maxSize = 1048576; //1MB	

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
		  
	if(!regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	
	return true;		
	
}
 
</script>
</html>