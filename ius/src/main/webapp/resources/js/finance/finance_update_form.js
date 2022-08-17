$(function(){
	
    //키를 누르거나 떼었을때 이벤트 발생
    $("#finance_amount").bind('keyup keydown',function(){
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
    	if($("#finance_eYear").val() == "") {
			alert("회계 년도를 입력해주세요.");
			$("#finance_eYear").val().focus();
			return;
		};
    	
		if($("#budget_num").val() == "") {
			alert("예산 항목을 선택해주세요.");
			$("#budget_num").val().focus();
			return;
		};
		
		if($("#staff_num").val() == "") {
			alert("교직원 명을 입력해주세요.");
			$("#staff_num").val().focus();
			return;
		};
		
		if($("#finance_eDate").val() == "") {
			alert("집행 날짜를 입력해주세요.");
			$("#finance_eDate").val().focus();
			return;
		};
		
		if($("#finance_amount").val() == "") {
			alert("집행 금액을 입력해주세요.");
			$("#finance_amount").val().focus();
			return;
		};
		
		value = cf_getNumberOnly ($("#finance_amount").val());
		
		$("#finance_amount").val(value);
		$("form").submit();
		
	});

})	