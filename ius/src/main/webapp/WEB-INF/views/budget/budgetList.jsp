<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예산 항목</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		function addComma(value){
			result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
	        return result;
	    };
			
		function getList() {
			$.ajax({
				url : "/ius/budget/get_budget_list",
				type : "POST",
				data : {
					
				},
				success: function(data) {
					$("#list").text("");			
					values = data.budgetList;
					output = "<tr><th>예산 번호</th><th>년도</th><th>구분</th><th>항목</th><th>총액</th></tr>";				
					$.each(values, function(index, value) {
						
						if (value.budget_iE == 'In') {
							budgetType = '수입';
						} else if (value.budget_iE == 'Ex') {
							budgetType = '지출';
						}
						
						output += "<tr>";
						output += "<td>" + value.budget_num + "</td>";
						output += "<td>" + value.budget_year + "</td>";
						output += "<td>" + budgetType + "</td>";
						output += "<td><a href='../budget/budget_info?budget_num=" + value.budget_num + "'>" + value.budget_cls + "</a></td>";
						output += "<td>" + addComma(value.budget_total) + "</td>";
						output += "</tr>";
					});
					
					$("#list").html(output);
				}
				
			})
			
		}
		getList();
		
		$("#yearSearch").click(function(){
			if ($("#budget_year").val() == "") {
				alert("년도를 선택하세요.");
				$("#budget_year").val().focus();
				return;
			};
			
			budgetYear = $("#budget_year").val();
			
			var objParams = {
					seachYear : $("#budget_year").val(),
					budgetType : $("#budget_type").val()
			}
			
			var values = [];
			
			$.post(
				"/ius/budget/get_budget_list_by_year",
				objParams,
				function(retVal) {
					$("#list").text("");
					$("#budgetYear").text("");
					$("#totalIncome").text("");
					$("#totalExpense").text("");
					$("#balance").text("");
					
					values = retVal.budgetList;
					totalIncome = retVal.totalIncome;
					totalExpense = retVal.totalExpense;
					balance = (totalIncome-totalExpense);
		
					output = "<tr><th>예산 번호</th><th>년도</th><th>구분</th><th>항목</th><th>총액</th></tr>";				
					$.each(values, function(index, value) {
						if (value.budget_iE == 'In') {
							budgetType = '수입';
						} else if (value.budget_iE == 'Ex') {
							budgetType = '지출';
						}
						
						
						output += "<tr>";
						output += "<td>" + value.budget_num + "</td>";
						output += "<td>" + value.budget_year + "</td>";
						output += "<td>" + budgetType + "</td>";
						output += "<td><a href='../budget/budget_info?budget_num=" + value.budget_num + "'>" + value.budget_cls + "</a></td>";
						output += "<td>" + addComma(value.budget_total) + "</td>";
						output += "</tr>";
					});
					
					$("#budgetYear").html(budgetYear);
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
	<h1>예산 항목</h1>
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

	<br>
	<input type="button" value="홈으로" onclick="location.href='../main/'">
	<input type="button" value="재정" onclick="location.href='../finance/finance_list'">
	<input type="button" value="항목 추가" onclick="location.href='../budget/budget_register_form'">
	
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
	
	
	<table border="1" id="list">
		
	</table>
</body>
</html>