package com.indieus.ius.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.JobClassifiVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/staff")
public class StaffController {

	@Autowired
	private StaffServiceImpl service;

	// 교직원 명단 이동
	@RequestMapping(value = "/staff_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<JobClassifiVO> jobList = service.selectJobList();
		model.addAttribute("jobList", jobList);

		return "/staff/staffList";
	}

	// 교직원 명단 불러오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_staff_list", method = RequestMethod.POST)
	public Object getStaffList() throws Exception {
		return service.getStaffList();
	}

	// 교직원 명단 검색하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_staff_list", method = RequestMethod.POST)
	public Object searchStaffList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchStaffList(map);
	}

	// 교직원 정보 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_staff_by_staff_num", method = RequestMethod.POST)
	public Object getStaffByStaffNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getStaffByStaffNum(map);
	}

	// 교직원 등록 폼 이동
	@RequestMapping(value = "/staff_register", method = RequestMethod.GET)
	public String registerForm(Model model) throws Exception {
		int result = service.selectStaffSeq();
		List<JobClassifiVO> list = service.selectJobClassifi();
		model.addAttribute("nextSeq", result);
		model.addAttribute("jobList", list);
		return "/staff/staffRegister";
	}

	// 교직원 직무 분류 등록 폼
	@RequestMapping(value = "/job_class_Edit", method = RequestMethod.GET)
	public String jobClassEdit(Model model) throws Exception {
		List<JobClassifiVO> list = service.selectJobClassifi();
		model.addAttribute("jobList", list);
		return "/staff/jobClassEdit";
	}

	// 교직원 직무 분류 편집 - 리스트 가져오기
	@RequestMapping(value = "/get_job_list", method = RequestMethod.POST)
	public void getJobList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		service.getJobList(request, response);
	}

	// 교직원 직무 분류 편집 - 추가하기
	@RequestMapping(value = "/insert_job_list", method = RequestMethod.POST)
	public void insertJobList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		service.insertJobList(request, response);
	}

	// 교직원 직무 분류 편집 - 아이디로 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/get_job_by_staff_cls", method = RequestMethod.POST)
	public HashMap<String, String> getJobByStaffCls(@RequestParam("staff_cls") String staff_cls) throws Exception {
		HashMap<String, String> info = new HashMap<>();

		JobClassifiVO jVo = service.getJobByStaffCls(staff_cls);

		info.put("staff_cls", staff_cls);
		info.put("job_Kname", jVo.getJob_Kname());
		info.put("job_Ename", jVo.getJob_Ename());

		return info;
	}

	// 교직원 직무 분류 편집 - 아이디로 정보 삭제
	@ResponseBody
	@RequestMapping(value = "/delete_job_list", method = RequestMethod.POST)
	public void deleteJobList(@RequestParam("staff_cls") String staff_cls, HttpServletResponse response) throws Exception {
		service.deleteJobByStaffCls(staff_cls, response);
	}

	// 교직원 직무 분류 편집 - 수정
	@ResponseBody
	@RequestMapping(value = "/update_job_list", method = RequestMethod.POST)
	public void updateJobList(JobClassifiVO jVo) throws Exception {
		service.updateJobList(jVo);
	}

	// 교직원 아이디 중복 검사
	@RequestMapping(value = "/staff_id_check", method = RequestMethod.GET)
	public String idCheck(Model model, @RequestParam("staff_id") String staff_id) throws Exception {
		int result = service.idCheck(staff_id);

		model.addAttribute("result", result);
		model.addAttribute("staff_id", staff_id);

		return "/staff/staffIdCheck";
	}

	// 교직원 등록
	@RequestMapping(value = "/staff_register", method = RequestMethod.POST)
	public String register(@ModelAttribute StaffVO sVo, @RequestParam MultipartFile staff_picFile, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.insertStaff(sVo, staff_picFile));
		return "redirect:./staff_list";
	}

	// 교직원 정보 상세조회
	@RequestMapping(value = "/staff_info", method = RequestMethod.GET)
	public String info(Model model, @RequestParam("staff_num") String staff_num) throws Exception {
		StaffVO sVo = service.selectStaffInfo(staff_num);
		JobClassifiVO jVo = service.selectJobClassifiByNum(sVo.getStaff_cls());
		model.addAttribute("staff", sVo);
		model.addAttribute("job", jVo);
		return "/staff/staffInfo";
	}

	// 교직원 삭제
	@RequestMapping(value = "/staff_delete", method = RequestMethod.GET)
	public String delete(@RequestParam("staff_num") String staff_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deleteStaff(staff_num));
		return "redirect:./staff_list";
	}

	// 교직원 수정 폼 이동
	@RequestMapping(value = "/staff_update_form", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam("staff_num") String staff_num) throws Exception {
		StaffVO sVo = service.selectStaffInfo(staff_num);
		List<JobClassifiVO> list = service.selectJobClassifi();
		model.addAttribute("jobList", list);
		model.addAttribute("staff", sVo);
		return "/staff/staffUpdate";
	}

	// 교직원 정보 수정
	@RequestMapping(value = "/staff_update", method = RequestMethod.POST)
	public String update(@ModelAttribute StaffVO sVo, @RequestParam MultipartFile staff_picFile, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateStaff(sVo, staff_picFile));
		return "redirect:./staff_list";
	}

}
