<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알러지 정보 입력</title>
<link rel="stylesheet" href="${path}/resources/css/allergy.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	$("#na").change(function(){ // 알러지 없음 체크시 모든 항목 자동 해제
		if(this.checked) {
			$("#a1").prop('checked', false);
			$("#a2").prop('checked', false);
			$("#a3").prop('checked', false);
			$("#a4").prop('checked', false);
			$("#a5").prop('checked', false);
			$("#a6").prop('checked', false);
			$("#a7").prop('checked', false);
			$("#a8").prop('checked', false);
			$("#a9").prop('checked', false);
			$("#a10").prop('checked', false);
			$("#a11").prop('checked', false);
			$("#a12").prop('checked', false);
			$("#a13").prop('checked', false);
			$("#a14").prop('checked', false);
			$("#a15").prop('checked', false);
			$("#a16").prop('checked', false);
			$("#a17").prop('checked', false);
			$("#a18").prop('checked', false);
			
			$("#a1").prop('disabled', true);
			$("#a2").prop('disabled', true);
			$("#a3").prop('disabled', true);
			$("#a4").prop('disabled', true);
			$("#a5").prop('disabled', true);
			$("#a6").prop('disabled', true);
			$("#a7").prop('disabled', true);
			$("#a8").prop('disabled', true);
			$("#a9").prop('disabled', true);
			$("#a10").prop('disabled', true);
			$("#a11").prop('disabled', true);
			$("#a12").prop('disabled', true);
			$("#a13").prop('disabled', true);
			$("#a14").prop('disabled', true);
			$("#a15").prop('disabled', true);
			$("#a16").prop('disabled', true);
			$("#a17").prop('disabled', true);
			$("#a18").prop('disabled', true);					
		};
		
		if(!this.checked) {
			$("#a1").prop('disabled', false);
			$("#a2").prop('disabled', false);
			$("#a3").prop('disabled', false);
			$("#a4").prop('disabled', false);
			$("#a5").prop('disabled', false);
			$("#a6").prop('disabled', false);
			$("#a7").prop('disabled', false);
			$("#a8").prop('disabled', false);
			$("#a9").prop('disabled', false);
			$("#a10").prop('disabled', false);
			$("#a11").prop('disabled', false);
			$("#a12").prop('disabled', false);
			$("#a13").prop('disabled', false);
			$("#a14").prop('disabled', false);
			$("#a15").prop('disabled', false);
			$("#a16").prop('disabled', false);
			$("#a17").prop('disabled', false);
			$("#a18").prop('disabled', false);	
		};
	
	});
	
	$("#register").click(function(){
		var a1;
		var a2;
		var a3;
		var a4;
		var a5;
		var a6;
		var a7;
		var a8;
		var a9;
		var a10;
		var a11;
		var a12;
		var a13;
		var a14;
		var a15;
		var a16;
		var a17;
		var a18;
		
		if ($("#a1").is(':checked')) {
			a1 = "Y";
		} else if(!$("#a1").is(':checked')) {
			a1 = "N";
		};
		if ($("#a2").is(':checked')) {
			a2 = "Y";
		} else if(!$("#a2").is(':checked')) {
			a2 = "N";
		};
		if ($("#a3").is(':checked')) {
			a3 = "Y";
		} else if(!$("#a3").is(':checked')) {
			a3 = "N";
		};
		if ($("#a4").is(':checked')) {
			a4 = "Y";
		} else if(!$("#a4").is(':checked')) {
			a4 = "N";
		};
		if ($("#a5").is(':checked')) {
			a5 = "Y";
		} else if(!$("#a5").is(':checked')) {
			a5 = "N";
		};
		if ($("#a6").is(':checked')) {
			a6 = "Y";
		} else if(!$("#a6").is(':checked')) {
			a6 = "N";
		};
		if ($("#a7").is(':checked')) {
			a7 = "Y";
		} else if(!$("#a7").is(':checked')) {
			a7 = "N";
		};
		if ($("#a8").is(':checked')) {
			a8 = "Y";
		} else if(!$("#a8").is(':checked')) {
			a8 = "N";
		};
		if ($("#a9").is(':checked')) {
			a9 = "Y";
		} else if(!$("#a9").is(':checked')) {
			a9 = "N";
		};
		if ($("#a10").is(':checked')) {
			a10 = "Y";
		} else if(!$("#a10").is(':checked')) {
			a10 = "N";
		};
		if ($("#a11").is(':checked')) {
			a11 = "Y";
		} else if(!$("#a11").is(':checked')) {
			a11 = "N";
		};
		if ($("#a12").is(':checked')) {
			a12 = "Y";
		} else if(!$("#a12").is(':checked')) {
			a12 = "N";
		};
		if ($("#a13").is(':checked')) {
			a13 = "Y";
		} else if(!$("#a13").is(':checked')) {
			a13 = "N";
		};
		if ($("#a14").is(':checked')) {
			a14 = "Y";
		} else if(!$("#a14").is(':checked')) {
			a14 = "N";
		};
		if ($("#a15").is(':checked')) {
			a15 = "Y";
		} else if(!$("#a15").is(':checked')) {
			a15 = "N";
		};
		if ($("#a16").is(':checked')) {
			a16 = "Y";
		} else if(!$("#a16").is(':checked')) {
			a16 = "N";
		};
		if ($("#a17").is(':checked')) {
			a17 = "Y";
		} else if(!$("#a17").is(':checked')) {
			a17 = "N";
		};
		if ($("#a18").is(':checked')) {
			a18 = "Y";
		} else if(!$("#a18").is(':checked')) {
			a18 = "N";
		};
		
		var objParams = {
			a1 : a1,
			a2 : a2,
			a3 : a3,
			a4 : a4,
			a5 : a5,
			a6 : a6,
			a7 : a7,
			a8 : a8,
			a9 : a9,
			a10 : a10,
			a11 : a11,
			a12 : a12,
			a13 : a13,
			a14 : a14,
			a15 : a15,
			a16 : a16,
			a17 : a17,
			a18 : a18	
		}
		
		$.post(
			"/ius/kinder/set_allergy_info",
			objParams,
			function(data) {
				opener.frm.allergy_code.value = data.allergy_code;
				$(opener.location).attr("href", "javascript:getAllergyCheck();");
				self.close();
			}
		
		
		)
		
	});
	
})

	
</script>
</head>
<body>
<form name="allergy">
	<div id="allergy_box">
		<ul>
			<li>
				<input type="checkbox" id="na">알러지 없음
			</li>
			<li>
				<input type="checkbox" id="a1">난류(가금류)
			</li>
			<li>
				<input type="checkbox" id="a2">우유
			</li>
			<li>
				<input type="checkbox" id="a3">메밀
			</li>
			<li>
				<input type="checkbox" id="a4">땅콩
			</li>
			<li>
				<input type="checkbox" id="a5">대두
			</li>
			<li>
				<input type="checkbox" id="a6">밀
			</li>
			<li>
				<input type="checkbox" id="a7">고등어
			</li>
			<li>
				<input type="checkbox" id="a8">게
			</li>
			<li>
				<input type="checkbox" id="a9">새우
			</li>
			<li>
				<input type="checkbox" id="a10">돼지고기
			</li>
			<li>
				<input type="checkbox" id="a11">복숭아
			</li>
			<li>
				<input type="checkbox" id="a12">토마토
			</li>
			<li>
				<input type="checkbox" id="a13">아황산염
			</li>
			<li>
				<input type="checkbox" id="a14">호두
			</li>
			<li>
				<input type="checkbox" id="a15">닭고기
			</li>
			<li>
				<input type="checkbox" id="a16">쇠고기
			</li>
			<li>
				<input type="checkbox" id="a17">오징어
			</li>
			<li>
				<input type="checkbox" id="a18">조개류
			</li>
		</ul>
		<div id="but_box">
			<input type="button" value="확인" id="register">
		</div>
	</div>
</form>
</body>
</html>