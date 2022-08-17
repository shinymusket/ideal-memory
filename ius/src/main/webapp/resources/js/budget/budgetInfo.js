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
	$("#delete").click(function(){ // 삭제시 마스터 권한 확인.
		var master = getCookie("master");
		var budget_num = $("#budget_num").val();
		
		if (master == "N") { // 마스터 권한이 없는 경우.
			alert("권한이 없습니다.");
			return;
		} else if(master == "Y") { // 마스터 권한이 있는 경우.
			var input = confirm("정말 삭제하시겠습니까?");
			if (input === true) {  // 삭제 확인을 받은 후, 삭제 확인시 Ajax로 해당 데이터를 부모키로 가진 데이터가 있는지 조회후 있는 경우 삭제 불가 메시지 출력.
				$.ajax({
					url : "/ius/budget/count_finance_from_budget",
					type : "POST",
					data : {
						budget_num : budget_num
					},
					success: function(data) {
						if(data.result > 0) { // 해당 데이터가 있는 경우.
							alert("해당 예산 항목으로 생성된 재정 정보가 있어 삭제가 불가합니다.");
						} else {
							alert("삭제 되었습니다.");
							location.href='../budget/budget_delete?budget_num=' + budget_num;
						}
						
						}
						
					});
			};	
		}
	});
	
	$("#update").click(function(){ // 수정시 마스터 권한 확인.
		var master = getCookie("master");
		var budget_num = $("#budget_num").val();
		
		if (master == "N") { // 마스터 권한이 없는 경우.
			alert("권한이 없습니다.");
			return;
		} else if(master == "Y") { // 마스터 권한이 있는 경우.
				$.ajax({
					url : "/ius/budget/count_finance_from_budget",
					type : "POST",
					data : {
						budget_num : budget_num
					},
					success: function(data) {
						if(data.result > 0) { // 해당 데이터가 있는 경우.
							alert("해당 예산 항목으로 생성된 재정 정보가 있어 수정이 불가합니다.");
						} else {
							location.href='../budget/budget_update_form?budget_num=' + budget_num;
						}
						
						}
						
					});
				
		}
	});
	
	
});