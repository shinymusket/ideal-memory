package com.green.pt001.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.green.pt001.service.FinanceServiceImpl;
import com.green.pt001.vo.FinanceVO;

@Controller
@RequestMapping("/finance")
public class FinanceController {
	
	@Autowired
	private FinanceServiceImpl service;
	
	// 재정관리 처음 화면 - 리스트 불러오기
	@RequestMapping(value = "/finance_list", method = RequestMethod.GET)
	public String list(HttpServletResponse response, Model model) throws Exception {
		List<FinanceVO> list = service.selectFinanceList(response);
		model.addAttribute("financeList", list);
		return "/finance/financeList";
	}
}
