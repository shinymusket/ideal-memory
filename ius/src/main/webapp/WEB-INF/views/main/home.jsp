<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css?">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function getInfo() {
		let today = new Date();
		let year = today.getFullYear();
		let month = today.getMonth() + 1;
		let date = today.getDate();
		let day = today.getDay();
		
		var today_date = year + "/" + month + "/" + date;
		
		$.ajax({
			url : "/ius/main/get_Info",
			type : "POST",
			data : {
				today_date : today_date
			},
			success : function(data) {
				// 공지사항 정보 받아오기
				$("#noticeTbl").text("");
				values = data.noticeList;
				output = "";
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td id='notice_title_td'><a href='../notice/notice_info?notice_num=" + value.notice_num + "'>" + value.notice_title + "</a></td>";
					output += "<td id='notice_writeDate'>" + value.notice_writeDate + "</td>";
					output += "</tr>";
				});
				$("#noticeTbl").html(output);
				
				// 오늘의 일정 정보 받아오기
				$("#eventTbl").text("");
				values = data.eventList;
				if (values.length > 0) { // 행사 일정 데이터가 있으면
					output = "";
				} else {
					output = "<tr><td><p>일정이 없습니다.</p></td></tr>";
				}
				
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td id='event_title_td'>" + value.event_name + "</td>";
					output += "</tr>";
				});
				$("#eventTbl").html(output);
				
				// 오늘의 식단 정보 받아오기
				// 알러지 정보가 있는 식단은 파랑색 글씨로 출력하고, 알러지 정보가 있고 해당 알러지 학생이 있는 경우는 빨간색 글씨로 출력
				$(".menuInfo").remove();
				values = data.mealList;
				$.each(values, function(index, value) {
					if (value.meal_code == "B") { // 오전 간식
						if (value.allergy_num != null) {
							$("#breakDesert").append("<tr class='menuInfo'><td><span class='allergy'>" + value.meal_menu + "</span></td></tr>");
						} else {
							$("#breakDesert").append("<tr class='menuInfo'><td>" + value.meal_menu + "</td></tr>");
						}	
						
					} else if (value.meal_code == "L") { // 점심
						if (value.allergy_num != null) {
							$("#lunch").append("<tr class='menuInfo'><td><span class='allergy'>" + value.meal_menu + "</span></td></tr>");
						} else {
							$("#lunch").append("<tr class='menuInfo'><td>" + value.meal_menu + "</td></tr>");
						}	
					
					} else if (value.meal_code == "S") { // 오후 간식
						if (value.allergy_num != null) {
							$("#afterDesert").append("<tr class='menuInfo'><td><span class='allergy'>" + value.meal_menu + "</span></td></tr>");
						} else {
							$("#afterDesert").append("<tr class='menuInfo'><td>" + value.meal_menu + "</td></tr>");
						}	
					}
					
				});
				
				
			}
		});
		
		
		
		
		
		
	}

	getInfo();
</script>
</head>
<style>
	.mainDiv {
		border : 3px solid #cfd8dc;
		width : 700px;
		height : 300px;
		float : left;
		margin : 10px; 
	}
	
	.mainDiv h1.title {
		text-align : center;
		line-height : 1.5;
		width : 100%;
		height : 30px;
		color : white;
		background-color : #486890;
	}
	
	.mainDiv h1.title:hover {
		color : blue;;
	}
	
	.contentDiv {
		margin : 30px 15px;
	}
	
	#noticeTbl {
		width : 660px;
	}
	
	#noticeTbl #notice_writeDate {
		text-align : right;
	}
	
	#noticeTbl #notice_title_td a:hover {
		text-decoration: underline;
	}
	
	#eventTbl {
		width : 660px;
		text-align : center;
		font-weight: bolder;
	}
	
	#eWorkCountTbl {
		width : 660px;
	}
	
	#eWorkCountTbl th.litteTitle {
		text-align : right;
		width : 600px;
	}
	
	#mealMenuTbl {
		width : 660px;
		height : 190px;
	}
	
	#mealMenuTbl .menuType {
		width : 350px;
	}
	
	#mealMenuTbl tr.menuInfo span.allergy {
		color : blue;
	}
	
	
	
</style>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>

	<article>
			<div id="title_bar">
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div class="mainDiv" id="notice">
						<a href="../notice/notice_list"><h1 class="title">공지사항</h1></a>
						<div class="contentDiv">
							<table id="noticeTbl"></table>
						</div>
					</div>
					<div class="mainDiv" id="event">
						<a href="../event/event_list"><h1 class="title">오늘의 일정</h1></a>
						<div class="contentDiv">
							<table id="eventTbl"></table>
						</div> 
					</div>
					<div class="mainDiv" id="eWork">
						<a href="#"><h1 class="title">전자결재</h1></a>
						<div class="contentDiv">
							<table id="eWorkCountTbl">
								<tr>
									<th class="litteTitle">결재 대기중인 문서 :</th>
									<td>0건</td>
									
								</tr>
								<tr>
									<th class="litteTitle">결재중인 문서 :</th>
									<td>0건</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="mainDiv" id="meal">
						<a href="../meal/meal_list"><h1 class="title">오늘 식단</h1></a>
						<div class="contentDiv">
							<table id="mealMenuTbl">
								<tr id='breakDesert'><th class="menuType">오전 간식</th></tr>
								<tr id='lunch'><th class="menuType">점심</th></tr>
								<tr id='afterDesert'><th class="menuType">오후 간식</th></tr>
							</table>
						</div>
					</div>	
				</div>
			</section>
	</article>	

<%@include file="../include/footer.jsp" %>
</body>
</html>