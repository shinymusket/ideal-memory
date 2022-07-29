package com.indieus.ius.db;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.StaffIdVO;

@Repository
public class StaffIdDAO {

	@Autowired
	SqlSession sqlsession;

	// 아이디 체크
	public int check_id(String staff_id) throws Exception {
		return sqlsession.selectOne("staffId.check_id", staff_id);
	}

	// 로그인 검사
	public StaffIdVO login(String staff_id) throws Exception {
		return sqlsession.selectOne("staffId.login", staff_id);
	}

	// 로그인 접속일자 변경
	@Transactional
	public int update_log(String staff_id) throws Exception {
		return sqlsession.update("staffId.update_log", staff_id);

	}

}
