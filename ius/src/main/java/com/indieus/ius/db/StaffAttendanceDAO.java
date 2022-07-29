package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.indieus.ius.vo.StaffAttendanceVO;

@Repository
public class StaffAttendanceDAO {

	@Autowired
	SqlSession sqlsession = null;


	// 아이디로 근태 정보 가져오기
	public List<StaffAttendanceVO> getAttendInfo(String staff_id) {
		return sqlsession.selectList("staffAttendance.get_attend_info", staff_id);
	}

	// 날짜별 아이디 근태 정보 가져오기
	public List<StaffAttendanceVO> getAttendInfoByDate(Map<String, String> dateInfo) {
		return sqlsession.selectList("staffAttendance.get_attend_info_by_date", dateInfo);
	}




}
