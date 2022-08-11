package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.indieus.ius.vo.AttendanceVO;
import com.indieus.ius.vo.KinderVO;

@Repository
public class AttendanceDAO {

	@Autowired
	private SqlSession sqlsession;

	// 출결 정보 가져오기
	public List<AttendanceVO> selectAttendanceByKinderNum(String kinder_num) throws Exception {
		return sqlsession.selectList("attendance.select_attendance_by_kinder_num", kinder_num);
	}

	// 원생 정보 검색하기
	public List<KinderVO> searchKinder(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("attendance.search_kinder", map);
	}

	// 출결 정보 날짜별 조회
	public List<AttendanceVO> selectAttendance(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("attendance.select_attendance", map);
	}

	// 학생별 최근 출결 정보 3개 가져오기
	public List<AttendanceVO> selectLatestAttendance(String kinder_num) throws Exception {
		return sqlsession.selectList("attendance.select_latest_attendance", kinder_num);
	}
}
