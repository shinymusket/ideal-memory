<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 기록 조회</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};


function getList() {
	$.ajax({
		url : "/ius/equipment/get_purchase_list",
		type : "POST",
		data :  {
			
		},
		success: function(data) {
			$("#purchaseList").text("");
			values = data.purchaseList;
			output = "<tr><th>구매 번호</th><th>재정 코드</th><th>구매자</th><th>구매 자산 번호</th><th>구매 자산 명</th><th>구매 일자</th><th>구매 가격</th><th>구매 수량</th></tr>";
			$.each(values, function(index, value) {
				
				output += "<tr>";
				output += "<td>" + value.purchase_num + "</td>";
				output += "<td>" + value.finance_num + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td>" + value.equipment_num + "</td>";
				output += "<td><a href='../equipment/purchase_info?purchase_num=" + value.purchase_num + "'>" + value.equipment_name + "</a></td>";
				output += "<td>" + value.purchase_date + "</td>";
				output += "<td>" + addComma(value.purchase_price) + "</td>";
				output += "<td>" + value.purchase_count + "</td>";
				output += "</tr>";
			});
			
			$("#purchaseList").html(output);
		
		}
	})

};

getList();



</script>
</head>
<body>
	<h1>구매 기록 조회</h1>
	<input type="button" value="시설(비품) 관리" onclick="location.href='../equipment/equipment_list'">
	
	<table id="purchaseList" border="1">
	</table>
</body>
</html>