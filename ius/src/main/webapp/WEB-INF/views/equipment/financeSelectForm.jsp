<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재정 코드 조회</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function getList() {
		$.ajax({
			url : "/ius/equipment/get_finance_list",
			type : "POST",
			data : {
				
			},
			success: function(data) {
				$("#financeList").text("");
				values = data.financeList;
				output = "<tr><th>재정 코드</th><th>회계 년도</th><th>예산 번호</th><th>항목 명</th><th></th></tr>";
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td>" + value.finance_num + "</td>";
					output += "<td>" + value.finance_eYear + "</td>";
					output += "<td>" + value.budget_num + "</td>";
					output += "<td>" + value.finance_cls + "</td>";
					output += "<td><a href=\"javascript:select('" + value.finance_num + "' , '" + value.finance_cls + "');\">선택</a></td>";
					output += "</tr>";
				});
				$("#financeList").html(output);
			}
		})
	};
	getList();
	
	function select(num, cls) {
		opener.frm.finance_num.value = num;
		opener.frm.finance_cls.value = cls;
		self.close();
	};
	

</script>
</head>
<body>
	<table border="1" id="financeList"></table>
</body>
</html>