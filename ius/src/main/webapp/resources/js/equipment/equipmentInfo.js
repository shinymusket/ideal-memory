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
	
$(function(){
	$("#update").click(function(){ // 수정시 시설 권한이 없으면 수정 불가하며 본인의 글인 경우만 수정 가능. (마스터 권한은 본인의 글이 아니더라도 삭제 수정 가능.)
		var master = getCookie("master");
		var facility = getCookie("facility");
		var equipment_num = $("#equipment_num").val();
		
		var log_staff_id = $("#log_staff_id").val();
		var staff_id = $("#staff_id").val();
		
		
		if(master == "Y") { // 마스터(관리자) 권한이 있는 경우
			location.href = "../equipment/equipment_update?equipment_num=" + equipment_num;
		} else if(master == "N") { // 마스터(관리자) 권한이 없는 경우
			if(facility == "N") { // 시설 권한이 없는 경우.
				alert("권한이 없습니다.");
				return;
			} else if(facility == "Y") { // 시설 권한이 있는 경우 - 본인 작성 글인지 확인.
				if (log_staff_id != staff_id) {
					alert("본인이 작성한 글이 아닌 경우 수정이 불가합니다.");
					return;
				} else {
					location.href = "../equipment/equipment_update?equipment_num=" + equipment_num;
				}
			}
		};
	});
	
	$("#delete").click(function(){ // 삭제시 시설 권한이 없으면 삭제 불가하며 본인의 글인 경우만 삭제 가능. (마스터 권한은 본인의 글이 아니더라도 삭제 수정 가능.)
		var master = getCookie("master");
		var facility = getCookie("facility");
		var equipment_num = $("#equipment_num").val();
		
		var log_staff_id = $("#log_staff_id").val();
		var staff_id = $("#staff_id").val();
		
		
		if(master == "Y") { // 마스터(관리자) 권한이 있는 경우
			var input = confirm("정말 삭제하시겠습니까?");
			if (input === true) {
				location.href = "../equipment/equipment_delete?equipment_num=" + equipment_num;
			};
			
		} else if(master == "N") { // 마스터(관리자) 권한이 없는 경우
			if(facility == "N") { // 시설 권한이 없는 경우.
				alert("권한이 없습니다.");
				return;
			} else if(facility == "Y") { // 시설 권한이 있는 경우 - 본인 작성 글인지 확인.
				if (log_staff_id != staff_id) {
					alert("본인이 작성한 글이 아닌 경우 삭제 불가합니다.");
					return;
				} else {
					var input = confirm("정말 삭제하시겠습니까?");
					if (input === true) {
						location.href = "../equipment/equipment_delete?equipment_num=" + equipment_num;
					};
				}
			}
		};
	});
	
})