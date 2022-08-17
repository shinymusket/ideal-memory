$(function(){
	$("#update").click(function(){
		var staff_id = $("#staff_id").val();
		var originPassword = $("#originPassword").val();
		var newPassword = $("#newPassword").val();
		var newPasswordChk = $("#newPasswordChk").val();
		
		if (originPassword == "") {
			alert("기존 비밀번호를 입력하세요.");
			originPassword.focus();
			return;
		};
		if (newPassword == "") {
			alert("새 비밀번호를 입력하세요.");
			newPassword.focus();
			return;
		};
		if (newPasswordChk == "") {
			alert("새 비밀번호 확인란을 입력하세요.");
			newPasswordChk.focus();
			return;
		};
		if (newPassword != newPasswordChk) {
			alert("새 비밀번호가 다릅니다.");
			return;
		};
		
		$.ajax({
			url : "/ius/main/check_origin_password",
			type : "POST",
			data : {
				staff_id : staff_id,
				originPassword : originPassword
			},
			success: function(data) {
				if(data.result == 0) {
					alert("기존 비밀번호가 틀렸습니다.");	
				} else {
					alert("비밀번호가 변경되었습니다. 새 비밀번호로 로그인하세요.")
					$("form").submit();
				}
				
			}
			
		})
		
		
		
	});
	
})	