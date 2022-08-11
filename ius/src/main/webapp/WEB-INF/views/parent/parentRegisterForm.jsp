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
		
		$("#relation").change(function(){
			var kinder_num = $("#kinder_num").val();
			var relation = $("#relation").val();
			
			$.ajax({
				url : "/ius/parent/check_kinder_parent",
				type : "POST",
				data : {
					kinder_num : kinder_num,
					relation : relation
				},
				success: function(result) {
					if (result.count > 0) {
						$("#check").html('해당 데이터가 이미 존재합니다.');
						$("#check").attr('color', 'red');
					} else {
						$("#check").html('');
					}
					
				}
				
			})	
		});
		
		$("#select").focus(function(){
			$("#relation").val("").prop("selected", true);
			$("#check").html('');
		});
		
		$("#parent_name").focus(function(){
			if ($("#relation").val() == "부") {
				$("#parent_sex").val("M");
			} else if ($("#relation").val() == "모") {
				$("#parent_sex").val("F");
			}
			
		});
		
		
		$("#select").click(function(){
			url = "./select_kinder";
			window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbar=yes, resizeable=no, width=400, height=400");
		});
		
		$("#register").click(function(){
			
			if ($("#kinder_num").val() == "") {
				alert("자녀 이름을 입력해주세요.");
				return;
			};
			
			if ($("#relation").val() == "") {
				alert("가족 관계를 선택해주세요.");
				$("#relation").val().focus();
				return;
			};
			
			if ($("#parent_name").val() == "") {
				alert("이름을 입력해주세요.");
				$("#parent_name").val().focus();
				return;
			};
			
			if ($("#parent_tel").val() == "") {
				alert("전화번호를 입력해주세요.");
				$("#parent_tel").val().focus();
				return;
			};
			
			$("form").submit();
			
		});
		
		
	})

</script>
<title>학부모 정보 입력</title>
<link type="text/css" rel="stylesheet" href="${path}/resources/css/articleF.css">
</head>
<body>
<%@include file="../include/header.jsp" %>
<%@include file="../include/nav.jsp" %>
	<article>
			<div id="title_bar">
				<p>원생 관리</p>
				<h3>학부모 정보 입력</h3>
			</div>
			
			<div id="title_top">
			</div>
	
			<section>
				<div id="content">
					<form action="./parent_register" method="POST" name="frm">
						<table border="1">
							<tr>
								<th>자녀 이름</th>
								<td>
									<input type="text" id="kinder_name" name="kinder_name" readonly="readonly">
									<input type="hidden" id="kinder_num" name="kinder_num">
									<input type="button" value="조회" id="select">
								<td>
							</tr>
							<tr>
								<th>가족 관계</th>
								<td>
									<select id="relation" name="relation">
										<option value="" selected="selected">-선택-</option>
										<option value="부">부</option>
										<option value="모">모</option>
									</select>
									<font id="check" size="2"></font>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" id="parent_name" name="parent_name">
								</td>
							</tr>
							<tr>
								<th>전화 번호</th>
								<td>
									<input type="text" id="parent_tel" name="parent_tel">
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<input type="text" id="parent_email" name="parent_email">
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<input type="text" id="parent_sex" name="parent_sex" readonly="readonly"> 
<!-- 									<select id="parent_sex" name="parent_sex">
										<option value="M">남성</option>
										<option value="F">여성</option>
									</select> -->
								</td>
							</tr>
							<tr>
								<th>생년 월일</th>
								<td>
									<input type="date" id="parent_birth" name="parent_birth">
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