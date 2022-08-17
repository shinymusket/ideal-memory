function view(kinder_num) {
	var kinder_num = kinder_num;
		
		$.ajax({
			url : "/ius/kinder/get_kinder_by_kinder_num",
			type : "POST",
			data : {
				kinder_num : kinder_num
			},
			success : function(data) {
				$("#allergy").hide();
				$("#get_allergy_info").hide();
				$(".attendanceTr").remove();
				$(".consultTr").remove();
				
				$("#kinder_num").val(data.kinder.kinder_num);
				
				if ((data.kinder.kinder_picture == null)|| (data.kinder.kinder_picture == "")) {
					data.kinder.kinder_picture = "\\imgUpload\\no_image.jpg";
				}
				
				$("#kinder_picture").html("<img src='" + data.kinder.kinder_picture + "' width='94.4px' height='113.3px'>");
				
				$("#kinder_name").val(data.kinder.kinder_name);
				$("#class_name").val(data.kinder.class_name);
				$("#staff_name").val(data.kinder.staff_name);	
				$("#kinder_father").val(data.fatherName);
				$("#kinder_mather").val(data.matherName);
				
				$("#shuttle_num").val(data.kinder.shuttle_num);
				$("#kinder_rrn1").val(data.kinder.kinder_rrn1);
				$("#kinder_rrn2").val(data.kinder.kinder_rrn2);
				$("#kinder_addr").val(data.kinder.kinder_addr);
				$("#kinder_zipcode").val(data.kinder.kinder_zipcode);
				$("#kinder_tel").val(data.kinder.kinder_tel);
				$("#kinder_regdate").val(data.kinder.kinder_regdate);
				$("#kinder_retireDate").val(data.kinder.kinder_retireDate);
				$("#kinder_regYn").val(data.kinder.kinder_regYn);
				
				var allergy_check = data.kinder.allergy_check;
				$("#allergy_code").val(data.kinder.allergy_code);
				
				if (allergy_check == 0) {
					$("#allergy_info").val("보유 알러지 없음");
				} else {
					$("#allergy_info").val("보유 알러지 있음");
					$("#get_allergy_info").show();
				}	
				
				
				values = data.attendanceInfo; // 출결 정보
				$("#kinderInfo>tbody").append("<tr class='attendanceTr'><th colspan='4'>출결 내역</th></tr>");
				if(values.length != 0) {
					$("#kinderInfo>tbody").append("<tr class='attendanceTr'><th>일시</th><th>출결 정보</th><th>등원시간</th><th>하원시간</th></tr>");
					$.each(values, function(index, value) {
						
						attend_info = value.attend_info;
						
						if (attend_info == "T") {
							attend_info = "출석";
						} else if (attend_info == "B") {
							attend_info = "결석";
						} else if (attend_info == "L") {
							attend_info = "지각";
						} else if (attend_info == "E") {
							attend_info = "조퇴";
						}; 	
						
						if (value.in_time == null) {
							value.in_time = "";
						};
						if (value.out_time == null) {
							value.out_time = "";
						};
						$("#kinderInfo>tbody").append("<tr class='attendanceTr'><td>" + value.attend_date + "</td><td>" + attend_info + "</td><td>" + value.in_time + "</td><td>" +  value.out_time + "</td></tr>");
					});
				}
				
				consultInfo = data.consultInfo;
				$("#kinderInfo>tbody").append("<tr class='consultTr'><th colspan='4'>최근 상담 기록</th></tr>");
				if(consultInfo != null) {
					$("#kinderInfo>tbody").append("<tr class='consultTr'><td colspan='4'>"+ consultInfo.consult_content + "</td></tr>");
				}
				
				
				
				
				$("#kinderInfo").hide();
				$("#parent").hide();
				$("#parentInfo").hide();
				
				$("#kinderInfo").show();
			}
		})
};



function getList() {
	$.ajax({
		url : "/ius/kinder/get_kinder_list",
		type : "POST",
		data : {
			
		},
		success: function(data) {
			$("#kinderList").text("");
			values = data.kinderList;
			output = "<tr><th>원생 이름</th><th>전화</th><th>학급</th></tr>";				
			$.each(values, function(index, value) {
	
				output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
				output += "<td>" + value.kinder_name + "</td>";
				output += "<td>" + value.kinder_tel + "</td>";
				output += "<td>" + value.class_name + "</td>";
				output += "</tr>";
			});
			
			$("#kinderList").html(output);
		}
		
	})
	
}
getList();


function changeSearchSelect(){
	var searchType = $("#searchType").val();
	
	if (searchType == "kinder_regYn") {
		$("#search_regYn").show();
		$("#searchDateFrom").hide();
		$("#searchDateTO").hide();
		$("#searchContent").hide();
	} else if ((searchType == "kinder_regdate") || (searchType == "kinder_retireDate")) {
		$("#searchDateFrom").show();
		$("#searchDateTO").show();
		$("#search_regYn").hide();
		$("#searchContent").hide();
	} else {
		$("#searchDateFrom").hide();
		$("#searchDateTO").hide();
		$("#search_regYn").hide();
		$("#searchContent").show();
	};
	

};


$(function(){
	$("#search").click(function(){
		var searchType = $("#searchType").val();
		var searchContent = $("#searchContent").val();
		var search_regYn = $("#search_regYn").val();
		var searchDateFrom = $("#searchDateFrom").val();
		var searchDateTO = $("#searchDateTO").val();
		
		$.ajax({
			url : "/ius/kinder/search_kinder_list_by_searchType",
			type : "POST",
			data : {
				searchType : searchType,
				searchContent : searchContent,
				search_regYn : search_regYn,
				searchDateFrom : searchDateFrom,
				searchDateTO : searchDateTO	
			},
			success : function(data) {
				$("#kinderList").text("");
				values = data.kinderList;
				output = "<tr><th>원생 이름</th><th>전화</th><th>학급</th></tr>";				
				$.each(values, function(index, value) {
		
					output += "<tr class='bgc' onclick='view(" + value.kinder_num + ")'>";
					output += "<td>" + value.kinder_name + "</td>";
					output += "<td>" + value.kinder_tel + "</td>";
					output += "<td>" + value.class_name + "</td>";
					output += "</tr>";
				});
				
				
				$("#kinderInfo").hide();
				$("#parent").hide();
				$("#parentInfo").hide();
				
				$("#kinderList").html(output);
			}
			
		})
			
	});
	
	$("#update").click(function(){
		$("#kinderInfo").hide();
		$("#parent").hide();
		$("#allergy").hide();
		
		var kinder_num = $("#kinder_num").val();
		location.href="./update_form_kinder?kinder_num=" + kinder_num;
	});
	
	$("#delete").click(function(){
		var kinder_num = $("#kinder_num").val();
		var input = confirm('정말 삭제하시겠습니까?');
		if (input === true) {
			$("#allergy").hide();
			$("#parent").hide();
			$("#kinderInfo").hide();
			alert("삭제되었습니다.");
			location.href="./delete_kinder?kinder_num=" + kinder_num;
		} else {
			alert("취소되었습니다.");
		};
		
		
	});
	
	$("#getParentInfo").click(function(){
		$("#allergy").hide();
		$("#parent").show();
	});
	
	$("#getFatherInfo").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "F";
		
		$.ajax({
			url : "/ius/kinder/get_parent_by_kinder_num",
			type : "POST",
			data : {
				kinder_num : kinder_num,
				relation :  relation
			},
			
			success : function(data) {
				if (data.parent != null) {
					$("#relation").val(data.parent.relation);
					$("#parent_name").val(data.parent.parent_name);
					$("#parent_tel").val(data.parent.parent_tel);
					$("#parent_email").val(data.parent.parent_email);
					
					if (data.parent.parent_sex == 'M') {
						parent_sex = '남성';
					} else if (data.parent.parent_sex == 'F') {
						parent_sex = '여성';
					}
			
					$("#parent_sex").val(parent_sex);
					$("#parent_birth").val(data.parent.parent_birth);
								
					$("#parentInfo").show();
				}
		
			}
		})
	});
	
	$("#getMatherInfo").click(function(){
		var kinder_num = $("#kinder_num").val();
		var relation = "M";
		
		$.ajax({
			url : "/ius/kinder/get_parent_by_kinder_num",
			type : "POST",
			data : {
				kinder_num : kinder_num,
				relation :  relation
			},
			
			success : function(data) {
				if (data.parent != null) {
					$("#relation").val(data.parent.relation);
					$("#parent_name").val(data.parent.parent_name);
					$("#parent_tel").val(data.parent.parent_tel);
					$("#parent_email").val(data.parent.parent_email);
					
					if (data.parent.parent_sex == 'M') {
						parent_sex = '남성';
					} else if (data.parent.parent_sex == 'F') {
						parent_sex = '여성';
					}
			
					$("#parent_sex").val(parent_sex);
					$("#parent_birth").val(data.parent.parent_birth);
								
					$("#parentInfo").show();
				}
				
			}
		})
	});
	
	$("#get_allergy_info").click(function(){
		var allergy_code =  $("#allergy_code").val();
		
		$.ajax({
			url : "/ius/kinder/get_allergy_info",
			type : "POST",
			data : {
				allergy_code : allergy_code
			},
			
			success : function(data) {
				
				$("#parent").hide();
				$("#parentInfo").hide();
				$("#allergyDetailInfo").text("");
				
				value = data.allergyDetailInfo;
				output = "<tr><th>보유 알러지명</th></tr>";
				if (value.a1 == 'Y') {
					output += "<tr><td>" + "난류(가금류)" + "</td></tr>";
				};
				if (value.a2 == 'Y') {
					output += "<tr><td>" + "우유" + "</td></tr>";
				};
				if (value.a3 == 'Y') {
					output += "<tr><td>" + "메밀" + "</td></tr>";
				};
				if (value.a4 == 'Y') {
					output += "<tr><td>" + "땅콩" + "</td></tr>";
				};
				if (value.a5 == 'Y') {
					output += "<tr><td>" + "대두" + "</td></tr>";
				};
				if (value.a6 == 'Y') {
					output += "<tr><td>" + "밀" + "</td></tr>";
				};
				if (value.a7 == 'Y') {
					output += "<tr><td>" + "고등어" + "</td></tr>";
				};
				if (value.a8 == 'Y') {
					output += "<tr><td>" + "게" + "</td></tr>";
				};
				if (value.a9 == 'Y') {
					output += "<tr><td>" + "새우" + "</td></tr>";
				};
				if (value.a10 == 'Y') {
					output += "<tr><td>" + "돼지고기" + "</td></tr>";
				};
				if (value.a11 == 'Y') {
					output += "<tr><td>" + "복숭아" + "</td></tr>";
				};
				if (value.a12 == 'Y') {
					output += "<tr><td>" + "토마토" + "</td></tr>";
				};
				if (value.a13 == 'Y') {
					output += "<tr><td>" + "아황산염" + "</td></tr>";
				};
				if (value.a14 == 'Y') {
					output += "<tr><td>" + "호두" + "</td></tr>";
				};
				if (value.a15 == 'Y') {
					output += "<tr><td>" + "닭고기" + "</td></tr>";
				};
				if (value.a16 == 'Y') {
					output += "<tr><td>" + "쇠고기" + "</td></tr>";
				};
				if (value.a17 == 'Y') {
					output += "<tr><td>" + "오징어" + "</td></tr>";
				};
				if (value.a18 == 'Y') {
					output += "<tr><td>" + "조개류" + "</td></tr>";
				};
				
				$("#allergyDetailInfo").html(output);
				$("#allergy").show();
				
			}
		})
		
	});
	
	
	
	
})

