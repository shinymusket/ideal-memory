<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int num1 = 10;
		int num2 = 20;
		
		int result = num1 + num2;
		
	%>
	
	<p><%=num1 %>+<%=num2 %> = <%=result %></p> 
	
</body>
</html>