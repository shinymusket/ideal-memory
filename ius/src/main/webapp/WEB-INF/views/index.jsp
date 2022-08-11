<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#searchPwd").click(function(){
			var popupWidth = 600;
			var popupHeight = 250;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY = (window.screen.height/2) - (popupHeight/2);
				
			let url = "./main/search_password";
			window.open(url, '', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		})
	})

</script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유치원 관리 프로그램</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/style.css?">
</head>
<body>
	 <div id="login_box">
        <form action="./main/loginCheck" method="post">
            <ul>
                <li>
                    <label for="staff_id">아이디</label>
                    <input type="text" id="staff_id" name="staff_id" required="required">
                </li>
                <li>
                    <label for="user_pwd">비밀번호</label>
                    <input type="password" id="staff_pwd" name="staff_pwd" required="required">
                </li>
            </ul>
                <input type="submit" value="로그인">
                <input type="button" value="비밀번호 찾기" id="searchPwd">
        </form>
    </div>
</body>
</html>