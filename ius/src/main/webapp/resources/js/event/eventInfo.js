function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
};

function event(event_num) { // 삭제나 수정을 위한 행사 정보 가져오기
	var event_num = event_num;
	$("#event_num").val(event_num);
	
	$.ajax({
		url : "/ius/event/get_event_name_by_num",
		type : "POST",
		data : {
			event_num : event_num
		},
		success: function(data) {
			$("#event_name").val("");
			$("#register_staff_id").val("");
			$("#event_name").val(data.eventInfo.event_name);
			$("#register_staff_id").val(data.eventInfo.staff_id);
		}
		
	})

};
	
$(function(){
	function getInfo() { // 날짜별 일정 받아오기
		var event_date = $("#event_date").val();
		$.ajax({
			url : "/ius/event/get_event_Info",
			type : "POST",
			data : {
				event_date : event_date
			},
			success: function(data) {
				$(".eventInfoTr").remove();
				
				values = data.eventList;
				$("#eventInfo>tbody").append("<tr class='eventInfoTr'><th>일정 명</th></tr>");
				if(values.length != 0) {
					$.each(values, function(index, value) {
						$("#eventInfo>tbody").append("<tr class='eventInfoTr'><td><a href=\"javascript:event(" + value.event_num + ");\">"+ value.event_name + "</a></td></tr>");
					});
				}
				
			}
			
		})
		
		
};
	
getInfo();

	$("#event_date").change(function(){ // 날짜가 변경되었을 때, 그 날짜의 일정 정보를 가져옴.
		$("#event_num").val("");
		$("#event_name").val("");
		$("#register_staff_id").val("");
		getInfo();
	});


	
	$("#delete").click(function(){ // 삭제
		var master = getCookie("master");
		var event_num = $("#event_num").val();
		var event_date = $("#event_date").val();
		var staff_id = $("#staff_id").val();
		var register_staff_id = $("#register_staff_id").val();
		
		
	
		if ((master == "Y") || (staff_id == register_staff_id)) { // 마스터 권한이거나, 등록자 본인인 경우 삭제 가능
			if (event_num == "") {
				alert("삭제할 데이터를 먼저 클릭하세요.");
				return;
			} else {
				var input = confirm("정말 삭제하시겠습니까?");
				if (input === true) {
				
					$.ajax({
						url : "/ius/event/delete_event_by_num",
						type : "POST",
						data : {
							event_num : event_num
						},
						success: function(data) {
							alert("삭제되었습니다.");
							$("#event_num").val("");
							$("#event_name").val("");
							$("#register_staff_id").val("");
							getInfo();
						}
						
					})
				}
				
			}
		} else if (staff_id != register_staff_id) { // 등록자 본인이 아닌 경우
			alert("등록한 사람만 삭제할 수 있습니다.");
		}
		
		
	});
	
	$("#update").click(function(){ // 수정
		var master = getCookie("master");
		var event_num = $("#event_num").val();
		var event_name = $("#event_name").val();
		var event_date = $("#event_date").val();
		var staff_id = $("#staff_id").val();
		var register_staff_id = $("#register_staff_id").val();
	
		if ((master == "Y") || (staff_id == register_staff_id)) { // 마스터 권한이거나, 등록자 본인인 경우 수정 가능
			if (event_num == "") {
				alert("수정할 데이터를 먼저 클릭하세요.");
				return;
			} else {
				var input = confirm("정말 수정하시겠습니까?");
				if (input === true) {
				
					$.ajax({
						url : "/ius/event/update_event_by_num",
						type : "POST",
						data : {
							event_num : event_num,
							event_name : event_name
							
						},
						success: function(data) {
							alert("수정되었습니다.");
							$("#event_num").val("");
							$("#event_name").val("");
							$("#register_staff_id").val("");
							getInfo();
						}
						
					})
				}
				
			}
		} else if (staff_id != register_staff_id) { // 등록자 본인이 아닌 경우
			alert("등록한 사람만 수정할 수 있습니다.");
		}
			
	});
	
	$("#register").click(function(){ // 추가
		var event_num = $("#event_num").val();
		var event_name = $("#event_name").val();
		var event_date = $("#event_date").val();
		var staff_id = $("#staff_id").val();
		
		if (event_num != "") {
			alert("추가하시려면 먼저 기존에 불러온 데이터를 비워야합니다.");
			return;
		};
		
		if (event_date == "") {
			alert("추가할 날짜를 입력해주세요.");
			return;
		};
		
		if (event_name == "") {
			alert("추가할 행사명을 입력하세요.");
			return;
		} else if (event_name.length > 20) {
			alert("행사 명은 20자 이하여야 합니다.")
			return;
		} else {
			$.ajax({
				url : "/ius/event/register_event",
				type : "POST",
				data : {
					event_date : event_date,
					event_name : event_name,
					staff_id : staff_id
					
				},
				success: function(data) {
					alert("추가 되었습니다.");
					$("#event_num").val("");
					$("#event_name").val("");
					getInfo();
				}
				
			})

		}
		
	});
	
	$("#cancel").click(function(){ // 기존의 데이터 비우기
		var event_num = $("#event_num").val();
	
		if (event_num == "") {
			alert("비울 데이터가 없습니다.");
			return;
		} else if (event_num != "") {
			$("#event_num").val("");
			$("#event_name").val("");
			$("#register_staff_id").val("");
		}
	});
	
})	