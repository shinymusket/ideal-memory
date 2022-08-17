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
<script type="text/javascript" src="${path}/resources/js/finance/finance_update_form.js"></script>
<title>재정 내역 수정</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/finance/financeRegisterForm.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>재정 내역 수정</h3>
			</div>
	
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록" onclick="location.href='../finance/finance_list'">
					
					<form action="./finance_update" method="POST">
						<table border="1" id="financeRegisterTbl">
							<tr>
								<th>재정 코드</th>
								<td>
									<input type="text" name="finance_num" id="finance_num" value="${finance.finance_num}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>회계 년도</th>
								<td>
									<input type="number" name="finance_eYear" id="finance_eYear" value="${finance.finance_eYear}">
								</td>
							</tr>
							<tr>
								<th>예산 항목</th>
								<td>
									<select name="budget_num" id="budget_num">
										<option value="">-선택-</option>
										<c:if test="${budgetList != null}">
											<c:forEach items="${budgetList}" var="budget">
												<c:if test="${budget.budget_num == finance.budget_num}">
													<option value="${budget.budget_num}" selected="selected">${budget.budget_cls}</option>
												</c:if>
												<c:if test="${budget.budget_num != finance.budget_num}">
													<option value="${budget.budget_num}">${budget.budget_cls}</option>
												</c:if>
											</c:forEach>					
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<th>교직원명</th>
								<td>
									<input type="hidden" id="staff_num" name="staff_num" readonly="readonly" value="${staffInfo.staff_num}">
									<input type="text" id="staff_name" name="staff_name" readonly="readonly" value="${staffInfo.staff_name}">
								</td>
							</tr>
							<tr>
								<th>집행 날짜</th>
								<td>
									<input type="date" name="finance_eDate" id="finance_eDate" value="${finance.finance_eDate}">
								</td>
							</tr>
							<tr>
								<th>항목</th>
								<td>
									<input type="text" name="finance_cls" id="finance_cls" value="${finance.finance_cls}">
								</td>
							</tr>
							<tr>
								<th>구분</th>
								<td>
									<c:if test="${finance.finance_iE == 'In'}">
										수입
										<input type="hidden" name="finance_iE" id="finance_iE" value="In">
									</c:if>
									<c:if test="${finance.finance_iE == 'Ex'}">
										지출
										<input type="hidden" name="finance_iE" id="finance_iE" value="Ex">
									</c:if>
									
								</td>	
							</tr>
							<tr>
								<th>집행 금액</th>
								<td>
									<input type="text" name="finance_amount" id="finance_amount" value="${finance.finance_amount}">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" id="update" value="등록">
									<input type="reset" value="취소">
								</td>
							</tr>
						</table>
					</form>
				</div>
			</section>
	</article>	
	

<%@include file="../include/footer.jsp" %>	
</body>
</html>