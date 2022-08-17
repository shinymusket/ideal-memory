function addComma(value){
	result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
    return result;
};


$(function(){
	$("#staff_picFile").change(function(){
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".select_img img").attr("src", data.target.result).width(94.4);
			}
			reader.readAsDataURL(this.files[0]);
		}	
	});

	
	$("#updateForm").click(function(){ // 수정 모드
		alert("수정할 항목을 입력한 후 완료 버튼을 누르세요.");
		
		// 변경 불가한 항목
		$("#staff_num").prop("disabled", true);
		$("#job_Kname").prop("disabled", true);
		$("#staff_id").prop("disabled", true);
		$("#staff_rrn1").prop("disabled", true);
		$("#staff_rrn2").prop("disabled", true);
		$("#staff_hireD").prop("disabled", true);
		$("#staff_workYn").prop("disabled", true);
		$("#staff_salary").prop("disabled", true);
		$("#staff_email").prop("disabled", true);
		
		// 변경 가능한 항목
		$("#staff_name").prop("readonly", false);
		$("#staff_tel").prop("readonly", false);
		$("#staff_addr").prop("readonly", false);
		$('#select_addr').css('display', 'inline');
		
		// 사진업로드 항목 보이기
		$("#staff_picFile").show();
		
		$("#updateForm").hide();
		$("#cancel").show();
		$("#update").show();
			
	});
	
	$("#cancel").click(function(){ // 수정 취소
		alert("수정이 취소되었습니다.");
		
		var origin_addr = $("#origin_addr").val();
		var origin_zipcode = $("#origin_zipcode").val();
		var origin_tel = $("#origin_tel").val();
	
		$("#staff_addr").val(origin_addr);
		$("#staff_zipcode").val(origin_zipcode);
		$("#staff_tel").val(origin_tel);

		
		$("#staff_num").prop("disabled", false);
		$("#job_Kname").prop("disabled", false);
		$("#staff_id").prop("disabled", false);
		$("#staff_rrn1").prop("disabled", false);
		$("#staff_rrn2").prop("disabled", false);
		$("#staff_hireD").prop("disabled", false);
		$("#staff_workYn").prop("disabled", false);
		$("#staff_salary").prop("disabled", false);
		$("#staff_email").prop("disabled", false);
		
		$("#staff_name").prop("readonly", true);
		$("#staff_addr").prop("readonly", true);
		$("#select_addr").hide();
		$("#staff_tel").prop("readonly", true);
		
		$("#staff_picFile").hide();
		
		$("#updateForm").show();
		$("#cancel").hide();
		$("#update").hide();
	});
	
	$("#update").click(function(){ // 수정
		alert("수정이 완료되었습니다.");
		
		$("#staff_num").prop("disabled", false);
		$("#job_Kname").prop("disabled", false);
		$("#staff_id").prop("disabled", false);
		$("#staff_rrn1").prop("disabled", false);
		$("#staff_rrn2").prop("disabled", false);
		$("#staff_hireD").prop("disabled", false);
		$("#staff_workYn").prop("disabled", false);
		$("#staff_salary").prop("disabled", false);
		$("#staff_email").prop("disabled", false);
		
		$("#staff_name").prop("readonly", true);
		$("#staff_addr").prop("readonly", true);
		$("#select_addr").hide();
		$("#staff_tel").prop("readonly", true);
		
		$("#staff_picFile").hide();
		
		$("#updateForm").show();
		$("#cancel").hide();
		$("#update").hide();
		
		$("form").submit();
		
	});
});
