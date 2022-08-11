package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.JobClassifiVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

@Repository
public class StaffDAO {

	@Autowired
	SqlSession sqlsession = null;

	// 교직원 리스트 가져오기
	public List<StaffVO> selectStaffList() throws Exception {
		return sqlsession.selectList("staff.select_staff_list");
	}

	// 교직원 검색하기
	public List<StaffVO> searchStaffList(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("staff.search_staff_list", map);

	}


	// 교직원 등록을 위한 다음 시퀀스 값 조회
	public int selectStaffSeq() throws Exception {
		return sqlsession.selectOne("staff.select_staff_seq");
	}

	// 직무 분류 항목 가져오기
	public List<JobClassifiVO> selectJobClassifi() throws Exception {
		return sqlsession.selectList("staff.select_job_classifi");
	}

	// 직무 분류 항목 전체 수 가져오기
	public int selectJobNumber() throws Exception {
		return sqlsession.selectOne("staff.select_job_number");
	}


	// 직무 분류 항목 추가하기
	@Transactional
	public void insertJob(JobClassifiVO jVo) {
		sqlsession.insert("staff.insert_job", jVo);
	}

	// 직무 코드로 직무명 가져오기
	public JobClassifiVO selectJobClassifiByNum(String staff_cls) throws Exception {
		return sqlsession.selectOne("staff.select_job_classifi_by_num", staff_cls);
	}

	// 직무 코드로 직무 항목 삭제전 해당 데이터의 교직원 유무 확인
	public int checkStaffFromStaffCls(String staff_cls) throws Exception {
		return sqlsession.selectOne("staff.check_staff_from_staff_cls", staff_cls);
	}

	// 직무 코드로 직무 항목 삭제
	@Transactional
	public void deleteJobByStaffCls(String staff_cls) {
		sqlsession.delete("staff.delete_job_classifi_by_num", staff_cls);
	}

	// 직무 항목 수정
	@Transactional
	public void updateJobList(JobClassifiVO jVo) {
		sqlsession.update("staff.update_job", jVo);

	}

	// 교직원 아이디 중복 검사
	public int idCheck(String staff_id) {
		int result = sqlsession.selectOne("staff.id_check", staff_id);
		return result;
	}

	// 교직원 계정(임시비밀번호 포함) 등록
	@Transactional
	public int insertStaffId(StaffIdVO sIvo) throws Exception {
		return sqlsession.insert("staff.insert_staffId", sIvo);
	}

	// 교직원 계정 삭제
	public int deleteStaffid(String staff_id) {
		return sqlsession.delete("staff.delete_staffId", staff_id);
	}

	// 교직원 등록
	@Transactional
	public int insertStaff(StaffVO sVo) throws Exception {
		return sqlsession.insert("staff.insert_staff", sVo);
	}

	// 교직원 담당 반 정보 등록(Null)
	@Transactional
	public int insertStaffClassInfo(String staff_num) throws Exception {
		return sqlsession.insert("staff.insert_staff_class_info", staff_num);
	}


	// 교직원 상세정보
	public StaffVO selectStaffInfo(String staff_num) throws Exception {
		return sqlsession.selectOne("staff.select_staff_info", staff_num);
	}

	// 교직원 삭제
	@Transactional
	public int deleteStaff(String staff_num) throws Exception {
		return sqlsession.delete("staff.delete_staff", staff_num);
	}

	// 교직원 정보수정
	@Transactional
	public int updateStaff(StaffVO sVo) throws Exception {
		return sqlsession.update("staff.update_staff", sVo);
	}

	// 교직원 사번으로 직무코드 가져오기
	public String selectStaffClsByStaffNum(String staff_num) throws Exception {
		return sqlsession.selectOne("staff.select_staff_cls_by_staff_num", staff_num);
	}

	//  로그인 되어 있는 세션 정보(아이디)로 교직원 정보 가져오기
	public StaffVO selectStaffInfoStaffId(String staff_id) throws Exception {
		return sqlsession.selectOne("staff.select_staff_info_by_staff_id", staff_id);
	}

	// 교직원의 학급 데이터 삭제
	@Transactional
	public void deleteClassInfo(String staff_num) throws Exception{
		sqlsession.delete("staff.delete_class_info_by_staff_num", staff_num);

	}



}
