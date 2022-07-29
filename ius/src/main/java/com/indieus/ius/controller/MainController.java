package com.indieus.ius.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.indieus.ius.service.StaffIdServiceImpl;
import com.indieus.ius.vo.StaffIdVO;

@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	private StaffIdServiceImpl service;

	// 홈으로
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session) throws Exception {
		if (session.getAttribute("staff") == null) {
			return "/index";
		}
		return "/main/home";
	}

	// 로그인
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String main(@ModelAttribute StaffIdVO staff, HttpSession session, HttpServletResponse response) throws Exception {
		staff = service.login(staff, response);
		session.setAttribute("staff", staff);
		return "/main/home";
	}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public void logout(HttpSession session, HttpServletResponse response) throws Exception{
		session.invalidate();
		service.logout(response);
	}
}
