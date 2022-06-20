package com.green.question;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/MIIS")
public class MemberInfoInsertServlet extends HttpServlet {
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	private String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 프로토콜 정보 : jdbc:oracle:thin:@~~~
	private String uId = "green";
	private String uPwd = "1234";
	
	int admin = 0;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");	

		String name = request.getParameter("name");
		String userid = request.getParameter("userid");
		String userpwd = request.getParameter("userpwd");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			conn = DriverManager.getConnection(url, uId, uPwd);
			
			String sql =  "INSERT INTO member VALUES(?, ?, ?, ?, ?, ?)";
			
			psmt = conn.prepareStatement(sql);
			
			
			psmt.setString(1, name);
			psmt.setString(2, userid);
			psmt.setString(3, userpwd);
			psmt.setString(4, email);
			psmt.setString(5, phone);
			psmt.setInt(6, admin);
		
			int num = psmt.executeUpdate();
			System.out.println("바뀐 행의 개수 : " + num);
			
			
	
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
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
	
	}

}
