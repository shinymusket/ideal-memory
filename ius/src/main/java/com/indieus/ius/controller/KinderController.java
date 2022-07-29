package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.indieus.ius.service.KinderServiceImpl;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/kinder")
public class KinderController {

	@Autowired
	private KinderServiceImpl service;

	// 원생 관리 리스트로 이동
	@RequestMapping(value = "/kinder_list", method = RequestMethod.GET)
	public String list() throws Exception {
		return "kinder/kinderList";
	}

	// 원생 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_kinder_list", method = RequestMethod.POST)
	public Object getKinderList() throws Exception {
		return service.getKinderList();
	}

	// 원생 등록 폼으로 이동
	@RequestMapping(value = "/kinder_register_form", method = RequestMethod.GET)
	public String kinderRegisterForm(Model model) throws Exception {
		int nextKinderSeq = service.selectNextKinderSeq();
		List<ShuttleVO> shuttleList = service.selectAllShuttleList();
		List<StaffVO> homeTeacherList = service.selectHomeTeacherForKinder();

		model.addAttribute("nextKinderSeq", nextKinderSeq);
		model.addAttribute("shuttleList", shuttleList);
		model.addAttribute("homeTeacherList", homeTeacherList);
		return "kinder/kinderRegisterForm";
	}

	// 원생 등록
	@RequestMapping(value = "/kinder_register", method = RequestMethod.POST)
	public String kinderRegsiter(@ModelAttribute KinderVO kVo, @RequestParam MultipartFile kinder_picFile, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		rttr.addFlashAttribute("result", service.insertKinder(kVo, kinder_picFile, request));
		return "redirect:./kinder_list";
	}

	// 원생 검색 기능 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_kinder_list_by_searchType", method = RequestMethod.POST)
	public Object searchKinderList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchKinderList(map);
	}

	// 원생 정보 조회
	@RequestMapping(value = "/kinder_info", method = RequestMethod.GET)
	public String kinderInfo(@RequestParam String kinder_num, Model model) throws Exception {
		KinderVO kinder = service.selectKinderInfo(kinder_num);
		model.addAttribute("kinder", kinder);
		return "kinder/kinderInfo";
	}

	// 원생 정보 삭제
	@RequestMapping(value = "/delete_kinder", method = RequestMethod.GET)
	public String deleteKinder(@RequestParam String kinder_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deleteKinderInfo(kinder_num));
		return "redirect:./kinder_list";
	}

}
