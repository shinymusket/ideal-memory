function view(viewNum) {
	var staff_cls = viewNum;
		
		$.ajax({
			url : "/ius/staff/get_job_by_staff_cls",
			type : "POST",
			data : {
				staff_cls : staff_cls
			},
			success : function(data) {
				$("#staff_cls").val(data.staff_cls);
				$("#job_Kname").val(data.job_Kname);
				$("#job_Ename").val(data.job_Ename);
				
			}
		})
	};
	
function sel_btn(selNum) {
	var  staff_cls = selNum;
	
	$.ajax({
		url : "/ius/staff/get_job_by_staff_cls",
		type : "POST",
		data : {
			staff_cls : staff_cls
		},
		success : function(data) {
			opener.frm.staff_cls.value = data.staff_cls;
			opener.frm.job_Kname.value = data.job_Kname;
			self.close();
		}
	})	
};	
	
	
	
	
	$(function(){
		function getList(){
			$.ajax({
				url: "/ius/staff/get_job_list",
				type: "POST",
				data: {
					
				},
				success: function(json) {
				json = json.replace(/\n/gi, "\\r\\n"); // 개행문자 대체
					$("#jobList").text(""); // 직무 리스트 영역 초기화
					var obj = JSON.parse(json); // service 클래스로부터 전달된 문자열 파싱
					var jobList = obj.jobList;
					var output = "<tr><th>직무 코드</th><th>한글명</th><th>영문명</th><th></th></tr>";
					for (var i = 0; i < jobList.length; i++) {
						output += "<tr>";
						for (var j = 0; j < jobList[i].length; j++) {
							
							var job = jobList[i][j];
							if (j === 0) {
								var staff_cls = job.staff_cls;
							} else if (j === 1) {
								output += "<td>" + job.job_number + "</td>";
							} else if (j === 2) {
								output += "<td><a href=\"javascript:view(" + staff_cls + ");\">" + job.job_Kname + "</a></td>";
							} else if (j === 3) {
								output += "<td>" + job.job_Ename + "</td>";
								output += "<td><a href=\"javascript:sel_btn(" + staff_cls + ");\">선택</a>";
							}
							 
						};
					};
					$("#jobList").html(output);
				}	
			})
		}
	
		getList();
		
		$("#insert_btn").click(function(){
			if($("#job_Kname").val().trim() === "") {
				alert("한글명을 입력하세요.");
				$("#job_Kname").val("").focus();
			}else if($("#job_Ename").val().trim() === "") {
				alert("영문명을 입력하세요.");
				$("#job_Ename").val("").focus();
			} else {
				$.ajax({
					url: "/ius/staff/insert_job_list",
					type: "POST",
					data: {
						job_Kname : $("#job_Kname").val(),
						job_Ename : $("#job_Ename").val()
					},
					success: function() {
						$("#job_Kname").val("");
						$("#job_Ename").val("");
						getList();
					}
				})
			}	
		});
		
		$("#delete_btn").click(function(){
			if($("#staff_cls").val() >= 1 &&  $("#staff_cls").val() <= 4) {
				alert("기본 항목은 삭제할 수 없습니다.");
			} else {
				$.ajax({
					url:  "/ius/staff/delete_job_list",
					type: "POST",
					data: {
						staff_cls : $("#staff_cls").val()
					},
					success: function(result) {
						if (result > 0) {
							alert("해당 항목의 교직원 데이터가 있어 삭제할 수 없습니다.");
						} else {
							$("#job_Kname").val("");
							$("#job_Ename").val("");
							getList();
						}
					}
				})
			}	
		});
		
		$("#update_btn").click(function(){
			if($("#staff_cls").val() >= 1 &&  $("#staff_cls").val() <= 4) {
				alert("기본 항목은 수정할 수 없습니다.");
			} else {
				$.ajax({
					url: "/ius/staff/update_job_list",
					type: "POST",
					data: {
						staff_cls : $("#staff_cls").val(),
						job_Kname : $("#job_Kname").val(),
						job_Ename : $("#job_Ename").val()
					},
					success: function() {
						alert("수정 완료");
						$("#job_Kname").val("");
						$("#job_Ename").val("");
						getList();
					}
				})	
			}
		});
		
})