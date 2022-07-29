<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 등록</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		var currentDate  = new Date().toISOString().substring(0, 10);
		$("#equipment_regdate").val(currentDate);
		
		$("#equipment_cls_edit_btn").click(function(){
			url = "./equipment_class_edit";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
		});
		
		$("#register").click(function(){
			if ($("#equip_cls_num").val().trim() === "") {
				alert("분류 항목을 선택해주세요.");
				$("#equip_cls_num").val().focus();
				return;
			};
			if ($("#equipment_name").val().trim() === "") {
				alert("시설(비품) 명을 입력해주세요.")
				$("#equipment_name").val().focus();
				return;
			};
			
			if ($("#equipment_name").val().length > 10) {
				alert("시설(비품) 명은 10자이하여야 합니다.")
				$("#equipment_name").val().focus();
				return;	
			};
			
			frm.submit();
			
		});
		
	})

</script>
</head>
<body>
	<h1>시설(비품) 등록</h1>
	<input type="button" value="목록으로" onclick="location.href='../equipment/equipment_list'">
	
	<form action="./equipment_register" method="POST" name="frm">
		<table border="1">
			<tr>
				<th colspan="2">자산 번호</th>
				<td colspan="2">
					<input type="text" value="${seqNum}" name="equipment_num" id="equipment_num" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>등록자</th>
				<td>
					<input type="text" value="${staff_name}" name="staff_name" id="staff_name" readonly="readonly">
					<input type="hidden" value="${staff_id}" name="staff_id" id="staff_id">
				</td>
				<th>분류</th>
				<td>
					<input type="hidden" name="equip_cls_num" id="equip_cls_num">
					<input type="text" name="equip_cls_name" id="equip_cls_name" readonly="readonly">
					<input type="button" value="선택" id="equipment_cls_edit_btn">
				</td>
			</tr>
			<tr>
				<th>비품명</th>
				<td>
					<input type="text" name="equipment_name" id="equipment_name">
				</td>
				<th>수량</th>
				<td>
					<input type="number" name="equipment_count" id="equipment_count" min="1" value="1">
				</td>
			</tr>
			<tr>
				<th colspan="2">취득일자</th>
				<td colspan="2">
					<input type="date" name="equipment_regdate" id="equipment_regdate">
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="등록" id="register">
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>