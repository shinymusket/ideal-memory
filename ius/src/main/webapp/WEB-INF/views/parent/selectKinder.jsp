<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function view(kinder_num) {
	var kinder_num = kinder_num;
	var kinder_name = $("#kinder_name").val();
	
	opener.frm.kinder_num.value = kinder_num;
	opener.frm.kinder_name.value = kinder_name;
	self.close();
	
	check();
};



$(function(){
	$("#search").click(function(){
		var kinder_name = $("#kinder_name").val();
	
		$.ajax({
			url : "/ius/parent/search_kinder",
			type : "POST",
			data : {
				kinder_name : kinder_name
			},
			success: function(data) {
				$("#kinderList").text("");
				values = data.kinderList;
				output = "<tr><th>원생 이름</th><th>학급</th><th>담임 교사</th></tr>";				
				$.each(values, function(index, value) {
		
					output += "<tr>";
					output += "<td><a href=\"javascript:view(" + value.kinder_num + ");\">" + value.kinder_name + "</a></td>";
					output += "<td>" + value.class_name + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "</tr>";
				});
				
				$("#kinderList").html(output);
			}
			
		})

	});
	
	
})

</script>
<title>원생 조회</title>
</head>
<body>
	<input type="text" id="kinder_name" placeholder="원생 명을 입력하세요.">
	<input type="button" value="조회" id="search">
	
	<table id="kinderList" border="1"></table>
</body>
</html>