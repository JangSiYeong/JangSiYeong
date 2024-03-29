<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/musicManage.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
</head>
<body>
 
   				 <%@include file="../includes/admin/header.jsp" %>
   				 
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>음악 관리</span></div>
                    <div class="music_table_wrap">
                   	  <!-- 게시물 O -->
					  <c:if test="${listCheck != 'empty' }">
                    	<table class="music_table">
                    		<thead>
                    			<tr>
                    				<td class="th_column_1">음악 번호</td>
                    				<td class="th_column_2">음악 제목</td>
                    				<td class="th_column_3">음악 가수</td>
                    				<td class="th_column_4">음악 국가</td>
                    
                    			</tr>
                    		</thead>
                    		<c:forEach items="${list}" var="list">
                    		<tr>
                    			<td><c:out value="${list.musicId}"></c:out> </td>
                    			<td>
                    				<a class="move" href='<c:out value="${list.musicId}"/>'>
                    					<c:out value="${list.musicTitle}"></c:out>
                    				</a> 	
                    				
                    			</td>
                    			<td><c:out value="${list.musicSinger}"></c:out> </td>
                    			<td><c:out value="${list.nationId}"></c:out> </td>
                    		
                    		</tr>
                    		</c:forEach>
                    	</table> 
                      </c:if> 
                       
                      <!-- 게시물 X -->
                      <c:if test="${listCheck == 'empty'}">
                			<div class="table_empty">
                				등록된 음악이 없습니다.
                			</div>
                	  </c:if>  
                	               			
                    </div>                    
                
                
                <!-- 검색 영역 -->
                    <div class="search_wrap">
                    	<form id="searchForm" action="/admin/musicManage" method="get">
                    		<div class="search_input">
                    			<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
                    			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
                    			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
                    			<button class='btn search_btn'>검 색</button>
                    		</div>
                    	</form>
                    </div>
                    
                <!-- 페이지 이동 인터페이스 영역 -->
                    <div class="pageMaker_wrap" >
                    
	                    <ul class="pageMaker">
	                    
	                    	<!-- 이전 버튼 -->
	                    	<c:if test="${pageMaker.prev}">
	                    		<li class="pageMaker_btn prev">
	                    			<a href="${pageMaker.pageStart - 1}">이전</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    	<!-- 페이지 번호 -->
	                    	<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
	                    		<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
	                    			<a href="${num}">${num}</a>
	                    		</li>
	                    	</c:forEach>
	                    	
	                    	<!-- 다음 버튼 -->
	                    	<c:if test="${pageMaker.next}">
	                    		<li class="pageMaker_btn next">
	                    			<a href="${pageMaker.pageEnd + 1 }">다음</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    </ul>
	                    
                    </div> 
                    
                    <form id="moveForm" action="/admin/musicManage" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>   
                    
                </div>
                
                <%@include file="../includes/admin/footer.jsp" %>
 
</body>

<script>

let moveForm = $('#moveForm');
let searchForm = $('#searchForm');

$(document).ready(function(){
    
	let result = '<c:out value="${enroll_result}"/>';
    
    checkResult(result);
    
    function checkResult(result){
        
        if(result === ''){
            return;
        }
        
        alert("음악'${enroll_result}' 을 등록하였습니다.");
        
    }
    
    /* 삭제 결과 경고창 */
	let delete_result = '${delete_result}';
	
	if(delete_result == 1){
		alert("삭제 완료");
	}
 
});

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
    
    e.preventDefault();
    
    moveForm.find("input[name='pageNum']").val($(this).attr("href"));
    
    moveForm.submit();
    
});

/* 음악 검색 버튼 동작 */
$("#searchForm button").on("click", function(e){
	
	e.preventDefault();
	
	/* 검색 키워드 유효성 검사 */
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하십시오");
		return false;
	}
	
	searchForm.find("input[name='pageNum']").val("1");
	
	searchForm.submit();
	
});

/* 음악 상세 페이지 이동 */
$(".move").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.append("<input type='hidden' name='musicId' value='"+ $(this).attr("href") + "'>");
	moveForm.attr("action", "/admin/musicDetail");
	moveForm.submit();
	
});

let mresult = '<c:out value="${modify_result}"/>';

checkmResult(mresult);

function checkmResult(mresult){
	
	if(mresult === '1'){
		alert("음악 정보 수정을 완료하였습니다.");
	} else if(mresult === '0') {
		alert("음악 정부 수정을 하지 못하였습니다.")	
	}
	
}
</script>
</html>