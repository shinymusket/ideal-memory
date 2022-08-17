<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 관리</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/finance/financeList.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/finance/financeList.js"></script>
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>재정 관리</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="예산 항목" onclick="location.href='../budget/budget_list'">
						<input type="button" value="수입 등록" id="inRegister">
						<input type="button" value="지출 등록" id="exRegister">
					</div>
				
					<div id="search">
						<select name="finance_year" id="finance_year" onchange="select_finance_year()">
							<option value="">--년도--</option>
							<c:if test="${financeYearList != null}">
								<c:forEach items="${financeYearList}" var="financeYear">
									<option value="${financeYear}">${financeYear}년도</option>
								</c:forEach>	
							</c:if>
						</select>
						
						<select name="finance_type" id="finance_type" onchange="select_finance_type()">
							<option value="total">전체</option>
							<option value="In">수입</option>
							<option value="Ex">지출</option>
						</select>		
						
						<select name="search_type" id="search_type" onchange="select_search_type()">
							<option value="">미선택</option>
							<option value="finance_code">재정 코드</option>
							<option value="budget_name">예산 항목</option>
							<option value="finance_eDate">집행 날짜</option>
							<option value="finance_cls">항목명</option>
						</select>
						
						<input type="text" id="search_content" style="display : none;">
						
						<select id="budget_num" style="display : none;">	
						</select>
						
						<input type="date" id="search_date" style="display : none;">
						
						<input type="button" value="검색" id="searchBtn">		
					</div>
					
					<br>
					
					
					<table border="1" id="finalAccount">
						<tr>
							<th>회계 년도</th>
							<th>총 수입</th>
							<th>총 지출</th>
							<th>잔액</th>
						</tr>	
						<tr>
							<td id="financeYear"></td>
							<td id="totalIncome"></td>
							<td id="totalExpense"></td>
							<td id="balance"></td>
						</tr>
					</table>
					<table border="1" id="list" class="tbl paginated"></table>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>