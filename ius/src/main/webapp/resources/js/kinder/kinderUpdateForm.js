function getAllergyCheck() {
	var allergy_code = document.getElementById('allergy_code').value;
	console.log(allergy_code);
	
	$.ajax({
		url : "/ius/kinder/get_allergy_check",
		type : "POST",
		data : {
			allergy_code : allergy_code
		},
		success: function(data) {
			$("#allergy_info").val(data.allergy_info);
			
		}
		
	})
};

getAllergyCheck();

$(function(){
	
		$("#kinder_picFile").change(function(){
			if(this.files && this.files[0]) {
				var reader = new FileReader;
				reader.onload = function(data) {
					$(".select_img img").attr("src", data.target.result).width(500);
				}
				reader.readAsDataURL(this.files[0]);
			}	
		});

		$("#allergySel").click(function(){
			var allergy_code = $("#allergy_code").val();
			console.log(allergy_code);
			url = "./select_allergy?allergy_code=" + allergy_code;
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=300, height=500");
		});	
		
	    $("#update").click(function(){
	    	
		if ($("#shuttle_num").val() == "") {
			alert("셔틀버스를 선택해주세요.");
			return;
		};
		
		if ($("#staff_num").val() == "") {
			alert("담임교사를 선택해주세요.");
			return;
		};
		
		if ($("#kinder_name").val() == "") {
			alert("원생 이름을 입력해주세요.");
			$("#kinder_name").val().focus();
			return;
		};
		
		if ($("#kinder_rrn1").val() == "" || $("#kinder_rrn2").val() == "") {
			alert("주민등록번호를 입력해주세요.");
			$("#kinder_rrn1").val().focus();
			return;
		};
		
		if ($("#kinder_rrn1").val().length != 6) {
			alert("주민등록번호 앞자리 입력이 잘못되었습니다.");
			$("#kinder_rrn1").val().focus();
			return;
		};
		
		if ($("#kinder_rrn2").val().length != 7) {
			alert("주민등록번호 뒷자리 입력이 잘못되었습니다.");
			$("#kinder_rrn2").val().focus();
			return;
		};
		
		alert("원생 정보 수정이 완료되었습니다.");
		$("form").submit();
		
	});
	
})