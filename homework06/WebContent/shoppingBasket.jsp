<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
ArrayList<String> basekList = new ArrayList<>();
%>
<%
int pencil = (int) session.getAttribute("pencil");
int erase = (int) session.getAttribute("erase");
int pencilcase = (int) session.getAttribute("pencilcase");
int ballpen = (int) session.getAttribute("ballpen");
int ruler = (int) session.getAttribute("ruler");
int boxCutter = (int) session.getAttribute("boxCutter");
int stapler = (int)session.getAttribute("stapler");
// {"연필", "지우개", "필통", "볼펜", "자", "커터칼", "스테이플러"};

%>
	<h1>장바구니</h1>
	<table>
		<tr>
			<th>상품</th>
			<th>개수</th>
		</tr>
<%
	if (pencil != 0) {
		out.println("<tr>");
		out.println("<td>연필</td>");
		out.println("<td>"+ pencil +"</td>");
		out.println("</tr>");
	}

	if (erase != 0) {
		out.println("<tr>");
		out.println("<td>지우개</td>");
		out.println("<td>"+ erase +"</td>");
		out.println("</tr>");
	}

	if (pencilcase != 0) {
		out.println("<tr>");
		out.println("<td>필통</td>");
		out.println("<td>"+ pencilcase +"</td>");
		out.println("</tr>");
	}

	if (ballpen != 0) {
		out.println("<tr>");
		out.println("<td>볼펜</td>");
		out.println("<td>"+ ballpen +"</td>");
		out.println("</tr>");
	}
	
	if (ruler != 0) {
		out.println("<tr>");
		out.println("<td>자</td>");
		out.println("<td>"+ ruler +"</td>");
		out.println("</tr>");
	}
	
	if (boxCutter != 0) {
		out.println("<tr>");
		out.println("<td>커터칼</td>");
		out.println("<td>"+ boxCutter +"</td>");
		out.println("</tr>");
	}
	
	if (stapler != 0) {
		out.println("<tr>");
		out.println("<td>스테이플러</td>");
		out.println("<td>"+ stapler +"</td>");
		out.println("</tr>");
	}
	

%>		
	</table>


</body>
</html>