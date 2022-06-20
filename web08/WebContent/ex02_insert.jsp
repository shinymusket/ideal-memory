<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>데이터 삽입</title>
</head>
<body>
<%!
	// 연결 객체, 쿼리 전송 객체
	Connection conn = null;
	Statement stmt = null;
	
	// 접속을 위한 정보 5가지
	String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	String uId = "green";
	String uPwd = "1234";
	
	// 삽입할 데이터 준비
	String name = "최길동";
	String userid = "CHOI";
	String userpwd = "1234";
	String email = "choi@naver.com";
	String phone = "010-1234-5678";
	int admin = 0;
%>

<%	

	try {
		// 1 단계 : 드라이버 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
	
		// 2 단계 : 데이터베이스 연결 객체 생성
		conn = DriverManager.getConnection(url, uId, uPwd);
		
		// 3 단계 : 쿼리문을 실행할 객체 생성
		stmt = conn.createStatement();
		
		// 4 단계 : 쿼리문 실행
		String sql = "INSERT INTO member " +
		 			 " VALUES('"+name+"', '"+userid+"', '"+userpwd+"', '"+email+"', '"+phone+"', "+admin+")";
	
		int num = stmt.executeUpdate(sql);
		System.out.println("바뀐 행의 개수 : " + num);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}





%>

</body>
</html>