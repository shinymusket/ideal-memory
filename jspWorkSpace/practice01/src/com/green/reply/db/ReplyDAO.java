package com.green.reply.db;

import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class ReplyDAO {
	
	private ReplyDAO() {}
	private SqlSession session;
	private static ReplyDAO instance = new ReplyDAO();
	
	public static ReplyDAO getInstance() {
		return instance;
	}
	
	// myBatis
	private SqlSession getSession() {
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader("./SqlMapConfig.xml");
			SqlSessionFactory sf = new SqlSessionFactoryBuilder().build(reader);
			session = sf.openSession();	
			
		} catch(Exception e) {
			System.out.println("getSession 에러 : " + e);
			e.printStackTrace();
		}
		return session;
	}
	
	// 댓글 입력
	public void insertReply(ReplyDTO dto) {
		try {
			session = getSession();
			session.insert("reply.insertReply", dto);
			session.commit();
			
		} catch(Exception e) {
			System.out.println("insertReply 에러 : " + e);
			e.printStackTrace();
		}
		
	}
	
	// 댓글 리스트
	public List<ReplyDTO> getReply(int board_no) {
		List<ReplyDTO> list = null;
		try {
			session = getSession();
			list = session.selectList("reply.getReply", board_no);
		} catch(Exception e) {
			System.out.println("getReply 에러 : " + e);
			e.printStackTrace();
		}
		return list;
	}
	
}
