function getInfo(num) {
	 var staff_num = num;
	 
	 var objParams = {
				staff_num : staff_num
		}
	 
	 $.post(
				"/ius/authority/get_authority_info",
				objParams,
				function(retVal) {
					$("#authorityInfo").hide();
					
					$("#master").prop('checked', false);
					$("#teacher").prop('checked', false);
					$("#dietitian").prop('checked', false);
					$("#facilities").prop('checked', false);
					$("#bus").prop('checked', false);
					$("#info").prop('checked', false);
					$("#event").prop('checked', false);
					$("#gallery").prop('checked', false);
					$("#staff_num").val(staff_num);
					
					value = retVal.authorityInfo;		
					if (value.m == "Y") {
						$("#master").prop('checked', true);
						$("#teacher").prop('disabled', true);
						$("#dietitian").prop('disabled', true);
						$("#facilities").prop('disabled', true);
						$("#bus").prop('disabled', true);
						$("#info").prop('disabled', true);
						$("#event").prop('disabled', true);
						$("#gallery").prop('disabled', true);
		
					} else {
						$("#teacher").prop('disabled', false);
						$("#dietitian").prop('disabled', false);
						$("#facilities").prop('disabled', false);
						$("#bus").prop('disabled', false);
						$("#info").prop('disabled', false);
						$("#event").prop('disabled', false);
						$("#gallery").prop('disabled', false);
					};
					
					if (value.t == "Y") {
						$("#teacher").prop('checked', true);
					};
					if (value.d == "Y") {
						$("#dietitian").prop('checked', true);
					};
					if (value.f == "Y") {
						$("#facilities").prop('checked', true);
					};
					if (value.s == "Y") {
						$("#bus").prop('checked', true);
					};
					if (value.i == "Y") {
						$("#info").prop('checked', true);
					};
					if (value.e == "Y") {
						$("#event").prop('checked', true);
					};
					if (value.g == "Y") {
						$("#gallery").prop('checked', true);
					};
					
					$("#authorityInfo").show();
					
				}
					)
 }



$(function(){
		$("#master").change(function() { // 마스터 권한 체크시 모든 항목 자동 선택, 
		    if(this.checked) {
		       $("#teacher").prop('checked', true);
		       $("#teacher").prop('disabled', true);
		       $("#dietitian").prop('checked', true);
		       $("#dietitian").prop('disabled', true);
		       $("#facilities").prop('checked', true);
		       $("#facilities").prop('disabled', true);
		       $("#bus").prop('checked', true);
		       $("#bus").prop('disabled', true);
		       $("#info").prop('checked', true);
		       $("#info").prop('disabled', true);
		       $("#event").prop('checked', true);
		       $("#event").prop('disabled', true);
		       $("#gallery").prop('checked', true);
		       $("#gallery").prop('disabled', true);
		    };
		    
		    if(!this.checked) {
		    	$("#teacher").prop('checked', false);
		    	$("#teacher").prop('disabled', false);
			    $("#dietitian").prop('checked', false);
			    $("#dietitian").prop('disabled', false);
			    $("#facilities").prop('checked', false);
			    $("#facilities").prop('disabled', false);
			    $("#bus").prop('checked', false);
			    $("#bus").prop('disabled', false);
			    $("#info").prop('checked', false);
			    $("#info").prop('disabled', false);
			    $("#event").prop('checked', false);
			    $("#event").prop('disabled', false);
			    $("#gallery").prop('checked', false);
			    $("#gallery").prop('disabled', false);
		    }
		});
		
		$("#register").click(function() {
			var master;
			var teacher;
			var dietitian;
			var facilities;
			var bus;
			var info;
			var event;
			var gallery;

			if ($("#master").is(':checked')) {
				master = "Y";
			} else if(!$("#master").is(':checked')) {
				master = "N";
			};
			if ($("#teacher").is(':checked')) {
				teacher = "Y";
			} else if(!$("#teacher").is(':checked')) {
				teacher = "N";
			};
			if ($("#dietitian").is(':checked')) {
				dietitian = "Y";
			} else if(!$("#dietitian").is(':checked')) {
				dietitian = "N";
			};
			if ($("#facilities").is(':checked')) {
				facilities = "Y";
			} else if(!$("#facilities").is(':checked')) {
				facilities = "N";
			};
			if ($("#bus").is(':checked')) {
				bus = "Y";
			} else if(!$("#bus").is(':checked')) {
				bus = "N";
			};
			if ($("#info").is(':checked')) {
				info = "Y";
			} else if(!$("#info").is(':checked')) {
				info = "N";
			};
			if ($("#event").is(':checked')) {
				event = "Y";
			} else if(!$("#event").is(':checked')) {
				event = "N";
			};
			if ($("#gallery").is(':checked')) {
				gallery = "Y";
			} else if(!$("#gallery").is(':checked')) {
				gallery = "N";
			};
			
			var objParams = {
				master : master,
				teacher : teacher,
				dietitian : dietitian,
				facilities : facilities,
				bus : bus,
				info : info,
				event : event,
				gallery : gallery,
				staff_num : $("#staff_num").val()
			}
			
			$.post(
					"/ius/authority/set_authority_info",
					objParams,
					function(retVal) {
						alert("권한이 등록 되었습니다.");
					}
					
				)
		});
	
}) 