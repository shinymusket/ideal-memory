package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.AttendanceDAO;
import com.indieus.ius.vo.AttendanceVO;
import com.indieus.ius.vo.KinderVO;

public class AttendanceServiceImpl implements AttendanceService {

	@Inject
	private AttendanceDAO manager;

	// 출결 정보 가져오기 Ajax
	@Override
	public Object getAttendanceByKinderNum(Map<String, Object> map) throws Exception {
		String kinder_num = (String) map.get("kinder_num");
		List<AttendanceVO> attendanceList = manager.selectAttendanceByKinderNum(kinder_num);

		Map<String, Object> data = new HashMap();
		data.put("attendanceList", attendanceList);

		return data;
	}

	// 출결 정보 검색하기 Ajax
	@Override
	public Object searchKinder(Map<String, Object> map) throws Exception {
		List<KinderVO> kinderList = manager.searchKinder(map);

		Map<String, Object> data = new HashMap();
		data.put("kinderList", kinderList);

		return data;
	}

	// 출결 정보 날짜별 조회 Ajax
	@Override
	public Object selectAttendance(Map<String, Object> map) throws Exception {
		List<AttendanceVO> attendanceList = manager.selectAttendance(map);
		Map<String, Object> data = new HashMap();
		data.put("attendanceList", attendanceList);

		return data;
	}

}
