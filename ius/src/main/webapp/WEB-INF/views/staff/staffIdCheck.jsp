<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("#idOk").click(function(){
			opener.frm.staff_id.value = document.frm.staff_id.value;
			opener.frm.staff_reid.value = document.frm.staff_id.value;
			self.close();
		});
	})

</script>
<title>아이디 중복 확인</title>
</head>
<body>
	<h2>아이디 중복 체크 </h2>
	<form action="./staff_id_check" method="get" name="frm">
		아이디 : <input type="text" name="staff_id" value="${staff_id}">
		<input type="submit" value="중복 체크"> <br>
		
		<c:if test="${result == 1}"> <!-- 중복 아이디 존재 -->
			<script type="text/javascript">
				opener.document.frm.staff_id.value="";
			</script>
			<p>${staff_id}는 이미 사용중인 아이디 입니다.</p>
		</c:if>
		
		<c:if test="${result == 0}"> <!-- 사용 가능 아이디 -->
			<p>${staff_id}는 사용가능한 아이디 입니다.</p>
			<input type="button" value="사용" id="idOk">
		</c:if>
	</form>
</body>
</html>