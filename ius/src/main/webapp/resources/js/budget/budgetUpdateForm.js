$(function(){
		//키를 누르거나 떼었을때 이벤트 발생
	    $("#budget_total").bind('keyup keydown',function(){
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
		
		
		$("#register").click(function(){
			if($("#budget_iE").val() == "") {
				alert("구분을 선택해주세요.");
				$("#budget_iE").val().focus();
				return;
			};
			
			if($("#budget_cls").val() == "") {
				alert("항목 명을 입력해주세요.");
				$("#budget_cls").val().focus();
				return;
			};
			
			if($("#budget_total").val() == "") {
				alert("총 금액을 입력해주세요.");
				$("#budget_total").val().focus();
				return;
			};
			
			value = cf_getNumberOnly ($("#budget_total").val());
			
			$("#budget_total").val(value);
			
			$("form").submit();
			
		});

	})