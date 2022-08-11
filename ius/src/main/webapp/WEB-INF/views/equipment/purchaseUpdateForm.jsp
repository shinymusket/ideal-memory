<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	var currentDate  = new Date().toISOString().substring(0, 10);
	$("#purchase_date").val(currentDate);
	

    //키를 누르거나 떼었을때 이벤트 발생
    $("#purchase_price").bind('keyup keydown',function(){
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
    
    $("#finance_select").click(function(){
    	url = "./equipment_finance_select";
		window.open(url, "_blank_1", "toolbar=yes, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
    });
    
    $("#update").click(function(){
    	if($("#finance_num").val().trim() == "") {
    		alert("재정 코드를 선택해주세요.");
    		$("#finance_num").val().focus();
    		return;
    	};
    	
    	if($("#purchase_price").val().trim() == "") {
    		alert("구매 가격을 입력해주세요.");
    		$("#purchase_price").val().focus();
    		return;
    	};
    	
		value = cf_getNumberOnly ($("#purchase_price").val());
		$("#purchase_price").val(value);
		
		frm.submit();
    	
    });
    
   
})




</script>
<title>구매 정보 수정</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>구매 정보 수정</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
					
					<form name="frm" action="./purchase_update" method="POST">
						<table border="1">
							<tr>
								<th>구매 번호</th>
								<td>
									<input type="text" id="purchase_num" name="purchase_num" readonly="readonly" value="${purchase.purchase_num}"> 
								</td>
							<tr>
							<tr>
								<th>재정 코드</th>
								<td>
									<input type="text" id="finance_num" name="finance_num" value ="${purchase.finance_num}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>재정 항목</th>
								<td>
									<input type="text" id="finance_cls" name="finance_cls" value = "${purchase.finance_cls}" readonly="readonly">
									<input type="button" value="조회" id="finance_select">
								</td>
							</tr>
							<tr>
								<th>구매자</th>
								<td>
									<input type="text" id="staff_name" name="staff_name" value="${purchase.staff_name}" readonly="readonly">
									<input type="hidden" id="staff_num" name="staff_num" value="${purchase.staff_num}">
								</td>
							</tr>
							<tr>
								<th>자산번호</th>
								<td>
									<input type="text" id="equipment_num" name="equipment_num" readonly="readonly" value="${purchase.equipment_num}">
								</td>
							</tr>
							<tr>
								<th>자산 명</th>
								<td>
									<input type="text" id="equipment_name" name="equipment_name" readonly="readonly" value="${purchase.equipment_name}">
								</td>
							</tr>
							<tr>
								<th>구매 일자</th>
								<td>
									<input type="date" id="purchase_date" name="purchase_date" value="${purchase.purchase_date}">
								</td>
							</tr>
							<tr>
								<th>구매 가격</th>
								<td>
									<input type="text" id="purchase_price" name="purchase_price" value="${purchase.purchase_price}">
								</td>
							</tr>
							<tr>
								<th>구매 수량</th>
								<td>
									<input type="number" id="purchase_count" name="purchase_count" value="${purchase.purchase_count}" min="1">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" value="수정" id="update">
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