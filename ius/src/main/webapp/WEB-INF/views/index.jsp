<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${path}/resources/js/index.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유치원 관리 프로그램</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/style.css">
</head>
<body>
<!-- 	 <div id="login_box">
	 <h2>아이어스</h2>
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
     -->
   
   <div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				
				<form class="login100-form validate-form" action="./main/loginCheck" method="post">
					<span class="login100-form-title">
						<b>Member Login</b>
					</span>

					<div class="wrap-input100 validate-input" data-validate = "아이디를 입력해 주세요">
						<input class="input100" type="text" name="staff_id" placeholder="ID">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-envelope" aria-hidden="true"></i>
						</span>
					</div>

					<div class="wrap-input100 validate-input" data-validate = "비밀번호를 입력해 주세요">
						<input class="input100" type="password" name="staff_pwd" placeholder="Password">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-lock" aria-hidden="true"></i>
						</span>
					</div>
					
					<div class="container-login100-form-btn">
						<input type="submit" class="login100-form-btn" value="로그인">
					</div>

					<div class="text-center p-t-12">
						<span class="txt1">
							
						</span>
						<a href="#" class="txt2" id="searchPwd">
						비밀번호 찾기
						</a>
					</div>

					<div class="text-center p-t-136">
					</div>
				</form>
			</div>
		</div>
	</div>
   
</body>
</html>