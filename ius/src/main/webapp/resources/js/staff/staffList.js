
function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};


function view(staff_num) {

	var staff_num = staff_num;
		
		$.ajax({
			url : "/ius/staff/get_staff_by_staff_num",
			type : "POST",
			data : {
				staff_num : staff_num
			},
			success : function(data) {
				
				$("#staff_num").val(data.staff.staff_num);
				$("#job_Kname").val(data.staff.job_Kname);
				$("#class_name").val(data.staff.class_name);
				$("#staff_id").val(data.staff.staff_id);
				$("#staff_age").val(data.staff.staff_age);
				
				var staff_sex = "";
				if (data.staff.staff_sex == 'M') {
					staff_sex = "남성";
				} else if (data.staff.staff_sex == 'F') {
					staff_sex = "여성";
				}
				$("#staff_sex").val(staff_sex);
				$("#staff_birth").val(data.staff.staff_birth);
				$("#staff_name").val(data.staff.staff_name);
				
				if ((data.staff.staff_picture == null)|| (data.staff.staff_picture == "")) {
					data.staff.staff_picture = "\\imgUpload\\no_image.jpg";
				}
				
				/* $("#staff_picture").html("<img src='" + data.staff.staff_picture + "' width='94.4px' height='113.3px'>"); */
				$("#staff_picture").html("<img src='" + "<spring:url value='/resources'/>" + data.staff.staff_picture + "' width='94.4px' height='113.3px'>");
				$("#staff_rrn1").val(data.staff.staff_rrn1);
				$("#staff_rrn2").val(data.staff.staff_rrn2);
				$("#staff_addr").val(data.staff.staff_addr);
				$("#staff_zipcode").val(data.staff.staff_zipcode);
				$("#staff_tel").val(data.staff.staff_tel);
				$("#staff_hireD").val(data.staff.staff_hireD);
				
				$("#staff_retireD").val(data.staff.staff_retireD);
				$("#staff_workYn").val(data.staff.staff_workYn);
				$("#staff_salary").val(addComma(data.staff.staff_salary));
				$("#staff_email").val(data.staff.staff_email);
				
				$("#staffInfo").show();
			}
		})
};




function getList() {
	$.ajax({
		url : "/ius/staff/get_staff_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#staffList").text("");			

			values = data.staffList;
			output = "<tr><th>구분</th><th>이름</th><th>연락처</th></tr>";			
			$.each(values, function(index, value) {
				
				output += "<tr class='bgc' onclick='view(" + value.staff_num + ")'>";
				output += "<td>" + value.job_Kname + "</td>";
				output += "<td>" + value.staff_name + "</td>";
				output += "<td>" + value.staff_tel + "</td>";
				output += "</tr>";
			});
			
			$("#staffList").html(output);
		}
		
	})
	
}
getList();

	$(function(){
		$("#search").click(function(){
			var staff_name = $("#search_staff_name").val();
			var staff_workYn = $("#search_staff_workYn").val();
			var staff_cls = $("#search_staff_cls").val();
			
			$.ajax({
				url : "/ius/staff/search_staff_list",
				type : "POST",
				data : {
					staff_name : staff_name,
					staff_workYn : staff_workYn,
					staff_cls : staff_cls
				},
				success: function(data) {
					$("#staffList").text("");			

					values = data.staffList;
					output = "<tr><th>구분</th><th>이름</th><th>연락처</th></tr>";			
					$.each(values, function(index, value) {
						
						output += "<tr class='bgc' onclick='view(" + value.staff_num + ")'>";
						output += "<td>" + value.job_Kname + "</td>";
						output += "<td><a href=\"javascript:view(" + value.staff_num + ");\">" + value.staff_name + "</a></td>";
						output += "<td>" + value.staff_tel + "</td>";
						output += "</tr>";
					});
					
					$("#staffInfo").hide();
					$("#staffList").html(output);
				}
				
			})
		});
		
		$("#update").click(function(){
			$("#staffInfo").hide();
			var staff_num = $("#staff_num").val();
			location.href="./staff_update_form?staff_num=" + staff_num;
		});
		
		$("#delete").click(function(){
			var staff_num = $("#staff_num").val();
			var input = confirm('정말 삭제하시겠습니까?');
			if (input === true) {
				$("#staffInfo").hide();
				alert("삭제되었습니다.");
				location.href="./staff_delete?staff_num=" + staff_num;
			} else {
				alert("취소되었습니다.");
			};
			
			
		});

})
