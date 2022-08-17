function view(class_number) {
		var class_number = class_number;
			
			$.ajax({
				url : "/ius/class/get_class_by_class_num",
				type : "POST",
				data : {
					class_number : class_number
				},
				success : function(data) {
					$("#class_number").val(data.classInfo.class_number);
					$("#class_name").val(data.classInfo.class_name);
					$("#staff_name").val(data.classInfo.staff_name);
					$("#staff_tel").val(data.classInfo.staff_tel);
					$("#staff_num").val(data.classInfo.staff_num);
					
					values = data.classKinderList;
					output = "<tr><th>원생 이름</th><th>원생 연락처</th></tr>";
					$.each(values, function(index, value) {
						output += "<tr>";
						output += "<td>" + value.kinder_name + "</td>";
						output += "<td>" + value.kinder_tel + "</td>";
						output += "</tr>";
					});
					
					$("#classKinder").html(output);
					
					$("#classInfo").show();
					$("#homeTeacherSelect").text("");
					
					$("#class_name").prop("disabled", true);
					$("#staff_name").prop("readonly", false);
					$("#staff_name").prop("disabled", true);
					
					$("#updateForm").show();
					$("#update").hide();
					$("#cancel").hide();
		
				}
			})
	};



	function getList() {
		$.ajax({
			url : "/ius/class/get_class_list",
			type : "POST",
			data : {
				
			},
			success: function(data) {
				$("#classList").text("");			
	
				values = data.classList;
				output = "<tr><th>반 번호</th><th>반 이름</th><th>담당 교사</th></tr>";			
				$.each(values, function(index, value) {
					
					output += "<tr>";
					output += "<td>" + value.class_number + "</td>";
					output += "<td><a href=\"javascript:view('" + value.class_number + "');\">" + value.class_name + "</a></td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "</tr>";
				});
				
				$("#classList").html(output);
			}
			
		})
		
	}
	getList();
	
	$(function(){
		$("#updateForm").click(function(){
			$("#class_name").prop("disabled", false);
			$("#staff_name").prop("disabled", false);
			$("#staff_name").prop("readonly", true);
			
			var staff_name = $("#staff_name").val();
			var staff_num =  $("#staff_num").val();
			
			$.ajax({
				url : "/ius/class/get_home_teacher_list",
				type : "POST",
				data : {
					
				},
				success: function(data) {
					$("#homeTeacherSelect").text("");			
		
					values = data.homeTeacherList;
					output = "<select id='homeTeacher'>";
					output += "<option value='" + staff_num + "'>"+  staff_name  +"</option>"
					
					$.each(values, function(index, value) {
						
						output += "<option value='" + value.staff_num + "'>";
						output += value.staff_name;
						output += "</option>";
					});
					output += "</select>"
					
					$("#homeTeacherSelect").html(output);
				}
				
			})
				
			$("#updateForm").hide();
			$("#update").show();
			$("#cancel").show();
		});
		
		$("#cancel").click(function(){
			$("#homeTeacherSelect").text("");
			
			$("#class_name").prop("disabled", true);
			$("#staff_name").prop("readonly", false);
			$("#staff_name").prop("disabled", true);
			
			$("#updateForm").show();
			$("#update").hide();
			
			$("#cancel").hide();
		});
		
		
		$("#update").click(function(){
			
			if ($("#class_name").val() == "") {
				alert("학급명을 입력해주세요.");
				$("#class_name").val().focus();
				return;
			};
			
			if ($("#class_name").val().length > 10) {
				alert("학급명은 10자 이하로 입력해야합니다.");
				$("#class_name").val("");
				return;
			};
			
			var class_number = $("#class_number").val();
			var class_name = $("#class_name").val();
			
			var old_staff_num = $("#staff_num").val();
			var new_staff_num = $("#homeTeacher").val();
			
			console.log(staff_num);
			
			$.ajax({
				url : "/ius/class/update_class_info",
				type : "POST",
				data : { 
					class_number : class_number,
					class_name : class_name,
					new_staff_num : new_staff_num,
					old_staff_num : old_staff_num
				},
				success: function(data) {
					alert('수정이 완료되었습니다.');
				}
				
			})
			
			$("#classInfo").hide();
			$("#classList").hide();
			getList();
			$("#classList").show();
			
		});
		
		$("#delete").click(function(){
			var input = confirm('정말 삭제하시겠습니까?');
			if (input === true ) {
				var class_number = $("#class_number").val();
				$("#classInfo").hide();
				
				$.ajax({
					url : "/ius/class/delete_class_info",
					type : "POST",
					data : { 
						class_number : class_number,
					},
					success: function(data) {
						alert('삭제가 완료되었습니다.');
					}
					
				})
					
				getList();
				
			} else {
				alert("취소되었습니다.");
			}
			
			
		});
		
	})