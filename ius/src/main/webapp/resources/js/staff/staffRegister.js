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
	
			var currentDate  = new Date().toISOString().substring(0, 10);
			$("#staff_hireD").val(currentDate);
			
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
		
		
			$("#staff_idChk").click(function(){
				var staff_id = $("#staff_id").val();
				
				if (staff_id == "") {
					alert("아이디를 입력해주세요.");
					return;
				};
				
				var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/); // 아이디 유효성 검사 정규식
				
				if(!userIdCheck.test($("#staff_id").val())) {
					alert("아이디는 영문 대소문자, 숫자 5자리 이상 20자리 이하로 입력하여야 합니다.");
					$("#staff_id").val().focus();
					return;
				};
	
				
				
				let url = "./staff_id_check?staff_id=" + $("#staff_id").val();
				window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=450, height=200");
					
			});

			$("#staff_email").change(function(){
				var staff_email = $("#staff_email").val();
				
				$.ajax({
					url : "/ius/main/get_email_exist_check",
					type : "POST",
					data : {
						staff_email : staff_email
					},
					success: function(data) {
						$("#check_email").val("");
						$("#check").html("");
						
						if(data.result == 0 && staff_email != "") {
							$("#check").html("사용 가능한 이메일 입니다.");
							$("#check").attr("color", "green");
							$("#check_email").val(staff_email);
							
						} else if (data.result > 0){
							$("#check").html("이미 사용중인 이메일 입니다.");
							$("#check").attr("color", "red");
						}
						
					}
					
				})
					
			});
		
		
		    $("#register").click(function(){
		    	var email = $("#staff_email").val();
		    	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		    	
		   
			if ($("#staff_cls").val() == "") {
				alert("직무를 선택해주세요.");
				$("#staff_cls").val().focus();
				return;
			};
			
			if ($("#staff_id").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#staff_id").val().focus();
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
			
			if ($("#staff_salary").val() == "") {
				alert("월급을 입력해주세요.");
				$("#staff_salary").val().focus();
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
			} else if ($("#staff_email").val() != $("#check_email").val()) {
				alert("이미 사용중인 이메일 입니다.");
				$("#staff_email").val().focus();
				return;
			};
			
			
			if ($("#staff_reid").val().length == 0 || $("#staff_reid").val() != $("#staff_id").val()) {
				alert("아이디 중복 검사를 하지 않았습니다.");
				$("#staff_idChk").val().focus();
				return;
			};
			
			
			
			value = cf_getNumberOnly ($("#staff_salary").val());
			$("#staff_salary").val(value);
			alert("교직원 등록이 완료되었습니다.");
			$("form").submit();
			
		});
		
		$("#staff_cls_edit").click(function(){
			url = "./job_class_Edit";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
		});
		
	})