<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>    
<%! 
	ArrayList<String> tdList = new ArrayList<>();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	response.setContentType("text/html;charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	String td = request.getParameter("toDo");
/* 	int index = Integer.parseInt(request.getParameter("index")); */
	
	if (td != null) {
		tdList.add(td);
	}
	

	
%>
<ul>


<%	
	for (int i = 0; i < tdList.size(); i++ ) {
%>

	<li><%=tdList.get(i)%> <a href="DeleteList?index=<%=i%>"><button type="button">삭제</button></a></li>
<%			
	}
%>
</ul>
<a href="q4.html"><input type="button" value="할 일 기록"></a>
</body>

<%
	session.setAttribute("tdList", tdList);
%>
</html>