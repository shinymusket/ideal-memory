package com.indieus.ius.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.AttendanceServiceImpl;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

	@Autowired
	private AttendanceServiceImpl service;



	// 출결 관리 리스트로 이동
	@RequestMapping(value = "/attendance_list" , method = RequestMethod.GET)
	public String list() throws Exception {
		return "attendance/attendanceList";
	}

	// 출결 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_attendance_by_kinder_num" , method = RequestMethod.POST)
	public Object getAttendanceByKinderNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getAttendanceByKinderNum(map);
	}

	// 출결 정보 검색하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_kinder" , method = RequestMethod.POST)
	public Object searchKinder(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchKinder(map);
	}

	// 출결 정보 날짜별 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "/select_attendance" , method = RequestMethod.POST)
	public Object selectAttendance(@RequestParam Map<String, Object> map) throws Exception {
		return service.selectAttendance(map);
	}


}
