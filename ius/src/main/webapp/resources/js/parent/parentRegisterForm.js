$(function(){
		
		$("#relation").change(function(){
			var kinder_num = $("#kinder_num").val();
			var relation = $("#relation").val();
			
			$.ajax({
				url : "/ius/parent/check_kinder_parent",
				type : "POST",
				data : {
					kinder_num : kinder_num,
					relation : relation
				},
				success: function(result) {
					if (result.count > 0) {
						$("#check").html('해당 데이터가 이미 존재합니다.');
						$("#check").attr('color', 'red');
					} else {
						$("#check").html('');
					}
					
				}
				
			})	
		});
		
		$("#select").focus(function(){
			$("#relation").val("").prop("selected", true);
			$("#check").html('');
		});
		
		$("#parent_name").focus(function(){
			if ($("#relation").val() == "부") {
				$("#parent_sex").val("M");
			} else if ($("#relation").val() == "모") {
				$("#parent_sex").val("F");
			}
			
		});
		
		
		$("#select").click(function(){
			url = "./select_kinder";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=400, height=400");
		});
		
		$("#register").click(function(){
			
			if ($("#kinder_num").val() == "") {
				alert("자녀 이름을 입력해주세요.");
				return;
			};
			
			if ($("#relation").val() == "") {
				alert("가족 관계를 선택해주세요.");
				$("#relation").val().focus();
				return;
			};
			
			if ($("#parent_name").val() == "") {
				alert("이름을 입력해주세요.");
				$("#parent_name").val().focus();
				return;
			};
			
			if ($("#parent_tel").val() == "") {
				alert("전화번호를 입력해주세요.");
				$("#parent_tel").val().focus();
				return;
			};
			
			alert("등록이 완료되었습니다.");
			$("form").submit();
			
		});
		
		
	})