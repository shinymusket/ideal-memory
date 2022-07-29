package com.indieus.ius.db;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.AuthorityVO;
import com.indieus.ius.vo.StaffIdVO;

public class AuthorityDAO {

	@Autowired
	SqlSession sqlsession = null;

	// 교직원 번호로 권한 코드 가져오기
	public String selectAuthCodeByStaffNum(String staff_num) {
		return sqlsession.selectOne("authority.select_auth_code_by_staff_num", staff_num);
	}

	// 코드로 권한 정보 가져오기
	public AuthorityVO selectAuthByCode(String auth_code) {
		return sqlsession.selectOne("authority.select_auth_by_code", auth_code);
	}

	// 권한 코드 추가하기 전 이미 존재하는 권한 타입인지 체크
	public int selectCntAuth(AuthorityVO aVo) {
		return sqlsession.selectOne("authority.select_cnt_auth", aVo);
	}

	// 이미 존재하는 권한 코드 가져오기
	public String selectAuthByContent(AuthorityVO aVo) {
		return sqlsession.selectOne("authority.select_auth_by_content", aVo);
	}

	// 직원 코드로 직원 아이디 가져오기
	public String selectStaffIdByStaffNum(String staff_num) {
		return sqlsession.selectOne("authority.select_staff_id_by_staff_num", staff_num);
	}

	// 직원 아이디 가져오기
	public StaffIdVO selectStaffId(String staff_id) {
		return sqlsession.selectOne("authority.select_staff_id", staff_id);
	}

	// 새로운 권한 코드 생성을 위한 현재 코드 갯수 가져오기
	public int selectTotalCntAuth() {
		return sqlsession.selectOne("authority.select_total_cnt_auth");
	}

	// 새로운 권한 코드 생성
	@Transactional
	public int insertNewAuth(AuthorityVO aVo) {
		return sqlsession.insert("authority.insert_new_auth", aVo);
	}

	// 권한 코드 설정
	@Transactional
	public int updateStaffIdAuth(StaffIdVO sIvo) {
		return sqlsession.update("authority.update_auth_by_staff_num", sIvo);
	}



}
