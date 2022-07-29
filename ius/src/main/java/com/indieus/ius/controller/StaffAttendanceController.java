package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.StaffAttendanceServiceImpl;
import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/staff_attendance")
public class StaffAttendanceController {

	@Autowired
	private StaffServiceImpl staffService;

	@Autowired
	private StaffAttendanceServiceImpl service;

	// 초기화면으로 이동
	@RequestMapping(value = "attendance_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<StaffVO> staffList = staffService.selectStaffList();
		model.addAttribute("staffList", staffList);
		return "/staff_attendance/attendanceList";
	}

	// 근태 정보 받아오기 Ajax
	@RequestMapping(value = "/getInfo", method = RequestMethod.POST)
	@ResponseBody
	public Object getInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getInfo(map);
	}

	// 날짜로 조회하여 근태 정보 받아오기 Ajax
	@RequestMapping(value = "/getInfoByDate", method = RequestMethod.POST)
	@ResponseBody
	public Object getInfoByDate(@RequestParam Map<String, Object> map) throws Exception {
		return service.getInfoByDate(map);
	}

}
