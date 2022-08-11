package com.indieus.ius.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.indieus.ius.service.MainServiceImpl;
import com.indieus.ius.service.NoticeServiceImpl;
import com.indieus.ius.service.StaffIdServiceImpl;
import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.AuthorityVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

@Controller
public class MainController {

	@Autowired
	private MainServiceImpl service;

	@Autowired
	private StaffIdServiceImpl staffIdService;

	@Autowired
	private StaffServiceImpl staffService;

	@Autowired
	private NoticeServiceImpl noticeService;

	// 홈으로
	@RequestMapping(value = "/main/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) throws Exception {
		if (session.getAttribute("staff") == null) {
			return "/index";
		}

		return "/main/home";
	}

	// 로그인
	@RequestMapping(value = "/main/loginCheck", method = RequestMethod.POST)
	public String main(Model model, @ModelAttribute StaffIdVO staff, HttpSession session, HttpServletResponse response) throws Exception {
		staff = staffIdService.login(staff, response);
		session.setAttribute("staff", staff);

		try {
			// 로그인한 사람 직원 정보 가져오기
			String staff_id = staff.getStaff_id();
			StaffVO staffInfo = staffService.selectStaffInfoStaffId(staff_id);
			String staff_name = staffInfo.getStaff_name();

			// 권한 정보 가져오기
			String auth_code = staff.getAuth_code();
			AuthorityVO auth_info = service.selectAuthByCode(auth_code);
			model.addAttribute("auth_info" , auth_info);
			model.addAttribute("staff_name", staff_name);
			model.addAttribute("staff_id", staff_id);

		} catch(NullPointerException e) {

		}

		return "/main/home";
	}

	// 로그인 후 권한 코드로 권한 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/main/get_auth_info_by_code", method = RequestMethod.POST)
	public Object getAuthInfoByCode(@RequestParam Map<String, Object> map) throws Exception {
		return service.getAuthInfoByCode(map);
	}


	// 로그아웃
	@RequestMapping(value = "/main/logout")
	public void logout(HttpSession session, HttpServletResponse response) throws Exception{
		session.invalidate();
		staffIdService.logout(response);
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/main/search_password")
	public String searchPassword() throws Exception {
		return "/main/searchPwd";
	}

	// 이메일이 있는지 유무 체크 Ajax
	@ResponseBody
	@RequestMapping(value = "/main/get_email_exist_check", method = RequestMethod.POST)
	public Object getEmailExistCheck(@RequestParam Map<String, Object> map) throws Exception {
		return service.getEmailExistCheck(map);
	}

	// 이메일로 임시비밀번호 발송하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/main/search_password_by_email", method = RequestMethod.POST)
	public Object searchPasswordByEmail(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchPasswordByEmail(map);
	}

	// 회원정보로 이동
	@RequestMapping(value = "/main/my_staff_info", method = RequestMethod.GET)
	public String myStaffInfo(Model model, HttpSession session) throws Exception {
		// 세션에서 사원번호 꺼내오기
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();
		StaffVO staffInfo = staffService.selectStaffInfoStaffId(staff_id);
		String staff_num  = staffInfo.getStaff_num();
		StaffVO sVo = staffService.selectStaffInfo(staff_num);

		model.addAttribute("staff", sVo);
		return "/main/myInfo";

	}

	// 회원정보 수정
	@RequestMapping(value = "/main/update_staff_info", method = RequestMethod.POST)
	public String myStaffInfoUpdate(@ModelAttribute StaffVO sVo, @RequestParam MultipartFile staff_picFile, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.myStaffInfoUpdate(sVo, staff_picFile));
		return "redirect:./my_staff_info";
	}

	// 비밀번호 변경 폼으로 이동
	@RequestMapping(value = "/main/update_password_form", method = RequestMethod.GET)
	public String updatePasswordForm(Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();
		model.addAttribute("staff_id", staff_id);
		return "/main/updatePasswordForm";
	}

	// 기존 비밀번호 일치 유무 체크 Ajax
	@ResponseBody
	@RequestMapping(value = "/main/check_origin_password", method = RequestMethod.POST)
	public Object checkOriginPassword(@RequestParam Map<String, Object> map) throws Exception {
		return service.checkOriginPassword(map);
	}

	// 비밀번호 변경
	@RequestMapping(value = "/main/update_password", method = RequestMethod.POST)
	public String updatePassword(Model model, @RequestParam String newPassword,  HttpSession session, RedirectAttributes rttr) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();

		Map<String, Object> map = new HashMap();
		map.put("staff_id", staff_id);
		map.put("newPassword", newPassword);

		rttr.addFlashAttribute("result", service.updatePassword(map));

		return "redirect:./logout";
	}

	// 초기 메인 화면에 띄울 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/main/get_Info", method = RequestMethod.POST)
	public Object getInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getInfo(map);
	}


}
