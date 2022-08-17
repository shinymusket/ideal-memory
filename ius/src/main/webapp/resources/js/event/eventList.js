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

$(function(){
	var teacher = getCookie("teacher");
	if (teacher == "N") {
		$(".menu_info").removeAttr("href");
	}
	
	$("#eventRegister").click(function(){ // 행사 및 일정 등록은 교사 권한이 있어야 가능.
		
		var teacher = getCookie("teacher");
		if (teacher == "N") {  
			alert("권한이 없습니다.");
			return;
		} else if (teacher == "Y") {
			location.href='../event/event_select_by_event_date';
		}	
	});
	
})