<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 관리</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	function addComma(value){
		result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
        return result;
    };
		
	function getList() {
		$.ajax({
			url : "/ius/finance/get_finance_list",
			type : "POST",
			data : {
				
			},
			success: function(data) {
				$("#list").text("");
				values = data.financeList;
				output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 항목</th><th>교직원명</th><th>집행 날짜</th><th>항목</th><th>구분</th><th>집행 금액</th></tr>";				
				$.each(values, function(index, value) {
					
					if (value.finance_iE == 'In') {
						financeType = '수입';
					} else if (value.finance_iE == 'Ex') {
						financeType = '지출';
					}
					
					output += "<tr>";
					output += "<td>" + value.finance_num + "</td>";
					output += "<td>" + value.finance_eYear + "</td>";
					output += "<td>" + value.budget_cls + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.finance_eDate + "</td>";
					output += "<td><a href='../finance/finance_info?finance_num=" + value.finance_num + "'>" + value.finance_cls + "</a></td>";
					output += "<td>" + financeType + "</td>";
					output += "<td>" + addComma(value.finance_amount) + "</td>";
					output += "</tr>";
				});
				
				$("#list").html(output);
			}
			
		})
		
	}
	getList();
	
	$("#yearSearch").click(function(){
		if ($("#finance_year").val() == "") {
			alert("년도를 선택하세요.");
			$("#finance_year").val().focus();
			return;
		};
		
		financeYear = $("#finance_year").val();
		
		var objParams = {
				seachYear : $("#finance_year").val(),
				finance_type : $("#finance_type").val()
		}
		
		var values = [];
		
		$.post(
			"/ius/finance/get_finance_list_by_year",
			objParams,
			function(retVal) {
				$("#list").text("");
				$("#financeYear").text("");
				$("#totalIncome").text("");
				$("#totalExpense").text("");
				$("#balance").text("");
	
				values = retVal.financeList;
				totalIncome = retVal.totalIncome;
				totalExpense = retVal.totalExpense;
				balance = (totalIncome-totalExpense);
				
				output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 항목</th><th>교직원명</th><th>집행 날짜</th><th>항목</th><th>구분</th><th>집행 금액</th></tr>";				
				$.each(values, function(index, value) {
					if (value.finance_iE == 'In') {
						financeType = '수입';
					} else if (value.finance_iE == 'Ex') {
						financeType = '지출';
					}
					
					
					output += "<tr>";
					output += "<td>" + value.finance_num + "</td>";
					output += "<td>" + value.finance_eYear + "</td>";
					output += "<td>" + value.budget_cls + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "<td>" + value.finance_eDate + "</td>";
					output += "<td><a href='../finance/finance_info?finance_num=" + value.finance_num + "'>" + value.finance_cls + "</a></td>";
					output += "<td>" + financeType + "</td>";
					output += "<td>" + addComma(value.finance_amount) + "</td>";
					output += "</tr>";
				});
				
				$("#financeYear").html(financeYear);
				$("#totalIncome").html(addComma(totalIncome));
				$("#totalExpense").html(addComma(totalExpense));
				$("#balance").html(addComma(balance));
				$("#list").html(output);
			}
		)
	});
	
})
</script>
</head>
<body>
	<h1>재정 관리</h1>
	<select name="finance_year" id="finance_year">
		<option value="">--년도--</option>
		<c:if test="${financeYearList != null}">
			<c:forEach items="${financeYearList}" var="financeYear">
				<option value="${financeYear}">${financeYear}년도</option>
			</c:forEach>	
		</c:if>
	</select>
	
	<select name="finance_type" id="finance_type">
		<option value="total">전체</option>
		<option value="In">수입</option>
		<option value="Ex">지출</option>
	</select>
	
	<input type="button" value="검색" id="yearSearch">
	<br>
		
	<input type="button" value="홈으로" onclick="location.href='../main/'">
	<input type="button" value="예산 항목" onclick="location.href='../budget/budget_list'">
	<input type="button" value="수입 등록" onclick="location.href='../finance/finance_register_form?iE=In'">
	<input type="button" value="지출 등록" onclick="location.href='../finance/finance_register_form?iE=Ex'">
	
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
	
	<table border="1" id="list"></table>
	
	
	
	
	
	
<%--  	<table border="1">
		<tr>
			<th>총 수입</th>
			<th>총 지출</th>
			<th>잔액</th>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<c:if test="${financeList != null}">
		<table border="1">
				<tr>
					<th>재정 코드</th>
					<th>회계 년도</th>
					<th>예산 항목</th>
					<th>교직원명</th>
					<th>집행 날짜</th>
					<th>항목</th>
					<th>구분</th>
					<th>집행 금액</th>
				</tr>
		<c:forEach items="${financeList}" var="finance">
				<tr>
					<td>${finance.finance_num}</td>
					<td>${finance.finance_eYear}</td>
					<td>${finance.budget_cls}</td>
					<td>${finance.staff_name}</td>
					<td>${finance.finance_eDate}</td>
					<td>
						<a href="../finance/finance_info?finance_num=${finance.finance_num}">${finance.finance_cls}</a>
					</td>
					<td>
						<c:if test="${finance.finance_iE == 'In'}">
							수입
						</c:if>
						<c:if test="${finance.finance_iE == 'Ex'}">
							지출
						</c:if>
					</td>
					<td>
						<fmt:formatNumber value="${finance.finance_amount}" maxFractionDigits="3"/>
					</td>
				</tr>
		</c:forEach>
		</table>
	</c:if> --%>

</body>
</html>