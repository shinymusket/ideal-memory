$(function(){
		$("#staff_picFile").change(function(){
			if(this.files && this.files[0]) {
				var reader = new FileReader;
				reader.onload = function(data) {
					$(".select_img img").attr("src", data.target.result).width(500);
				}
				reader.readAsDataURL(this.files[0]);
			}	
		});
	
		//키를 누르거나 떼었을때 이벤트 발생
	    $("#staff_salary").bind('keyup keydown',function(){
	        inputNumberFormat(this);
	    });
	
	    //입력한 문자열 전달
	    function inputNumberFormat(obj) {
	        obj.value = comma(uncomma(obj.value));
	    };
	      
	    //콤마찍기
	    function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    };
	
	    //콤마풀기
	    function uncomma(str) {
	        str = String(str);
	        return str.replace(/[^\d]+/g, '');
	    };
	
	    //숫자만 리턴(저장할때)
	    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
	    function cf_getNumberOnly (str) {
	        var len      = str.length;
	        var sReturn  = "";
	
	        for (var i=0; i<len; i++){
	            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
	                sReturn += str.charAt(i);
	            }
	        }
	        return sReturn;
	    };

	    $("#update").click(function(){
	    	var email = $("#staff_email").val();
	    	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	    	
	   
		if ($("#staff_cls").val() == "") {
			alert("직무를 선택해주세요.");
			$("#staff_cls").val().focus();
			return;
		};
		
		
		if ($("#staff_name").val() == "") {
			alert("이름을 입력해주세요.");
			$("#staff_name").val().focus();
			return;
		};
		
		if ($("#staff_rrn1").val() == "" || $("#staff_rrn2").val() == "") {
			alert("주민등록번호를 입력해주세요.");
			$("#staff_rrn").val().focus();
			return;
		};
		
		if ($("#staff_rrn1").val().length != 6) {
			alert("주민등록번호 앞자리 입력이 잘못되었습니다.");
			$("#staff_rrn1").val().focus();
			return;
		};
		
		if ($("#staff_rrn2").val().length != 7) {
			alert("주민등록번호 뒷자리 입력이 잘못되었습니다.");
			$("#staff_rrn2").val().focus();
			return;
		};
		
		if (email == "") {
			alert("이메일은 필수 입력 항목입니다.");
			$("#staff_email").val().focus();
			return;
		} else if (exptext.test(email) == false) {
			alert("이메일 형식이 올바르지 않습니다.");
			$("#staff_email").val().focus();
			return;
		};
			
			
		value = cf_getNumberOnly ($("#staff_salary").val());
			
			$("#staff_salary").val(value);
			$("form").submit();
			
		});
		

})