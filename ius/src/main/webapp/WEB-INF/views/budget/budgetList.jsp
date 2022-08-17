<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/budget/budgetList.js"></script>
<title>예산 항목</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link type="text/css" rel="stylesheet" href="${path}/resources/css/budget/budgetList.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>예산 항목</h3>
			</div>
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<div id="controllBtns">
						<input type="button" value="재정 관리" onclick="location.href='../finance/finance_list'">
						<input type="button" value="항목 추가" id="register">
					</div>
					
					<div id="searchDiv">
						<select name="budget_year" id="budget_year">
							<option value="">--년도--</option>
							<c:if test="${budgetYearList != null}">
								<c:forEach items="${budgetYearList}" var="budgetYear">
									<option value="${budgetYear}">${budgetYear}년도</option>
								</c:forEach>	
							</c:if>
						</select>
						
						<select name="budget_type" id="budget_type">
							<option value="total" selected="selected">전체</option>
							<option value="In">수입</option>
							<option value="Ex">지출</option>
						</select>
						
						<input type="button" value="검색" id="yearSearch">
					</div>
					
					<table border="1" id="finalAccount">
						<tr>
							<th>년도</th>
							<th>총 수입</th>
							<th>총 지출</th>
							<th>잔액</th>
						</tr>
						<tr>
							<td id="budgetYear"></td>
							<td id="totalIncome"></td>
							<td id="totalExpense"></td>
							<td id="balance"></td>
						<tr>	
					</table>
				
					<table border="1" class="tbl paginated" id="list">
					</table>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>