<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설(비품) 분류 항목 편집</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function view(viewNum) {
	var equip_cls_num = viewNum;
	
	$.ajax({
		url : "/ius/equipment/get_equip_cls_by_num",
		type : "POST",
		data : {
			equip_cls_num : equip_cls_num
		},
		success : function(data) {
			$("#equip_cls_num").val(data.equip_cls_num);
			$("#equip_cls_name").val(data.equip_cls_name);
		}
	})
};

function sel_btn(selNum) {
	var equip_cls_num = selNum;
	
	$.ajax({
		url : "/ius/equipment/get_equip_cls_by_num",
		type : "POST",
		data : {
			equip_cls_num : equip_cls_num
		},
		success : function(data) {
			opener.frm.equip_cls_num.value = data.equip_cls_num;
			opener.frm.equip_cls_name.value = data.equip_cls_name;
			$("#equip_cls_num").val(equip_cls_num);
			self.close();
		}
	})
	
};

	
	$(function(){
		function getList() {
			$.ajax({
				url : "/ius/equipment/get_equipment_cls_list",
				type : "POST",
				data :  {
					
				},
				success: function(data) {
					$("#equipClsList").text("");
					values = data.equipClsList;
					output = "<tr><th>번호</th><th>분류명</th><th></th></tr>";
					$.each(values, function(index, value) {
						
						output += "<tr>";
						output += "<td>" + value.equip_cls_num + "</td>";
						output += "<td><a href=\"javascript:view(" + value.equip_cls_num + ");\">" + value.equip_cls_name + "</td>";
						output += "<td><a href=\"javascript:sel_btn(" + value.equip_cls_num + ");\">선택</td>";
						output += "</tr>";
					});
					
					$("#equipClsList").html(output);
					
				}
			})
		};

		getList();
		
		$("#insert_btn").click(function(){
			if($("#equip_cls_name").val().trim() === "") {
				alert("분류 항목명을 입력하세요");
				$("#equip_cls_name").val("").focus();

			} else if($("#equip_cls_name").val().length > 10) {
				alert("분류 항목명은 10자이하여야 합니다.");
				$("#equip_cls_name").val().focus();

			} else {
				$.ajax({
					url: "/ius/equipment/insert_equipment_cls_list",
					type: "POST",
					data: {
						equip_cls_name : $("#equip_cls_name").val()
					},
					success: function() {
						$("#equip_cls_name").val("");
						getList();
					}
				})
			}
			
		});
		
		
		$("#delete_btn").click(function(){
			$.ajax({
				url: "/ius/equipment/delete_equipment_cls_list",
				type: "POST",
				data: {
					equip_cls_num : $("#equip_cls_num").val()
				},

				success: function(result) {
					
					if (result > 0) {
						alert("해당 항목의 데이터가 있어 삭제할 수 없습니다.");
					} else {
						$("#equip_cls_name").val("");
						$("#equip_cls_num").val("");
						getList();
					}	
				}
			})
		});
		

		$("#update_btn").click(function(){
			$.ajax({
				url: "/ius/equipment/update_equipment_cls_list",
				type: "POST",
				data: {
					equip_cls_num : $("#equip_cls_num").val(),
					equip_cls_name : $("#equip_cls_name").val()			
				},
				success: function(){
						$("#equip_cls_num").val("");
						$("#equip_cls_name").val("");
						getList();
				}
			})
		});
		
	})
	

</script>
</head>
<body>
	<table id="equipClsList" border="1"></table>
	<form>
		<input type="hidden" name="equip_cls_num" id="equip_cls_num">
		<input type="text" name="equip_cls_name" id="equip_cls_name" placeholder="분류 항목명">
		<input type="button" value="추가" id="insert_btn">
		<input type="button" value="수정" id="update_btn">
		<input type="button" value="삭제" id="delete_btn">
	</form>
</body>
</html>