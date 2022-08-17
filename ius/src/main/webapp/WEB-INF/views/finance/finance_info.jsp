<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 상세 보기</title>
<link rel="stylesheet" href="${path}/resources/css/articleF.css">
<link rel="stylesheet" href="${path}/resources/css/finance/financeInfo.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/finance/financeInfo.js"></script>
</head>
<body>
<%@include file="../include/header.jsp"%>
<%@include file="../include/nav.jsp"%>

<article>
	<!-- 왼쪽 소제목 박스 -->
	<div id="title_bar">
		<p>경영 정보</p>
		<h3>재정 상세 보기</h3>
	</div>

	<!-- 오른쪽 기능 박스 (검색)-->
	<div id="title_top">
	</div>
		<!-- 내용 구간 -->
	<section>
		<div id="content">
			<input type="button" value="목록" onclick="location.href='../finance/finance_list'">
			<input type="button" value="수정" id="update">
			<input type="button" value="삭제" id="delete">
			
			<table border="1">
				<tr>
					<th>재정 코드</th>
					<td>
						<input type="hidden" id="log_staff_num" value="${log_staff_num}">
						<input type="hidden" id="staff_num" value="${finance.staff_num}">
						<input type="text" readonly="readonly" id="finance_num" value="${finance.finance_num}">
					</td>
					<th>예산 항목</th>
					<td>${finance.budget_cls}</td>
				</tr>
				<tr>
					<th>교직원명</th>
					<td>${finance.staff_name}</td>
					<th>집행 날짜</th>
					<td>${finance.finance_eDate}</td>
				</tr>
				<tr>
					<th>항목</th>
					<td>${finance.finance_cls}</td>
					<th>구분</th>
					<td>
						<c:if test="${finance.finance_iE == 'In'}">
							수입				
						</c:if>
						<c:if test="${finance.finance_iE == 'Ex'}">
							지출				
						</c:if>
					</td>
				</tr>
				<tr>
					<th colspan="1">집행 금액</th>
					<td colspan="3">
						<fmt:formatNumber value="${finance.finance_amount}" maxFractionDigits="3"/>원
					</td>
				</tr>
		
				
				</table>
				
				<c:if test="${purchaseList != null}">
					<h3>재정 사용 내역</h3>
					<table border="1">
					
					<tr>
						<th>구매 번호</th>
						<th>구매자</th>
						<th>구매 자산명</th>
						<th>구매 일자</th>
						<th>구매 가격</th>
						<th>구매 수량</th>
					</tr>
					
					<c:forEach items="${purchaseList}" var="purchase">
						<tr>
							<td>${purchase.purchase_num}</td>
							<td>${purchase.staff_name}</td>
							<td>${purchase.equipment_name}</td>
							<td>${purchase.purchase_date}</td>
							<td>
								<fmt:formatNumber value="${purchase.purchase_price}" maxFractionDigits="3"/>원
							</td>
							<td>${purchase.purchase_count}</td>
						</tr>
					</c:forEach>
					</table>
					
					<table border="1">
						<tr>
							<th>총액</th>
							<th>지출액</th>
							<th>잔액</th>		
						</tr>
						<tr>
							<td>
								<fmt:formatNumber value="${finance.finance_amount}" maxFractionDigits="3"/>원
							</td>
							<td>
								<fmt:formatNumber value="${purchaseSum}" maxFractionDigits="3"/>원
							</td>
							<td>
								<fmt:formatNumber value="${finance.finance_amount - purchaseSum}" maxFractionDigits="3"/>원
							</td>
						</tr>
					</table>	
				</c:if>
				</div>
		</section>
	</article>
<%@include file="../include/footer.jsp" %>
</body>
</html>