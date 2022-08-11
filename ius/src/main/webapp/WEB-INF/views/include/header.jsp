<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->  
<div id="container">
        <!-- 헤더 구간 -->
        <header>
        	<input type="hidden" id="login_staff_name" value="${staff_name}">
        	<input type="hidden" id="login_staff_id" value="${staff_id}">
            <div id="logInfo">
            	<p><font id="myNameId" size="2.5"></font>님 환영합니다.<p>
                <a href="../main/logout">로그아웃</a>
                <a href="../main/my_staff_info">회원 정보</a>
            </div>
        </header>
        
<script type="text/javascript">
function setCookie(name,value,days) { // 쿠키 저장
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days*24*60*60*1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}

function getCookie(name) {	// 저장된 쿠키 가져오기
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}


if (document.getElementById("login_staff_name").value == "") { // 로그인후 최초로 온게 아닐 때
	var staff_name = getCookie('staff_name');
	var staff_id = getCookie('staff_id');
	
	document.getElementById("myNameId").innerHTML = staff_name + "(" + staff_id + ")";
	document.getElementById("myNameId").setAttribute("color", "green");
	
	
} else { // 최초로 왔을 때
	var staff_name = document.getElementById("login_staff_name").value;
	var staff_id = document.getElementById("login_staff_id").value;
	// 받아온 값을 쿠키에 저장
	setCookie('staff_name', staff_name);
	setCookie('staff_id', staff_id);
	
	document.getElementById("myNameId").innerHTML = staff_name + "(" + staff_id + ")";
	document.getElementById("myNameId").setAttribute("color", "green");
}



/* $(function(){
	if ($("#login_staff_name").val() == "") { // 로그인후 최초로 온게 아닐 때
		var staff_name = getCookie('staff_name');
		var staff_id = getCookie('staff_id');
		
		$("#myNameId").html(staff_name + "(" + staff_id + ")");
		$("#myNameId").attr("color", "green");
		
		
	} else { // 최초로 왔을 때
		var staff_name = $("#login_staff_name").val();
		var staff_id = $("#login_staff_id").val();
		// 받아온 값을 쿠키에 저장
		setCookie('staff_name', staff_name);
		setCookie('staff_id', staff_id);
		
		$("#myNameId").html(staff_name + "(" + staff_id + ")");
		$("#myNameId").attr("color", "green");
	}
}) */


</script>          