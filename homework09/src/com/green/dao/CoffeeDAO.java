package com.green.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.green.vo.CoffeeVO;

public class CoffeeDAO {
	
	private CoffeeDAO() {}
	
	private static CoffeeDAO dao = new CoffeeDAO();
	
	public static CoffeeDAO getInstance() {
		return dao;
	}	
	
	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
		conn = ds.getConnection();
		
		return conn;
	}
	
	// 이름과 사이즈, 수량으로 가격 가져오기
	public CoffeeVO getCoffee(String cName, String cType, int count) {
		CoffeeVO cVo = null;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM coffee WHERE cname=?";
		
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
				
			psmt.setString(1, cName);
			rs = psmt.executeQuery();
			
			/*
			 * while(rs.next()) { System.out.println(rs.getString(cType)); }
			 */
	
			if(rs.next()) {
				cVo = new CoffeeVO();
				cVo.setcName(rs.getString("cname"));
				cVo.setcType(cType);
				cVo.setCount(count);
				
				int price = 0;
				if (cType.equals("tall")) {
					price = rs.getInt("tall");
				} else if (cType.equals("grande")) {
					price = rs.getInt("grande");
				} else if (cType.equals("venti")) {
					price = rs.getInt("venti");
				}
				
				cVo.setPrice(price);
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
		
		
			return cVo;
	}
	
	
	// 메뉴판의 커피 메뉴 가져오기
	public String[] setMenuList() {
		String[] menuList = new String[7];

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT cname FROM coffee";
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			int count = 0;
			while (rs.next()) {
				String name = rs.getString("cname");
				menuList[count] = name;
				count++;
			}
				
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
			
		return menuList;
	}
	
}
