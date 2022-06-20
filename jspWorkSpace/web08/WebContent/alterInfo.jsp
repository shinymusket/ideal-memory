<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
	Connection conn = null;
	PreparedStatement psmt = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	String uId = "green";
	String uPwd = "1234";

%>

<%
	request.setCharacterEncoding("UTF-8");	
	String name = request.getParameter("aName");
	String userid = request.getParameter("aId");
	String userpwd = request.getParameter("aPwd");
	String email = request.getParameter("aEmail");
	String phone = request.getParameter("aPhone");
	int admin = Integer.parseInt(request.getParameter("aAdmin"));




	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	
		conn = DriverManager.getConnection(url, uId, uPwd);
		
		
		String sql = "UPDATE member SET userid = ?, userpwd = ?, email = ?, phone = ?, admin = ? WHERE name = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, userid);
		psmt.setString(2, userpwd);
		psmt.setString(3, email);
		psmt.setString(4, phone);
		psmt.setInt(5, admin);
		psmt.setString(6, name);
	
		int num = psmt.executeUpdate();
		System.out.println("바뀐 행의 개수 : " + num); %>
		
		<h1>수정 완료!</h1>		
<%	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (psmt != null) psmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

%>
</body>
</html>