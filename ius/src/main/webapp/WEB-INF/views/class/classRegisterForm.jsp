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
		 $("#register").click(function(){
			 
			if ($("#class_name").val() == "") {
				alert("학급명을 입력해주세요.");
				$("#class_name").val().focus();
				return;
			};
			
			if ($("#class_name").val().length > 10) {
				alert("학급명은 10자 이하로 입력해야합니다.");
				$("#class_name").val("");
				return;
			};
			 
			frm.submit();
				
		 });
		
		
		
	})

</script>
<title>학급 등록</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>경영 정보</p>
				<h3>학급 등록</h3>
			</div>
	
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<input type="button" value="학급 목록" onclick="location.href='../class/class_list'">
					<form name="frm" action="./class_register" method="POST">
						<table border="1">
							<tr>
								<th>학급 번호</th>
								<td>
									<input type="text" id="class_number" name="class_number" value="${classNumber}" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>학급 명</th>
								<td>
									<input type="text" id="class_name" name="class_name">
								</td>
							</tr>
							<tr>
								<th>담당 교사</th>
								<td>
									<select id="staff_num" name="staff_num">
										<c:if test="${homeTeacherList != null}">
											<c:forEach items="${homeTeacherList}" var="homeTeacher">
												<option value="${homeTeacher.staff_num}">${homeTeacher.staff_name}</option>
											</c:forEach>
										</c:if>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" value="등록" id="register">
								</td>
							</tr>
						</table>
					</form>
				</div>
			</section>
	</article>	
<%@include file="../include/footer.jsp" %>	
</body>
</html>