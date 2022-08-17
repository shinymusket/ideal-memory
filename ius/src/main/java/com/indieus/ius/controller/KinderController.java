package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

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
import com.indieus.ius.service.MealMenuServiceImpl;
import com.indieus.ius.vo.KinderVO;
import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/kinder")
public class KinderController {

	@Autowired
	private KinderServiceImpl service;

	@Autowired
	private MealMenuServiceImpl mealService;

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

	// 원생 정보 조회하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_kinder_by_kinder_num", method = RequestMethod.POST)
	public Object getKinderByKinderNum(@RequestParam Map<String, Object> map) throws Exception  {
		return service.getKinderByKinderNum(map);
	}

	// 원생 정보 조회 - 알러지 정보 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_allergy_info", method = RequestMethod.POST)
	public Object getAllergyInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getAllergyInfo(map);
	}

	// 원생 학부모 정보 조회하기 Ajax
	@ResponseBody
	@RequestMapping(value = "get_parent_by_kinder_num", method = RequestMethod.POST)
	public Object getParentByKinderNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getParentByKinderNum(map);
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

	// 원생 등록 - 알러지 정보 입력 페이지 이동
	@RequestMapping(value = "/select_allergy", method = RequestMethod.GET)
	public String selectAllergy(@RequestParam(value = "allergy_code", required = false) int allergy_code, Model model) throws Exception {
		model.addAttribute("allergy_code", allergy_code);
		return "kinder/selectAllergy";
	}

	// 원생 등록 - 알러지 코드 생성 Ajax
	@ResponseBody
	@RequestMapping(value = "/set_allergy_info", method = RequestMethod.POST)
	public Object setAllergyInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.setAllergyInfo(map);
	}

	// 원생 등록
	@RequestMapping(value = "/kinder_register", method = RequestMethod.POST)
	public String kinderRegsiter(@ModelAttribute KinderVO kVo, @RequestParam MultipartFile kinder_picFile, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.insertKinder(kVo, kinder_picFile));
		return "redirect:./kinder_list";
	}

	// 원생 검색 기능 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_kinder_list_by_searchType", method = RequestMethod.POST)
	public Object searchKinderList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchKinderList(map);
	}


	// 원생 정보 삭제
	@RequestMapping(value = "/delete_kinder", method = RequestMethod.GET)
	public String deleteKinder(@RequestParam String kinder_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deleteKinderInfo(kinder_num));
		return "redirect:./kinder_list";
	}

	// 원생 정보 수정 페이지로 이동
	@RequestMapping(value = "/update_form_kinder", method = RequestMethod.GET)
	public String updateFormKinder(@RequestParam String kinder_num, Model model) throws Exception {
		KinderVO kinder = service.selectKinderInfo(kinder_num);
		List<ShuttleVO> shuttleList = service.selectAllShuttleList();
		List<StaffVO> homeTeacherList = service.selectHomeTeacherForKinder();

		model.addAttribute("shuttleList", shuttleList);
		model.addAttribute("homeTeacherList", homeTeacherList);
		model.addAttribute("kinder", kinder);
		return "kinder/kinderUpdateForm";
	}

	// 원생 정보 수정 - 알러지 보유자 유무 확인 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_allergy_check", method = RequestMethod.POST)
	public Object getAllergyCheck(@RequestParam Map<String, Object> map) throws Exception {
		return service.getAllergyCheck(map);
	}

	// 원생 정보 수정
	@RequestMapping(value = "/update_kinder", method = RequestMethod.POST)
	public String updateKinder(@ModelAttribute KinderVO kVo, @RequestParam MultipartFile kinder_picFile, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateKinder(kVo, kinder_picFile));
		return "redirect:./kinder_list";
	}



}
