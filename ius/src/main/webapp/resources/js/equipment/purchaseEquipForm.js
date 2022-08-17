$(function(){
	var currentDate  = new Date().toISOString().substring(0, 10);
	$("#purchase_date").val(currentDate);
	

    //키를 누르거나 떼었을때 이벤트 발생
    $("#purchase_price").bind('keyup keydown',function(){
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
    
    $("#finance_select").click(function(){
    	url = "./equipment_finance_select";
		window.open(url, "_blank_1", "toolbar=yes, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
    });
    
    $("#equip_cls_sel").click(function(){
		url = "./equipment_class_edit";
		window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=550, height=400");
    });
    
    $("#register").click(function(){
    	if($("#finance_num").val().trim() == "") {
    		alert("재정 코드를 선택해주세요.");
    		$("#finance_num").val().focus();
    		return;
    	};
    	if($("#equip_cls_num").val().trim() == "") {
    		alert("분류 항목을 선택해주세요.");
    		$("#equip_cls_num").val().focus();
    		return;
    	};
    	if($("#equipment_name").val().trim() == "") {
    		alert("비품명을 입력해주세요.");
    		$("#equipment_name").val().focus();
    		return;
    	};
    	if($("#equipment_name").val().length > 10) {
    		alert("비품명은 10자이하여야 합니다.");
    		$("#equipment_name").val().focus();
    		return;
    	};
    	if($("#purchase_price").val().trim() == "") {
    		alert("구매 가격을 입력해주세요.");
    		$("#purchase_price").val().focus();
    		return;
    	};
    	
		value = cf_getNumberOnly ($("#purchase_price").val());
		$("#purchase_price").val(value);
		
		frm.submit();
    	
    });
    
   
})