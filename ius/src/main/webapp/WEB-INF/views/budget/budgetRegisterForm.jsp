<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		    //키를 누르거나 떼었을때 이벤트 발생
		    $("#budget_total").bind('keyup keydown',function(){
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
			if($("#budget_iE").val() == "") {
				alert("구분을 선택해주세요.");
				$("#budget_iE").val().focus();
				return;
			};
			
			if($("#budget_cls").val() == "") {
				alert("항목 명을 입력해주세요.");
				$("#budget_cls").val().focus();
				return;
			};
			
			if($("#budget_total").val() == "") {
				alert("총 금액을 입력해주세요.");
				$("#budget_total").val().focus();
				return;
			};
			
			
			value = cf_getNumberOnly ($("#budget_total").val());
			
			$("#budget_total").val(value);
			$("form").submit();
			
		});
		
		
		
		
		
	})

</script>
<title>예산 등록</title>
</head>
<body>
	<h1>예산 등록</h1>
	<form action="./budget_register" method="POST" name="frm">
		<table border="1">
			<tr>
				<th>예산 년도</th>
				<th>구분</th>
				<th>항목 명</th> <!-- 최대 8자 -->
				<th>총 금액</th>
			</tr>
			<tr>
				<td>
					<input type="number" name="budget_year" id="budget_year" min="2022" value="2022">
				</td>
				<td>
					<select name="budget_iE" id="budget_iE">
						<option value="">-선택-</option>
						<option value="In">수입</option>
						<option value="Ex">지출</option>
					</select>
				</td>
				<td>
					<input type="text" name="budget_cls" id="budget_cls">
				</td>
				<td>
					<input type="text" name="budget_total" id="budget_total">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="등록" id="register">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>