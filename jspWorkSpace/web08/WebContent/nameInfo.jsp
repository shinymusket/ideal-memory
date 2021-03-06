<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %> 
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색된 정보</title>
</head>
<body>
<%!
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	String uId = "green";
	String uPwd = "1234";

%>
	<h1>검색된 정보</h1>

	
<%
	try {
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		session.setAttribute("name", name);

		Class.forName("oracle.jdbc.driver.OracleDriver");

		conn = DriverManager.getConnection(url, uId, uPwd);

		stmt = conn.createStatement();

		String query = "SELECT * FROM member WHERE name='"+name+"'";

		rs = stmt.executeQuery(query);

		while (rs.next()) {
			request.setAttribute("userid", rs.getString("userid"));
			request.setAttribute("userpwd", rs.getString("userpwd"));
			request.setAttribute("email", rs.getString("email"));
			request.setAttribute("phone", rs.getString("phone"));
			request.setAttribute("admin", rs.getInt("admin"));
					
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

%>
<h3>변경할 정보</h3>
<form action="alterInfo.jsp" method="post">
	<label for="aName">이름</label>
	<input type=text id="aName" name="aName" value="${name}" placeholder><br>
	<label for="aId">아이디</label>
	<input type="text" id="aId" name="aId" value="${userid}"><br>
	<label for="aPwd">비밀번호</label>
	<input type="password" id="aPwd" name="aPwd" required><br>
	<label for="aEmail">이메일</label>
	<input type="email" id="aEmail" name="aEmail" value="${email}"><br>
	<label for="aPhone">전화번호</label>
	<input type="tel" id="aPhone" name="aPhone" value="${phone}"><br>
	<label for="aAdmin">권한(1:관리자, 0:일반 회원)</label>
	<input type="number" min="0" max="1" id="aAdmin" value="${admin}" name="aAdmin"><br>
	<input type="submit" value="수정">
</form>

</body>
</html>