$(function(){
		 $("#register").click(function(){
			 
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
			 
			frm.submit();
				
		 });
		
		
		
	})