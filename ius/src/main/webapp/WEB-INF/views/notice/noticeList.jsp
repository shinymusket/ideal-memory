<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
};

//만들어진 테이블에 페이지 처리
function page(){ 
	
	var reSortColors = function($table) {
	  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
	  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
	 };
	 $('table.paginated').each(function() {
	  var pagesu = 10;  //페이지 번호 갯수
	  var currentPage = 0;
	  var numPerPage = 20;  //목록의 수
	  var $table = $(this);    
	  
	  //length로 원래 리스트의 전체길이구함
	  var numRows = $table.find('tbody tr').length;
	  //Math.ceil를 이용하여 반올림
	  var numPages = Math.ceil(numRows / numPerPage);
	  //리스트가 없으면 종료
	  if (numPages==0) return;
	  //pager라는 클래스의 div엘리먼트 작성
	  var $pager = $('<td align="center" id="remo" colspan="10"><div class="pager"></div></td>');
	  
	  var nowp = currentPage;
	  var endp = nowp+10;
	  
	  //페이지를 클릭하면 다시 셋팅
	  $table.bind('repaginate', function() {
	  //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
	  
	   $table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
	   $("#remo").html("");
	   
	   if (numPages > 1) {     // 한페이지 이상이면
	    if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
	     nowp = 0;     // 1부터 
	     endp = pagesu;    // 10까지
	    }else{
	     nowp = currentPage -5;  // 6넘어가면 2부터 찍고
	     endp = nowp+pagesu;   // 10까지
	     pi = 1;
	    }
	    
	    if (numPages < endp) {   // 10페이지가 안되면
	     endp = numPages;   // 마지막페이지를 갯수 만큼
	     nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
	    }
	    if (nowp < 1) {     // 시작이 음수 or 0 이면
	     nowp = 0;     // 1페이지부터 시작
	    }
	   }else{       // 한페이지 이하이면
	    nowp = 0;      // 한번만 페이징 생성
	    endp = numPages;
	   }
	   // [처음]
	   $('<br /><span class="page-number" cursor: "pointer">[처음]</span>').bind('click', {newPage: page},function(event) {
	          currentPage = 0;   
	          $table.trigger('repaginate');  
	          $($(".page-number")[2]).addClass('active').siblings().removeClass('active');
	      }).appendTo($pager).addClass('clickable');
	    // [이전]
	      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[이전]&nbsp;</span>').bind('click', {newPage: page},function(event) {
	          if(currentPage == 0) return; 
	          currentPage = currentPage-1;
	    $table.trigger('repaginate'); 
	    $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	    // [1,2,3,4,5,6,7,8]
	   for (var page = nowp ; page < endp; page++) {
	    $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
	     currentPage = event.data['newPage'];
	     $table.trigger('repaginate');
	     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	     }).appendTo($pager).addClass('clickable');
	   } 
	    // [다음]
	      $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[다음]&nbsp;</span>').bind('click', {newPage: page},function(event) {
	    if(currentPage == numPages-1) return;
	        currentPage = currentPage+1;
	    $table.trigger('repaginate'); 
	     $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	    // [끝]
	   $('<span class="page-number" cursor: "pointer">&nbsp;[끝]</span>').bind('click', {newPage: page},function(event) {
	           currentPage = numPages-1;
	           $table.trigger('repaginate');
	           $($(".page-number")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
	   }).appendTo($pager).addClass('clickable');
	     
	     $($(".page-number")[2]).addClass('active');
	reSortColors($table);
	  });
	   $pager.insertAfter($table).find('span.page-number:first').next().next().addClass('active');   
	   $pager.appendTo($table);
	   $table.trigger('repaginate');
	 });
};

$(function(){
	function getList() { // 전체 공지사항 게시물 불러오기
		$.ajax({
			url : "/ius/notice/get_notice_list",
			type : "POST",
			data : {
				
			},
			success : function(data) {
				$("#noticeTbl").text("");
				values = data.noticeList;
				output = "<tr><th>번호</th><th>작성자</th><th>제목</th><th>작성일</th><th>조회수</th></tr>";
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td>" + value.notice_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td><a href='../notice/notice_info?notice_num=" + value.notice_num + "'>" + value.notice_title + "</a></td>";
					output += "<td>" + value.notice_writeDate + "</td>";
					output += "<td>" + value.notice_readCount + "</a></td>";
					output += "</tr>";
				});
				$("#noticeTbl").html(output);
				page();
			}
		});
	};
		
	getList();
	
	
	$("#register").click(function(){
		var master = getCookie("master");
		console.log(master);
		
		if (master == "N") {
			alert("권한이 없습니다.")
			return;
		} else if (master == "Y") {
			location.href='../notice/notice_register_form';
		}
	});

	$("#searchBtn").click(function(){ // 검색 기능
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		
		$.ajax({
			url : "/ius/notice/search_notice_list",
			type : "POST",
			data : {
				searchType : searchType,
				searchContent : searchContent
			},
			success : function(data) {
				$("#noticeTbl").text("");
				values = data.noticeList;
				
				if (values.length == 0) {
					alert("조회된 데이터가 없습니다.");
					
				} else {
					alert("성공적으로 데이터를 조회했습니다.");
					
					output = "<tr><th>번호</th><th>작성자</th><th>제목</th><th>작성일</th><th>조회수</th></tr>";
					$.each(values, function(index, value) {
						output += "<tr>";
						output += "<td>" + value.notice_num + "</td>";
						output += "<td>" + value.staff_name + "</td>";
						output += "<td><a href='../notice/notice_info?notice_num=" + value.notice_num + "'>" + value.notice_title + "</a></td>";
						output += "<td>" + value.notice_writeDate + "</td>";
						output += "<td>" + value.notice_readCount + "</a></td>";
						output += "</tr>";
					});
					$("#noticeTbl").html(output);
					page();
	
				}
	
			}
		});
		
	});
	
	
})
</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>그룹 웨어</p>
				<h3>공지사항</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="공지사항 등록" id="register">
					</div>
					
					<div id="search">
						<select id="searchType">
							<option value="notice_num">글 번호</option>
							<option value="notice_title">글 제목</option>
							<option value="staff_name">작성자</option>
						</select>
						<input type="text" id="searchContent">
						<input type="button" id="searchBtn" value="검색">
					</div>
					
					<div id="notice">
						<table id="noticeTbl" border="1"></table>
					</div>
					
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>
</body>
</html>