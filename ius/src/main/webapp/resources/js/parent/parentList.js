function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function getList() {
	$.ajax({
		url : "/ius/parent/get_kinder_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#kinderList").text("");
			values = data.kinderList;
			output = "<tr><th>원생 이름</th></tr>";				
			$.each(values, function(index, value) {

				output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
				output += "<td>" + value.kinder_name + "</td>";
				output += "</tr>";
			});
			
			$("#kinderList").html(output);
		}
		
	})
	
}
getList();



function select_by_class() { // 반 별로 조회하기
	
	$("#kinderInfo").hide();
	
	$("#father").hide();
	$("#mather").hide();
	
	
	var class_number = $("#classNumber").val();
	
	if (class_number == "") { // 전체 조회.
		getList();
	
	} else {
		$.ajax({
			url : "/ius/parent/search_kinder_list_by_class",
			type : "POST",
			data : { 
				class_number : class_number
			},
			success: function(data) {
				$("#kinderList").text("");
				values = data.kinderList;
				output = "<tr><th>원생 이름</th></tr>";				
				$.each(values, function(index, value) {
		
					output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
					output += "<td>" + value.kinder_name + "</td>";
					output += "</tr>";
				});
				
				$("#kinderList").html(output);
			}
			
		})
	}
	
};


function view(kinder_num) {
		var kinder_num =  kinder_num;
		
		$.ajax({
			url : "/ius/parent/get_kinder_parent_info",
			type : "POST",
			data : {
				kinder_num : kinder_num
			},
			success: function(data) {
				$("#kinderInfo").hide();
				
				$("#father .update").show();
				$("#father .updateRegister").hide();
				$("#father .updateCancel").hide();
				
				$("#mather .update").show();
				$("#mather .updateRegister").hide();
				$("#mather .updateCancel").hide();
				
				$("#father").hide();
				$("#mather").hide();
				
				$("#kinder_num").val(kinder_num);
				$("#kinder_name").val(data.kinderInfo.kinder_name);
				$("#class_name").val(data.kinderInfo.class_name);
				$("#staff_name").val(data.kinderInfo.staff_name);
				$("#kinderInfo").show();
				
				if (data.fatherInfo != null) {
					$("#father .relation").val(data.fatherInfo.relation);
					$("#father .parent_name").val(data.fatherInfo.parent_name);
					$("#father .parent_tel").val(data.fatherInfo.parent_tel);
					$("#father .parent_email").val(data.fatherInfo.parent_email);
					$("#father .parent_sex").val(data.fatherInfo.parent_sex);
					$("#father .parent_birth").val(data.fatherInfo.parent_birth);
					$("#father").show();
				}
				
				if (data.matherInfo != null) {
					$("#mather .relation").val(data.matherInfo.relation);
					$("#mather .parent_name").val(data.matherInfo.parent_name);
					$("#mather .parent_tel").val(data.matherInfo.parent_tel);
					$("#mather .parent_email").val(data.matherInfo.parent_email);
					$("#mather .parent_sex").val(data.matherInfo.parent_sex);
					$("#mather .parent_birth").val(data.matherInfo.parent_birth);
					$("#mather").show();
				}
				
			}	
		})
};


$(function(){
	
	$("#father .delete").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "부";
		var master = getCookie("master");
		
		if (master == "N") { // 관리자 권한이 없는 경우
			alert("권한이 없습니다.");
			return;
		} else if (master == "Y") {
			var input = confirm('정말 삭제하시겠습니까?');
			if (input === true) {
				$("#father").hide();
				
				$.ajax({
					url : "/ius/parent/delete_parent_info",
					type : "POST",
					data : { 
						kinder_num : kinder_num,
						relation : relation
					},
					success: function(data) {
						alert('삭제가 완료되었습니다.');
						
						$("#kinderList").hide();
						getList();
						$("#kinderList").show();
					}
					
				})
				
				
			} else {
				alert("취소 되었습니다.");
			}
		}	
		
	});
	
	$("#mather .delete").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "모";
		var master = getCookie("master");
		
		if (master == "N") {
			alert("권한이 없습니다.");
			return;
		} else if (master == "Y") {
			var input = confirm('정말 삭제하시겠습니까?');
			if (input === true) {
				$("#mather").hide();
				
				$.ajax({
					url : "/ius/parent/delete_parent_info",
					type : "POST",
					data : { 
						kinder_num : kinder_num,
						relation : relation
					},
					success: function(data) {
						alert('삭제가 완료되었습니다.');
						
						$("#kinderList").hide();
						getList();
						$("#kinderList").show();
					}
					
				})
				
				
			} else {
				alert("취소 되었습니다.");
			}
		}

	});
	
	
	$("#father .update").click(function(){
		alert('수정할 정보를 입력 후 수정 정보 등록을 눌러주세요.');
		
		$("#father .relation").prop("disabled", true);
		$("#father .parent_name").prop("readonly", false);
		$("#father .parent_tel").prop("readonly", false);
		$("#father .parent_email").prop("readonly", false);
		$("#father .parent_sex").prop("disabled", true);
		$("#father .parent_birth").prop("readonly", false);
		
		$("#father .update").hide();
		$("#father .updateRegister").show();
		$("#father .updateCancel").show();

	});
	
	$("#mather .update").click(function(){
		alert('수정할 정보를 입력 후 수정 정보 등록을 눌러주세요.');
		
		$("#mather .relation").prop("disabled", true);
		$("#mather .parent_name").prop("readonly", false);
		$("#mather .parent_tel").prop("readonly", false);
		$("#mather .parent_email").prop("readonly", false);
		$("#mather .parent_sex").prop("disabled", true);
		$("#mather .parent_birth").prop("readonly", false);
		
		$("#mather .update").hide();
		$("#mather .updateRegister").show();
		$("#mather .updateCancel").show();

	});
	
	
	$("#father .updateCancel").click(function(){
		alert('수정이 취소되었습니다.');
		
		$("#father .relation").prop("disabled", false);
		$("#father .relation").prop("readonly", true);
		$("#father .parent_name").prop("readonly", true);
		$("#father .parent_tel").prop("readonly", true);
		$("#father .parent_email").prop("readonly", true);
		$("#father .parent_sex").prop("disabled", false);
		$("#father .parent_sex").prop("readonly", true);
		$("#father .parent_birth").prop("readonly", true);
		
		$("#father .update").show();
		$("#father .updateRegister").hide();
		$("#father .updateCancel").hide();
		
	});
	
	$("#mather .updateCancel").click(function(){
		alert('수정이 취소되었습니다.');
		
		$("#mather .relation").prop("disabled", false);
		$("#mather .relation").prop("readonly", true);
		$("#mather .parent_name").prop("readonly", true);
		$("#mather .parent_tel").prop("readonly", true);
		$("#mather .parent_email").prop("readonly", true);
		$("#mather .parent_sex").prop("disabled", false);
		$("#mather .parent_sex").prop("readonly", true);
		$("#mather .parent_birth").prop("readonly", true);
		
		$("#mather .update").show();
		$("#mather .updateRegister").hide();
		$("#mather .updateCancel").hide();
		
	});
	
	$("#father .updateRegister").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "부";
		var parent_name = $("#father .parent_name").val();
		var parent_tel = $("#father .parent_tel").val(); 
		var parent_email = $("#father .parent_email").val();
		var parent_sex = $("#father .parent_sex").val();
		var parent_birth = $("#father .parent_birth").val();
		
		$.ajax({
			url : "/ius/parent/update_parent_info",
			type : "POST",
			data : { 
				kinder_num : kinder_num,
				relation : relation,
				parent_name : parent_name,
				parent_tel : parent_tel,
				parent_email : parent_email,
				parent_sex : parent_sex,
				parent_birth : parent_birth
			},
			success: function(data) {
				alert('수정이 완료되었습니다.');
				
				$("#father .relation").prop("disabled", false);
				$("#father .relation").prop("readonly", true);
				$("#father .parent_name").prop("readonly", true);
				$("#father .parent_tel").prop("readonly", true);
				$("#father .parent_email").prop("readonly", true);
				$("#father .parent_sex").prop("disabled", false);
				$("#father .parent_sex").prop("readonly", true);
				$("#father .parent_birth").prop("readonly", true);
			
				$("#father .update").show();
				$("#father .updateRegister").hide();
				$("#father .updateCancel").hide();
				
				$("#father").hide();
				$("#father").show();
				
				$("#kinderList").hide();
				getList();
				$("#kinderList").show();
			}
			
		})
		
	});
	
	
	
	$("#mather .updateRegister").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "모";
		var parent_name = $("#mather .parent_name").val();
		var parent_tel = $("#mather .parent_tel").val(); 
		var parent_email = $("#mather .parent_email").val();
		var parent_sex = $("#mather .parent_sex").val();
		var parent_birth = $("#mather .parent_birth").val();
		
		$.ajax({
			url : "/ius/parent/update_parent_info",
			type : "POST",
			data : { 
				kinder_num : kinder_num,
				relation : relation,
				parent_name : parent_name,
				parent_tel : parent_tel,
				parent_email : parent_email,
				parent_sex : parent_sex,
				parent_birth : parent_birth
			},
			success: function(data) {
				alert('수정이 완료되었습니다.');
				
				$("#mather .relation").prop("disabled", false);
				$("#mather .relation").prop("readonly", true);
				$("#mather .parent_name").prop("readonly", true);
				$("#mather .parent_tel").prop("readonly", true);
				$("#mather .parent_email").prop("readonly", true);
				$("#mather .parent_sex").prop("disabled", false);
				$("#mather .parent_sex").prop("readonly", true);
				$("#mather .parent_birth").prop("readonly", true);
				
				$("#mather .update").show();
				$("#mather .updateRegister").hide();
				$("#mather .updateCancel").hide();
				
				$("#mather").hide();
				$("#mather").show();
				
				$("#kinderList").hide();
				getList();
				$("#kinderList").show();
			}
			
		})	
	});
	
	
})