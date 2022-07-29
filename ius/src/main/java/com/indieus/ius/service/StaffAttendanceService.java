package com.indieus.ius.service;

import java.util.Map;

public interface StaffAttendanceService {
	public Object getInfo(Map<String, Object> map) throws Exception;

	public Object getInfoByDate(Map<String, Object> map) throws Exception;
}
