package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.StaffAttendanceDAO;
import com.indieus.ius.vo.StaffAttendanceVO;

public class StaffAttendanceServiceImpl implements StaffAttendanceService {

	@Inject
	private StaffAttendanceDAO manager;

	// 근태 정보 받아오기 Ajax
	@Override
	public Object getInfo(Map<String, Object> map) throws Exception {
		String staff_id = (String) map.get("id");

		List<StaffAttendanceVO> attendInfo = manager.getAttendInfo(staff_id);

		Map<String, Object> data = new HashMap();
		data.put("attendInfo", attendInfo);
		return data;
	}

	// 날짜로 조회하여 근태 정보 받아오기 Ajax
	@Override
	public Object getInfoByDate(Map<String, Object> map) throws Exception {
		String staff_id = (String) map.get("staff_id");
		String from = (String) map.get("from");
		String to = (String) map.get("to");

		Map<String, String> dateInfo = new HashMap();
		dateInfo.put("staff_id", staff_id);
		dateInfo.put("from", from);
		dateInfo.put("to", to);

		List<StaffAttendanceVO> attendInfo = manager.getAttendInfoByDate(dateInfo);

		Map<String, Object> retVal = new HashMap();
		retVal.put("attendInfo", attendInfo);
		return retVal;
	}

}
