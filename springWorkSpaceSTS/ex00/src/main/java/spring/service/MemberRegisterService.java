package spring.service;

import java.util.Date;

import spring.dao.MemberDao;
import spring.exception.AlreadyExistingMemberException;
import spring.vo.Member;
import spring.vo.RegisterRequest;

public class MemberRegisterService { // 회원 가입 기능
	
//	private MemberDao dao = new MemberDao(); // 의존 객체를 직접 생성
	
	private MemberDao dao;
	
	public MemberRegisterService(MemberDao memberDao) {
		this.dao = memberDao; // 생성자를 통한 주입받는다. 
	}
	
	public void regist(RegisterRequest req) {
			
		Member member = dao.selectByEmail(req.getEmail());
		
		if (member != null) {
			throw new AlreadyExistingMemberException("중복 : " + req.getEmail());
		}
		
		Member newMember = new Member(req.getEmail(), req.getPassword(), req.getName(), new Date());
		
		dao.insertMember(newMember);
	}
}
