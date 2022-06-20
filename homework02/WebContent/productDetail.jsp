<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
</head>
<body>
<%!
	Connection conn = null; // DB 연결용 객체
	Statement stmt = null; // 쿼리 전송용 객체
	ResultSet rs = null; // 조회된 데이터를 저장하기 위한 객체
	
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	String uId = "green";
	String uPwd = "1234";
%>
<h3>상품 상세 정보</h3>
<table border="1">
	<tr>
		<th>상품 이름</th>
		<th>상품 코드</th>
		<th>가격</th>
		<th>제조사</th>
		<th>주요원료</th>
		<th>품절여부(y/n)</th>
	</tr>
	
<% 
String code = (String) request.getAttribute("code");
try {	

Class.forName("oracle.jdbc.driver.OracleDriver");

conn = DriverManager.getConnection(url, uId, uPwd);

stmt = conn.createStatement();

String query = "SELECT * FROM product WHERE pcode ='"+code+"'"; // 쿼리는 문자열로 처리하되 세미콜론은 반드시 뺀다


rs = stmt.executeQuery(query);

while (rs.next()) { 
	String name = rs.getString("pname");
	String price =  rs.getString("pprice");
	String make = rs.getString("pmade");
	String material = rs.getString("pmaterial");
	String soldout = rs.getString("psoldout");
	
	out.println("<tr>");
	out.println("<td>"+ name + "</td>");
	out.println("<td>"+ code + "</td>");
	out.println("<td>" + price + "</td>");
	out.println("<td>" + make + "</td>");
	out.println("<td>" + material + "</td>");
	out.println("<td>" + soldout + "</td>");
	out.println("</tr>");
}



} catch (Exception e) {
	e.printStackTrace();
} finally {
	try {
		if (rs != null) {
			rs.close();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}
}



%>


</body>
</html>