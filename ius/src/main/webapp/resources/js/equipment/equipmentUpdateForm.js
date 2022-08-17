$(function(){
		$("#equipment_cls_edit_btn").click(function(){
			url = "./equipment_class_edit";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
		});
		
		$("#update").click(function(){
			if ($("#equip_cls_num").val().trim() === "") {
				alert("분류 항목을 선택해주세요.");
				$("#equip_cls_num").val().focus();
				return;
			};
			if ($("#equipment_name").val().trim() === "") {
				alert("시설(비품) 명을 입력해주세요.")
				$("#equipment_name").val().focus();
				return;
			};
			
			if ($("#equipment_name").val().length > 10) {
				alert("시설(비품) 명은 10자이하여야 합니다.")
				$("#equipment_name").val().focus();
				return;	
			};
			
			frm.submit();
			
		});
		
	})