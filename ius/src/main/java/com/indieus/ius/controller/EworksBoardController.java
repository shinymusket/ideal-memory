package com.indieus.ius.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.AdeptDocServiceImpl;

@Controller
@RequestMapping("/board")
public class EworksBoardController {


	@Autowired
	private AdeptDocServiceImpl service;

	// 전자결재 리스트 화면 이동
	@RequestMapping(value = "/board_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
//		List<String> docList = service.selectAllSignedDocyear();
//		model.addAttribute("AdeptDocList", docList);
		return "/board/boardList";
	}

	// 전자결재 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "get_eWorks_list", method = RequestMethod.POST)
	public Object getEworksList() throws Exception {
		return service.getEworksList();
	}

	//문서 기안하기
	@RequestMapping(value = "/select_draft_form", method = RequestMethod.GET)
	public String selectform(Model model) throws Exception {
		return "/board/boardDrafting";
	}

	//구매 신청서
		@RequestMapping(value = "/buy_order", method = RequestMethod.GET)
		public String buyOrder(Model model) throws Exception {
			return "/board/buyOrder";
		}

	//지출 결의서
	@RequestMapping(value = "/spend_Resol", method = RequestMethod.GET)
	public String spendingResol(Model model) throws Exception {
		return "/board/spendingResol";
	}

	//연차 신청서
	@RequestMapping(value = "/vacation_Request", method = RequestMethod.GET)
	public String vacationRe(Model model) throws Exception {
		return "/board/vacationRequest";
	}

}
