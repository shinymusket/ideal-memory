package com.indieus.ius.service;

import java.util.Map;

public interface AttendanceService {

	public Object getAttendanceByKinderNum(Map<String, Object> map) throws Exception;

	public Object searchKinder(Map<String, Object> map) throws Exception;

	public Object selectAttendance(Map<String, Object> map) throws Exception;
}
