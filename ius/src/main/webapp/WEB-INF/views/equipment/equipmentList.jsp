<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	/* function getList() {
		$.ajax({
			url : "/ius/equipment/get_equipment_list",
			type : "POST",
			data :  {
				
			},
			success: function(data) {
				$("#equipmentList").text("");
				values = data.equipmentList;

				output = "<tr><th>자산 번호</th><th>등록자</th><th>분류</th><th>비품명</th><th>수량</th><th>취득일자</th><th>구분</th></tr>";
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td>" + value.equipment_num + "</td>";
					output += "<td>" + value.staff_name + "</td>";

					output += "<td>" + value.equip_cls_name + "</td>";
					output += "<td><a href='../equipment/equipment_info?equipment_num=" + value.equipment_num + "'>" + value.equipment_name + "</a></td>";
					output += "<td>" + value.equipment_count + "</td>";
					output += "<td>" + value.equipment_regdate + "</td>";
					output += "<td>" + value.equipment_cate + "</td>";
					output += "</tr>";
				});
				
				$("#equipmentList").html(output);
			
			}
		})
	
	};

	getList(); */
	
	function getCookie(name) {	// 저장된 쿠키 가져오기
	    var nameEQ = name + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1,c.length);
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return null;
	}
	
	function changeSearchType() { // 검색타입 변환시
		
		var searchType = $("#searchType").val();
		
		if( searchType == "equip_cls_name") { // 검색 타입이 분류명인 경우.
			$("#searchContent").hide();
			$("#searchDate").hide();
			$("#equip_cls_num").show();
			$("#equipment_cate").hide();
		} else if (searchType == "equipment_regdate") { // 검색 타입이 취득날짜인 경우.
			$("#searchContent").hide();
			$("#searchDate").show();
			$("#equip_cls_num").hide();
			$("#equipment_cate").hide();
		} else if (searchType == "equipment_cate") { // 검색 타입이 구분인 경우.
			$("#searchContent").hide();
			$("#searchDate").hide();
			$("#equip_cls_num").hide();
			$("#equipment_cate").show();
		} else { // 그 외에
			$("#searchContent").show();
			$("#searchDate").hide();
			$("#equip_cls_num").hide();
			$("#equipment_cate").hide();
		};
	};
	
	
$(function(){
	$("#equipRegister").click(function(){ // 시설(비품) 등록시 시설 권한이 있는지 유무 체크확인.
		var facility = getCookie("facility");
	
		console.log(facility);
		
		if (facility == "N") { // 시설 권한이 없으면 등록 불가.
			alert("권한이 없습니다.");
		} else if (facility == "Y") { 
			location.href='../equipment/equipment_register_form';
		}
	});
	
	$("#purchaseRegister").click(function(){ // 구매품 등록시 시설 권한이 있는지 유무 체크확인.
		var facility = getCookie("facility");
	
		console.log(facility);
		
		if (facility == "N") { // 시설 권한이 없으면 등록 불가.
			alert("권한이 없습니다.");
		} else if (facility == "Y") { 
			location.href='../equipment/purchaseEquip_form'
		}
	});
	
	
})

</script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>시설(비품) 관리</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="시설(비품) 등록" id="equipRegister">
						<input type="button" value="구매품 등록" id="purchaseRegister">
						<input type="button" value="구매기록 조회" onclick="location.href='../equipment/purchase_list'">
						
						<div id="searchArea">
							<form action="./equipment_search" method="POST">
								<select id="searchType" name="searchType" onchange="changeSearchType()">
									<option value="equipment_num">자산 번호</option>
									<option value="staff_name">등록자</option>
									<option value="equip_cls_name">분류</option>
									<option value="equipment_name">비품명</option>
									<option value="equipment_regdate">취득 일자</option>
									<option value="equipment_cate">구분</option>
								</select>
								<input type="text" id="searchContent" name="searchContent">
								<input type="date" id="searchDate" name="searchDate" style="display:none;">
								<select id="equip_cls_num" name="equip_cls_num" style="display:none;">
									<c:if test="${equipClsList != null}">
										<c:forEach items="${equipClsList}" var="equipCls">
											<option value="${equipCls.equip_cls_num}">${equipCls.equip_cls_name}</option>
										</c:forEach>
									</c:if>
								</select>
								<select id="equipment_cate" name="equipment_cate" style="display:none;">
									<option value="equipment">시설(비품)</option>
									<option value="purchase">구매품</option>
								</select>
									
								<input type="submit" value="검색">
							</form>
						</div> 
						
					</div>
					
					
					
					<table id="equipmentList" border="1">
						<tr>
							<th>자산 번호</th>
							<th>등록자</th>
							<th>분류</th>
							<th>비품명</th>
							<th>수량</th>
							<th>취득 일자</th>
							<th>구분</th>		
						</tr>
						<c:forEach items="${viewAll}" var="list">
							<tr>
								<td>${list.equipment_num}</td>
								<td>${list.staff_name}</td>
								<td>${list.equip_cls_name}</td>
								<td><a href="../equipment/equipment_info?equipment_num=${list.equipment_num}">${list.equipment_name}</a></td>
								<td>${list.equipment_count}</td>
								<td>${list.equipment_regdate}</td>
								<td>${list.equipment_cate}</td>
							</tr>					
						</c:forEach>	
					</table>
					
					<div style="display : block; text-algin: center;">
							<c:if test="${paging.startPage != 1 }">
								<a href="../equipment/equipment_list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
							</c:if>
							<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
								<c:choose>
									<c:when test="${p == paging.nowPage }">
										<b>${p }</b>
									</c:when>
									<c:when test="${p != paging.nowPage }">
										<a href="../equipment/equipment_list?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:if test="${paging.endPage != paging.lastPage}">
								<a href="../equipment/equipment_list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
							</c:if>
					</div>		
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>