package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.StaffVO;

public class ClassDAO {

	@Autowired
	private SqlSession sqlsession;

	// 학급 반 전체 리스트 가져오기
	public List<ClassVO> selectAllClassList() throws Exception {
		return sqlsession.selectList("class.select_all_class_list");
	}

	// 학급 정보 가져오기
	public ClassVO selectClassByClassNum(String class_number) throws Exception {
		return sqlsession.selectOne("class.select_class_by_class_num", class_number);
	}

	// 학급별 학생 명단 가져오기
	public List<KinderVO> selectClassKinderByClassNum(String class_number) throws Exception {
		return sqlsession.selectList("class.select_class_kinder_by_class_num", class_number);
	}

	// 학급 등록을 위한 마지막 학급 번호 값 가져오기
	public int selectClassLastNumber() throws Exception {
		return sqlsession.selectOne("class.select_class_last_number");
	}

	// 학급 등록을 위한 담당 교사 리스트 가져오기
	public List<StaffVO> selectClassHomeTeacher() throws Exception {
		return sqlsession.selectList("class.select_class_home_teacher");
	}

	// 학급 등록
	@Transactional
	public int updateClass(ClassVO cVo) throws Exception {
		return sqlsession.update("class.update_class", cVo);
	}

	// 학급 정보 수정
	@Transactional
	public void updateClassInfo(Map<String, Object> map) throws Exception {
		sqlsession.update("class.update_class_info", map);
	}

	// 학급 정보 수정 후 학급 기본데이터가 하나도 없는 지 유무 체크
	public int selectClassCntByStaffNum(String staff_num) throws Exception {
		return sqlsession.selectOne("class.select_class_cnt_by_staff_num", staff_num);
	}

	// 담당 반이 없던 교사가 담당반을 맡았을 때 기존의 Null 데이터 삭제
	@Transactional
	public int deleteNullClassByStaffNum(String staff_Num) throws Exception {
		return sqlsession.delete("class.delete_null_class_by_staff_num", staff_Num);
	}

	// 원생의 학급 반 담당 선생님이 변경되었을 때, 원생 정보의 담당 교사도 변경
	@Transactional
	public int updateHomeTeacherForKinder(KinderVO kVo) throws Exception {
		return sqlsession.update("class.update_home_teacher_for_kinder", kVo);
	}

	// 학급 정보 삭제 Ajax (삭제시 학급 번호(시퀀스X)와 학급 이름만 삭제)
	@Transactional
	public void deleteClassInfo(Map<String, Object> map) throws Exception {
		sqlsession.update("class.delete_class_info", map);
	}
}
