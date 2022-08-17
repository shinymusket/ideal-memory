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
<link type="text/css" rel="stylesheet" href="${path}/resources/css/equipment/equipmentList.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/equipment/equipmentList.js"></script>
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
					</div>	
					
					<div id="searchDiv">
						<form action="" method="POST">
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
								
							<input type="button" value="검색" id="searchBtn">
						</form>
					</div> 
									
					
					<table id="equipmentList" border="1" class="paginated">
					</table>
	
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>