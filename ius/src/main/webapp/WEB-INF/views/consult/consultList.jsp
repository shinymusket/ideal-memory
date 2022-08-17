<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/consult/consultList.js"></script>
<title>상담 일지</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/consult/consultList.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>상담 일지</h3>
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
							<div id="searchBts">
								<select id="searchType">
									<option value="kinder_num">원생 번호</option>
									<option value="kinder_name">원생 이름</option>
									<option value="class_name">학급명</option>
									<option value="staff_name">담당 교사</option>
								</select>
								<input type="text" id="searchContent">
								<input type="button" value="검색" id="searchBtn">
							</div>
						</div>
						
						<div id="kinderBox">
							<table id="kinder_list_tbl" class="list" border="1"></table>
						</div>
					</div>
					
					<div id="consult" style="float: left; display:none;">
						<div id="selectBts">
							<input type="date" id="date_from">
							<input type="date" id="date_to">
							<input type="button" value="조회" id="selectBtn"> 
						</div>
						
						<table id="consult_tbl" class="tbl paginated" border="1"></table>
						<table id="consult_register_tbl" border="1">
							<tr>
								<th>상담자</th>
								<td> <!-- 현재 로그인 되어 있는 아이디의 세션 값으로 가져오기 -->
									<input type="hidden" id="consult_code" name="consult_code">
									<input type="hidden" id="staff_name" name="staff_name" value="${staffInfo.staff_name}" readonly="readonly" style='text-align : center;'>
									<input type="hidden" id="staff_num" name="staff_num" value="${staffInfo.staff_num}">
									<input type="text" id="login_staff_name" value="${staffInfo.staff_name}" readonly="readonly">
									<input type="hidden" id="login_staff_num" value="${staffInfo.staff_num}">
								</td>
								<th>원생명</th>
								<td>
									<input type="text" id="kinder_name" name="kinder_name" readonly="readonly" style='text-align : center;'>
									<input type="hidden" id="kinder_num" name="kinder_num">
								</td>
								<th>내담자 가족 관계</th>
								<td>
									<select id="relation" name="relation">
										<option value="" id="basic">-선택-</option>
										<option value="부">부</option>
										<option value="모">모</option>
									</select>
								</td>
								<th>내담자</th>
								<td>
									<input type="text" id="parent_name" name="parent_name" readonly="readonly">
									<input type="hidden" id="parent_num" name="parent_num">
								</td>
							</tr>
							<tr>
								<th colspan="8" >상담 내용</th>
							</tr>	
							<tr>
								<td colspan="8">
									<textarea rows="8" cols="110" placeholder="상담 내용을 입력하세요." id="consult_content" name="consult_content"></textarea>
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