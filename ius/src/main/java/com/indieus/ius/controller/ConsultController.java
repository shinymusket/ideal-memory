package com.indieus.ius.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.ConsultServiceImpl;
import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/consult")
public class ConsultController {

	@Autowired
	private ConsultServiceImpl service;
	@Autowired
	private StaffServiceImpl staffService;

	// 상담 일지 페이지 이동
	@RequestMapping(value = "/consult_list", method = RequestMethod.GET)
	public String list(Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();
		StaffVO staffInfo = staffService.selectStaffInfoStaffId(staff_id);
		model.addAttribute("staffInfo", staffInfo);

		return "consult/consultList";
	}

	// 원생별 상담 일지 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_consult_by_kinder_num", method = RequestMethod.POST)
	public Object getConsultByKinderNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getConsultByKinderNum(map);
	}

	// 원생별 상담 일지 날짜로 조회하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/select_consult", method = RequestMethod.POST)
	public Object selectConsultByDate(@RequestParam Map<String, Object> map) throws Exception {
		return service.selectConsultByDate(map);
	}

	// 상담 일지 작성 - 원생 번호와 가족 관계로 부모님 성명과 번호 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/select_parent_num_name", method = RequestMethod.POST)
	public Object selectParentNumName(@RequestParam Map<String, Object> map) throws Exception {
		return service.selectParentNumName(map);
	}

	// 상담 일지 수정 혹은 삭제를 위해 데이터 값 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_consult_by_consult_code", method = RequestMethod.POST)
	public Object getConsultByConsultCode(@RequestParam Map<String, Object> map) throws Exception {
		return service.getConsultByConsultCode(map);
	}

	// 상담 일지 등록 Ajax
	@ResponseBody
	@RequestMapping(value = "/register_consult", method = RequestMethod.POST)
	public void registerConsult(@RequestParam Map<String, Object> map) throws Exception {
		service.registerConsult(map);
	}

	// 상담 일지 수정 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_consult", method = RequestMethod.POST)
	public void updateConsult(@RequestParam Map<String, Object> map) throws Exception {
		service.updateConsult(map);
	}

	// 상담 일지 삭제 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_consult", method = RequestMethod.POST)
	public void deleteConsult(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteConsult(map);
	}

}
