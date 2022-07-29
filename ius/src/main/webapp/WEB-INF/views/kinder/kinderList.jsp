<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function getList() {
	$.ajax({
		url : "/ius/kinder/get_kinder_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#kinderList").text("");
			values = data.kinderList;
			output = "<tr><th>원생 번호</th><th>셔틀 버스 호차</th><th>담임 교사</th><th>원아 이름</th><th>나이</th><th>생년 월일</th><th>성별</th><th>재원 여부</th><th>입소일</th></tr>";				
			$.each(values, function(index, value) {
				if (value.kinder_sex == "M") {
					kinder_sex = "남아";
				} else if (value.kinder_sex == "F") {
					kinder_sex = "여아";
				}
				
				if (value.kinder_regYn == "Y") {
					kinder_regYn = "재원";
				} else if (value.kinder_regYn == "N") {
					kinder_regYn = "퇴소";
				} else if (value.kinder_regYn == "P") {
					kinder_regYn = "휴원";
				} else if (value.kinder_regYn == "G") {
					kinder_regYn = "졸업";
				};
				
				
				
				output += "<tr>";
				output += "<td>" + value.kinder_num + "</td>";
				output += "<td>" + value.shuttle_num + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td><a href='../kinder/kinder_info?kinder_num=" + value.kinder_num + "'>" + value.kinder_name + "</a></td>";
				output += "<td>" + value.kinder_age + "세</td>";
				output += "<td>" + value.kinder_birth + "</td>";
				output += "<td>" + kinder_sex + "</td>";
				output += "<td>" + kinder_regYn + "</td>";
				output += "<td>" + value.kinder_regdate + "</td>";
				output += "</tr>";
			});
			
			$("#kinderList").html(output);
		}
		
	})
	
}
getList();

function changeSearchSelect(){
	var searchType = $("#searchType").val();
	
	if (searchType == "kinder_regYn") {
		$("#search_regYn").show();
		$("#searchDateFrom").hide();
		$("#searchDateTO").hide();
		$("#searchContent").hide();
	} else if ((searchType == "kinder_regdate") || (searchType == "kinder_retireDate")) {
		$("#searchDateFrom").show();
		$("#searchDateTO").show();
		$("#search_regYn").hide();
		$("#searchContent").hide();
	} else {
		$("#searchDateFrom").hide();
		$("#searchDateTO").hide();
		$("#search_regYn").hide();
		$("#searchContent").show();
	};
	

};


$(function(){
	$("#search").click(function(){
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		var search_regYn = $("#search_regYn").val();
		var searchDateFrom = $("#searchDateFrom").val();
		var searchDateTO = $("#searchDateTO").val();
		
		$.ajax({
			url : "/ius/kinder/search_kinder_list_by_searchType",
			type : "POST",
			data : {
				searchType : searchType,
				searchContent : searchContent,
				search_regYn : search_regYn,
				searchDateFrom : searchDateFrom,
				searchDateTO : searchDateTO	
			},
			success : function(data) {
				$("#kinderList").text("");
				values = data.kinderList;
				output = "<tr><th>원생 번호</th><th>셔틀 버스 호차</th><th>담임 교사</th><th>원아 이름</th><th>나이</th><th>생년 월일</th><th>성별</th><th>재원 여부</th><th>입소일</th></tr>";				
				$.each(values, function(index, value) {
					if (value.kinder_sex == "M") {
						kinder_sex = "남아";
					} else if (value.kinder_sex == "F") {
						kinder_sex = "여아";
					}
					
					if (value.kinder_regYn == "Y") {
						kinder_regYn = "재원";
					} else if (value.kinder_regYn == "N") {
						kinder_regYn = "퇴소";
					} else if (value.kinder_regYn == "P") {
						kinder_regYn = "휴원";
					} else if (value.kinder_regYn == "G") {
						kinder_regYn = "졸업";
					};
					
					
					
					output += "<tr>";
					output += "<td>" + value.kinder_num + "</td>";
					output += "<td>" + value.shuttle_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td><a href='../kinder/kinder_info?kinder_num=" + value.kinder_num + "'>" + value.kinder_name + "</a></td>";
					output += "<td>" + value.kinder_age + "세</td>";
					output += "<td>" + value.kinder_birth + "</td>";
					output += "<td>" + kinder_sex + "</td>";
					output += "<td>" + kinder_regYn + "</td>";
					output += "<td>" + value.kinder_regdate + "</td>";
					output += "</tr>";
				});
				
				$("#kinderList").html(output);
			}
			
		})
			
	});
	
	
})

	



</script>
<title>원생 관리</title>
</head>
<body>
	<h1>원생 관리</h1>
	<div class="btns">
		<input type="button" value="홈으로" onclick="location.href='../main/'">
		<input type="button" value="원생 등록" onclick="location.href='../kinder/kinder_register_form'">
	</div>
	<select name="searchType" id="searchType" onchange="changeSearchSelect()">
		<option value="kinder_num">원생 번호</option>
		<option value="staff_name">담임 교사</option>
		<option value="kinder_name">이름</option>
		<option value="shuttle_num">셔틀 버스 호차</option>
		<option value="kinder_regYn">재원 여부</option>
		<option value="kinder_regdate">입소일</option>
		<option value="kinder_retireDate">퇴소일</option>
	</select>
	
	<input type="text" name="searchContent" id="searchContent">
	<select name="search_regYn" id="search_regYn" style="display :none;">
		<option value="Y">재원</option>
		<option value="N">퇴원</option>
		<option value="P">휴원</option>
		<option value="G">졸업</option>
	</select>
	<input type="date" id="searchDateFrom" style="display :none;">
	<input type="date" id="searchDateTO" style="display :none;">
	<input type="button" value="검색" id="search">
	
	<table id="kinderList" border="1"></table>
</body>
</html>