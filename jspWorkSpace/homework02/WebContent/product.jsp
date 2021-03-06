<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
</head>
<body>
<%!
	Connection conn = null;
	PreparedStatement psmt = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	String uId = "green";
	String uPwd = "1234";
	
	int admin = 0;
%>

<%
	request.setCharacterEncoding("UTF-8");	

	String name = request.getParameter("name");
	String code = request.getParameter("code");
	String price = request.getParameter("price");
	String make = request.getParameter("make");
	String material = request.getParameter("material");
	String soldout = request.getParameter("soldout");


	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	
		conn = DriverManager.getConnection(url, uId, uPwd);
		
		String sql =  "INSERT INTO product VALUES(?, ?, ?, ?, ?, ?)";
		
		psmt = conn.prepareStatement(sql);
		
		
		psmt.setString(1, name);
		psmt.setString(2, code);
		psmt.setString(3, price);
		psmt.setString(4, make);
		psmt.setString(5, material);
		psmt.setString(6, soldout);
	
		int num = psmt.executeUpdate();
		System.out.println("바뀐 행의 개수 : " + num); %>
		
		<h1>상품등록 성공!</h1>		
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

<jsp:forward page="productList.jsp"></jsp:forward>
</body>
</html>