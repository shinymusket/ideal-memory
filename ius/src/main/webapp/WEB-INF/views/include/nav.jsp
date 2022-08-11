<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<nav>
	<!-- 로그인 아이디의 권한 정보 -->
	<input type="hidden" id="authCode" value="<c:if test="${auth_info.auth_code != null}">${auth_info.auth_code}</c:if>">
            <div id="logo">
                <a href="../main/"><img src="<spring:url value='/resources/logoImg/ius_logo1.png' />" width="200px"></a>
            </div>
            <ul id="sideMenu">
                <li>
                    <a href="#">경영 정보</a>
                    <ul>
                        <li id="staffManager"><a href="../staff/staff_list"><span>교직원 관리</span></a></li>
                        <li id="facilityManager"><a href="../equipment/equipment_list"><span>시설 관리</span></a></li>
                        <li id="boardManager"><a href="../board/board_list"><span>전자 결재</span></a></li>
                        <li id="shuttleManager"><a href="#"><span>셔틀버스 관리</span></a></li>
                        <li id="mealManager"><a href="../meal/meal_list"><span>식단 관리</span></a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">회계 정보</a>
                    <ul>
                        <li><a href="../finance/finance_list"><span>재정 관리</span></a></li>
                    </ul>
                </li>
                <li id="kinderManager">
                    <a href="../kinder/kinder_list">원생 정보</a>
                </li>
                <li>
                    <a href="#">그룹웨어</a>
                    <ul>
                        <li><a href="../notice/notice_list"><span>공지사항</span></a></li>
                        <li><a href="../event/event_list"><span>행사 및 일정</span></a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">고객지원</a>
                </li>
            </ul>
            <br>
            <p class="copyright">Copyright © 2022.<br> Ius All Rights Reserved.</p>
        </nav>
        
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

setCookie("user_email","bobthegreat@gmail.com"); //set "user_email" cookie, expires in 30 days
var userEmail=getCookie("user_email");//"bobthegreat@gmail.com"

$(function(){
	
	function getAuthInfo(authCode) { // 쿠키에 저장된 auth_code로 권한 정보 가져오기
		var auth_code = authCode;
		
		$.ajax({
			url : "/ius/main/get_auth_info_by_code",
			type : "POST",
			data : {
				auth_code : auth_code
			},
			success: function(data) {
				value = data.authInfo;			
				$("#authMaster").val(value.m);
				$("#authTeacher").val(value.t);
				$("#authDietitian").val(value.d);
				$("#authFacility").val(value.f);
				$("#authShuttle").val(value.s);
				$("#authInfomation").val(value.i);
				$("#authEvent").val(value.e);
				$("#authGallery").val(value.g);
				
				var master = value.m;
				var teacher = value.t;
				var dietitian = value.d;
				var facility = value.f;
				var shuttle = value.s;
				
				var information = value.i;
				var event = value.e;
				var gallery = value.g;
				
				// 세션 쿠키에 저장
				setCookie("master", master);
				setCookie("teacher", teacher);
				setCookie("dietitian", dietitian);
				setCookie("facility", facility);
				setCookie("shuttle", shuttle);
				setCookie("information", information);
				setCookie("event", event);
				setCookie("gallery", gallery);
				
				if (master == "N") { // 관리자 권한이 없으면 교직원 관리 사용 권한 없음.
					$("#staffManager").remove();
				};
				if (teacher == "N") { // 교사 권한이 없으면 원생 관리 권한 없음.
					$("#kinderManager").remove();
				};
				if (dietitian == "N") { // 영양사 권한이 없으면 식단 관리 삽입, 수정, 삭제 불가. 조회는 가능.
					
				};
				if (facility == "N") { // 시설 권한이 없으면 시설 관리 삽입, 수정, 삭제 불가. 조회는 가능.
					
				};
				if (shuttle == "N") {// 버스 관리 권한이 없으면 버스 관리 삽입, 수정, 삭제 불가.
				
				};
							
			}
			
		})
	};
	
	
	var authCode = $("#authCode").val();
	
	if (authCode == "") { // 로그인 후 최초로 페이지로 온게 아닐 경우
		authCode = getCookie("auth_cookie");
//		console.log(authCode);
		$("#authCode").val(authCode);
		
		// 세션 쿠키에서 권한 정보를 꺼내 메뉴 구성
			
		var master = getCookie("master");
		var teacher = getCookie("teacher");
		var dietitian = getCookie("dietitian");
		var facility = getCookie("facility");
		var shuttle = getCookie("shuttle");
		
		var information = getCookie("information");
		var event = getCookie("event");
		var gallery = getCookie("gallery");
		
		
		if (master == "N") { // 관리자 권한이 없으면 교직원 관리 사용 권한 없음.
			$("#staffManager").remove();
		};
		if (teacher == "N") { // 교사 권한이 없으면 원생 관리 권한 없음.
			$("#kinderManager").remove();
		};
		if (dietitian == "N") { // 영양사 권한이 없으면 식단 관리 삽입, 수정, 삭제 불가. 조회는 가능.
			
		};
		if (facility == "N") { // 시설 권한이 없으면 시설 관리 삽입, 수정, 삭제 불가. 조회는 가능.
			
		};
		if (shuttle == "N") {// 버스 관리 권한이 없으면 버스 관리 삽입, 수정, 삭제 불가.
		
		};

		
	} else { // 최초로 온 경우
		setCookie("auth_cookie", authCode);
		getAuthInfo(authCode); //
//		console.log(authCode);
		
	};
	

	
	
	

});
	
</script>