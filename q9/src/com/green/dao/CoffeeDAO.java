package com.green.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CoffeeDAO {
	// 쿼리당 메서드
	// 싱글톤
	// 1. 생성자 차단	
	private CoffeeDAO() {}
	// 2. static 필드에 인스턴스 생성
	private static CoffeeDAO dao = new CoffeeDAO();
	// 3. 외부 호출 메서드 생성
	public static CoffeeDAO getInstance() {
		return dao;
	}
	
	
	// 4. 연결객체를 불러오는 메서드
	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
		conn = ds.getConnection();
		
		return conn;
	}
	
	// 5. 커피 이름을 알아오는 메서드
	// 3단계
	public List<String> getCoffeeName() {
		List<String> names = new ArrayList<>();
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT DISTINCT(coffeeName) FROM CoffeePriceTbl ORDER BY coffeeName";
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String coffeeName = rs.getString(1);
				names.add(coffeeName);
			}
		
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return names;
		
	}
	
	// 6. 커피 가격을 알아오는 메서드
	// 9 단계
	public int getCoffeePrice(String coffeeName, String coffeeType) {
		int price = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT price FROM CoffeePriceTbl WHERE coffeeName=? AND coffeeType=?";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, coffeeName);
			psmt.setString(2, coffeeType);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				price = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (psmt != null) psmt.close();
				if (conn != null) conn.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		return price;
	}
	
	
	
	
	
	

	
}
