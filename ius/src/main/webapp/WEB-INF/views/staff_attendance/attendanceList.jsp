<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
//만들어진 테이블에 페이지 처리
function page(){ 
	
	var reSortColors = function($table) {
	  $('tbody tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
	  $('tbody tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
	 };
	 $('table.paginated').each(function() {
	  var pagesu = 10;  //페이지 번호 갯수
	  var currentPage = 0;
	  var numPerPage = 15;  //목록의 수
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

//교직원별 근태 기록 가져오기
function getInfo(id, name) {
	var staff_id = id;
	var staff_name = name;
	$('input[name=staff_name]').attr('value', "");
	$('input[name=staff_name]').attr('value', staff_name);
	
	$.ajax({
		url : "/ius/staff_attendance/getInfo",
		type : "POST",
		data : {
			id : staff_id
		},
		success : function(data) {
			$("#attendanceInfo").text("");
			
			values = data.attendInfo;
			
			output = "<tr><th>일시</th><th>출결 정보</th><th>출근시간</th><th>퇴근시간</th></tr>";
			$.each(values, function(index, value) {
				
				attend_info = value.attend_info
				
				if (attend_info == "T") {
					attend_info = "출근";
				} else if (attend_info == "B") {
					attend_info = "결근";
				} else if (attend_info == "L") {
					attend_info = "지각";
				} else if (attend_info == "E") {
					attend_info = "조퇴";
				} else if (attend_info == "H") {
					attend_info = "휴가";
				};
				
				output += "<tr>";
				output += "<td>"+ value.attend_date +"</td>";
				output += "<td>"+ attend_info +"</td>";
				output += "<td>"+ value.in_time +"</td>";
				output += "<td>"+ value.out_time +"</td>";
				output += "</tr>";
			});
			
			$("#attendanceInfo").show();
			$("#attendanceInfo").html(output);
			$("#staff_id").val(staff_id);
			page();
		}
	})
	
};

	
	$(function() {	
	
		$("#search").click(function(){
			if ($("#date_from").val() == "") {
				alert("시작 일자를 설정해주세요.");
				return;
			};
			
			if ($("#date_to").val() == "") {
				alert("끝 일자를 설정해주세요.");
				return;
			};
			
			var staff_id = $("#staff_id").val();
			
			var objParams = {
					staff_id : staff_id,
					from : $("#date_from").val(),
					to : $("#date_to").val()
			}
			
			var values = [];
			
			$.post(
				"/ius/staff_attendance/getInfoByDate",
				objParams,
				function(retVal) {
					$("#attendanceInfo").text("");
					
					values = retVal.attendInfo;
					
					output = "<tr><th>일시</th><th>출결 정보</th><th>출근시간</th><th>퇴근시간</th></tr>";
					$.each(values, function(index, value) {
						
						attend_info = value.attend_info;
						
						if (attend_info == "T") {
							attend_info = "출근";
						} else if (attend_info == "B") {
							attend_info = "결근";
						} else if (attend_info == "L") {
							attend_info = "지각";
						} else if (attend_info == "E") {
							attend_info = "조퇴";
						} else if (attend_info == "H") {
							attend_info = "휴가";
						};
						
						output += "<tr>";
						output += "<td>"+ value.attend_date +"</td>";
						output += "<td>"+ attend_info +"</td>";
						output += "<td>"+ value.in_time +"</td>";
						output += "<td>"+ value.out_time +"</td>";	
					});
					
					$("#attendanceInfo").show();
					$("#attendanceInfo").html(output);
					$("#staff_id").val(staff_id);
					page();
					
				}
			)
		});
		
		
		
		
	})
	

</script>
</head>
<body>
	<%@include file="../include/header.jsp" %>
	<%@include file="../include/nav.jsp" %>

	<article>
		<!-- 왼쪽 소제목 박스 (타이틀 써 주시면 됩니다) -->
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>근태 관리</h3>
			</div>
	
			<!-- 오른쪽 기능 박스 (검색 등등 필요없으면 div 안에 내용 지워도 무방)-->
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div class="btns">
						<input type="button" value="교직원 관리" onclick="location.href='../staff/staff_list'">
					</div>
					
					<h2>근태 기록 조회</h2>
					<div class="btns">
						<input type="text" id="staff_name" name="staff_name" readonly="readonly">
						<input type="hidden" id="staff_id">
						<input type="date" id="date_from">
						<input type="date" id="date_to">
						<input type="button" id="search" value="조회">
					</div>
					
					<c:if test="${staffList != null}">
						<table style="float: left;" border="1">
							<tr>
								<th>사번</th>
								<th>교직원 이름</th>
								<th>직무</th>
							</tr>
							<c:forEach items="${staffList}" var="staff">
								<tr>
									<td>${staff.staff_num}</td>
									<td><a href="javascript:getInfo('${staff.staff_id}', '${staff.staff_name}');">${staff.staff_name}</a></td>
									<td>${staff.job_Kname}</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
					
					<table id="attendanceInfo" class="tbl paginated" style="float: left; display: none;" border="1"></table>
					
				</div>
			</section>
	</article> 

		
		
		
		
	<%@include file="../include/footer.jsp" %>
</body>
</html>