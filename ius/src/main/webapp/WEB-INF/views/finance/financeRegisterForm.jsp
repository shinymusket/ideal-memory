<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
    //키를 누르거나 떼었을때 이벤트 발생
    $("#finance_amount").bind('keyup keydown',function(){
        inputNumberFormat(this);
    });

    //입력한 문자열 전달
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    };
      
    //콤마찍기
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    };

    //콤마풀기
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    };

    //숫자만 리턴(저장할때)
    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
    function cf_getNumberOnly (str) {
        var len      = str.length;
        var sReturn  = "";

        for (var i=0; i<len; i++){
            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
                sReturn += str.charAt(i);
            }
        }
        return sReturn;
    };
    
    $("#register").click(function(){
    	if($("#finance_eYear").val() == "") {
			alert("회계 년도를 입력해주세요.");
			$("#finance_eYear").val().focus();
			return;
		};
    	
		if($("#budget_num").val() == "") {
			alert("예산 항목을 선택해주세요.");
			$("#budget_num").val().focus();
			return;
		};
		
		if($("#staff_num").val() == "") {
			alert("교직원 명을 입력해주세요.");
			$("#staff_num").val().focus();
			return;
		};
		
		if($("#finance_eDate").val() == "") {
			alert("집행 날짜를 입력해주세요.");
			$("#finance_eDate").val().focus();
			return;
		};
		
		if($("#finance_amount").val() == "") {
			alert("집행 금액을 입력해주세요.");
			$("#finance_amount").val().focus();
			return;
		};
		
		value = cf_getNumberOnly ($("#finance_amount").val());
		
		$("#finance_amount").val(value);
		$("form").submit();
		
	});

})
</script>
<title>재정 입력</title>
</head>
<body>
	<h1>
		<c:if test="${iE == 'In'}">
			수입 등록
		</c:if>
		<c:if test="${iE == 'Ex'}">
			지출 등록
		</c:if>
	</h1>
	<input type="button" value="목록" onclick="location.href='../finance/finance_list'">
	
	<form action="./finance_register" method="POST">
		<table border="1">
		<tr>
			<th colspan="2">재정 코드</th>
			<td colspan="2">
				<input type="text" name="finance_num" id="finance_num" value="${finance_num}" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>회계 년도</th>
			<td>
				<input type="number" name="finance_eYear" id="finance_eYear" value="2022">
			</td>
			<th>예산 항목</th>
			<td>
				<select name="budget_num" id="budget_num">
					<option value="">-선택-</option>
					<c:if test="${budgetList != null}">
						<c:forEach items="${budgetList}" var="budget">
							<option value="${budget.budget_num}">${budget.budget_cls}</option>
						</c:forEach>					
					</c:if>
				</select>
			</td>
		</tr>
		<tr>
			<th>[직원 코드]교직원명</th>
			<td>
				<select name="staff_num" id="staff_num">
					<option value="">-선택-</option>
					<c:if test="${staffList != null}">
						<c:forEach items="${staffList}" var="staff">
							<option value="${staff.staff_num}">[${staff.staff_num}]${staff.staff_name}</option> <!--동명이인이 있을 경우 어떻게 구분할 것인가? -->
						</c:forEach>
					</c:if>
				</select>
			</td>
			<th>집행 날짜</th>
			<td>
				<input type="text" placeholder="ex)20220721" name="finance_eDate" id="finance_eDate">
			</td>
		</tr>
		<tr>
			<th>항목</th>
			<td>
				<input type="text" name="finance_cls" id="finance_cls" >
			</td>
			<th>구분</th>
			<td>
				<c:if test="${iE == 'In'}">
					수입
					<input type="hidden" name="finance_iE" id="finance_iE" value="${iE}">
				</c:if>
				<c:if test="${iE == 'Ex'}">
					지출
					<input type="hidden" name="finance_iE" id="finance_iE" value="${iE}">
				</c:if>
				
			</td>	
		</tr>
		<tr>
			<th colspan="2">집행 금액</th>
			<td colspan="2">
				<input type="text" name="finance_amount" id="finance_amount">
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<input type="button" id="register" value="등록">
				<input type="reset" value="취소">
			</td>
		</tr>
	</table>
	</form>
</body>
</html>