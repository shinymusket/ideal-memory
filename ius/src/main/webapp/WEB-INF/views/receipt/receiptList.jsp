<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/receipt/receiptList.js"></script>
<title>수납 관리</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/receipt/receiptList.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>수납 관리</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="원생 관리" onclick="location.href='../kinder/kinder_list'">
					</div>
					
					<div id="kinder_list" style="float: left;">
						<div id="searchDiv">
							<select id="searchType">
								<option value="kinder_num">원생 번호</option>
								<option value="kinder_name">원생 이름</option>
								<option value="class_name">학급명</option>
								<option value="staff_name">담당 교사</option>
							</select>
							<input type="text" id="searchContent">
							<input type="button" value="검색" id="searchBtn">
						</div>
						<div id="kinderBox">
							<table id="kinder_list_tbl" class="list" border="1"></table>
						</div>
					</div>
					
					<div id="receipt" style="float: left; display:none;">
						<div id="selectBts">
							<input type="date" id="date_from">
							<input type="date" id="date_to">
							<input type="button" value="조회" id="selectBtn"> 
						</div>
						
						<table id="receipt_tbl" class="paginated" border="1"></table>
						<table id="receipt_register_tbl" border="1">
							<tr>
								<th>원생명</th>
								<td>
									<input type="hidden" id="auth_info" name="auth_info">
									<input type="hidden" id="receipt_code" name="receipt_code">
									<input type="text" id="kinder_name" name="kinder_name" readonly="readonly" style='text-align : center;'>
									<input type="hidden" id="kinder_num" name="kinder_num">
								</td>
								<th colspan="2">가족 관계</th>
								<td>
									<select id="relation" name="relation">
										<option value="" id="basic">-선택-</option>
										<option value="부">부</option>
										<option value="모">모</option>
									</select>
								</td>
								<th>수납자</th>
								<td>
									<input type="text" id="parent_name" name="parent_name" readonly="readonly">
									<input type="hidden" id="parent_num" name="parent_num">
								</td>
							</tr>
							<tr>
								<th colspan="2" >수납 내용</th>
								<td colspan="6" >
									<input type="text" id="receipt_content" name="receipt_content">
								</td>
							</tr>
							<tr>
								<th colspan="2" >수납 금액</th>
								<td colspan="6">
									<input type="text" id="receipt_price" name="receipt_price">
								</td>
							</tr>	
							<tr>
								<td colspan="8">
									<input type="button" value="등록" id="register">
									<input type="button" value="삭제" id="delete">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>