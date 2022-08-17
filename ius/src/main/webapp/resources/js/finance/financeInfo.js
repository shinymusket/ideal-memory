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
	 $("#update").click(function(){ // 수정 요청시
		var master = getCookie("master");
		 
		var finance_num = $("#finance_num").val();
			 
	 	// 권한이 있는지 확인
	 	if (master != "Y") {
	 		alert("재정내역 수정 권한이 없습니다.");
	 		return;
	 	}
	 
		 location.href="../finance/finance_update_form?finance_num=" + finance_num;
	 });
	 
	 $("#delete").click(function(){ // 삭제 요청시
		 	var master = getCookie("master");
			 
			var finance_num = $("#finance_num").val();
				 
			// 권한이 있는지 확인
		 	if (master != "Y") {
		 		alert("재정내역 삭제 권한이 없습니다.");
		 		return;
		 	};
		 	
		 	var input = confirm("정말 삭제하시겠습니까?")
		 	
		 	if (input === true) {
		 		location.href="../finance/finance_delete?finance_num=" + finance_num;
		 	} else {
		 		alert("취소되었습니다.");
		 	};
		 
			 
		 });
	 
 })