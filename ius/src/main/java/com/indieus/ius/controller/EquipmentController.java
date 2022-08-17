package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.EquipmentServiceImpl;
import com.indieus.ius.vo.EquipClsVO;
import com.indieus.ius.vo.EquipmentVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/equipment")
public class EquipmentController {

	@Autowired
	private EquipmentServiceImpl service;

	// 페이징 처리된 리스트 받아오기
	@GetMapping("/equipment_list")
	public String equipmentList(Model model) throws Exception {

		List<EquipClsVO> equipClsList = service.selEquipmentClsList();
		model.addAttribute("equipClsList", equipClsList);

		return "/equipment/equipmentList";

	}

	// 시설 비품 검색 기능 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_equipment_list", method = RequestMethod.POST)
	public Object searchEquipmentList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchEquipmentList(map);
	}

	// 시설(비품) 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_equipment_list", method = RequestMethod.POST)
	public Object getList () throws Exception {
		return service.getEquipmentList();
	}

	// 시설(비품) 등록 폼으로 이동
	@RequestMapping(value = "/equipment_register_form", method = RequestMethod.GET)
	public String equipmentRegisterForm(Model model, HttpSession session) throws Exception {

		// 시설(비품) 등록을 위한 다음 시퀀스(자산코드) 가져오기
		int seqNum = service.selectEquipmentSeq();
		model.addAttribute("seqNum", seqNum);


		// 로그인된 직원의 아이디와 이름을 세션에서 꺼내옴
		StaffIdVO sIvo = (StaffIdVO) session.getAttribute("staff");
		String staff_id = sIvo.getStaff_id();

		model.addAttribute("staff_id", staff_id);

		String staff_name = service.selectStaffNameById(staff_id);

		model.addAttribute("staff_name", staff_name);

		return "/equipment/equipmentRegisterForm";
	}

	// 시설(비품) 등록
	@RequestMapping(value = "/equipment_register", method = RequestMethod.POST)
	public String equipmentRegister(@ModelAttribute EquipmentVO eVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.insertEquipment(eVo));
		return "redirect:./equipment_list";
	}

	// 시설(비품) 항목 편집 화면 이동
	@RequestMapping(value = "/equipment_class_edit", method = RequestMethod.GET)
	public String equipmentClsEdit() throws Exception {
		return "/equipment/equipmentClassEdit";
	}

	// 시설(비품) 항목 편집 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_equipment_cls_list", method = RequestMethod.POST)
	public Object getEquipmentClsList() throws Exception {
		return service.getEquipmentClsList();
	}

	// 시설(비품) 항목 편집 - 코드로 항목 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_equip_cls_by_num", method = RequestMethod.POST)
	public Object getEquipClsByNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getEquipClsByNum(map);
	}

	// 시설(비품) 항목 편집 - 항목 추가하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/insert_equipment_cls_list", method = RequestMethod.POST)
	public void insertEquipCls(@RequestParam Map<String, Object> map) throws Exception {
		service.insertEquipCls(map);
	}

	// 시설(비품) 항목 편집 - 항목 삭제하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_equipment_cls_list", method = RequestMethod.POST)
	public void deleteEquipCls(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception {
		service.deleteEquipCls(map, response);
	}

	// 시설(비품) 항목 편집 - 항목 수정하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_equipment_cls_list", method = RequestMethod.POST)
	public void updateEquipCls(@RequestParam Map<String, Object> map) throws Exception {
		service.updateEquipCls(map);
	}

	// 시설(비품)정보 가져오기
	@RequestMapping(value = "/equipment_info", method = RequestMethod.GET)
	public String getEquipmentInfo(@RequestParam String equipment_num, Model model, HttpSession session) throws Exception {
		StaffIdVO sIvo = (StaffIdVO) session.getAttribute("staff");
		String staff_id = sIvo.getStaff_id();

		EquipmentVO eVo = service.selectEquipmentByNum(equipment_num);
		model.addAttribute("equipment", eVo);
		model.addAttribute("staff_id", staff_id);
		return "/equipment/equipmentInfo";
	}

	// 시설(비품)정보 수정폼 이동
	@RequestMapping(value = "/equipment_update", method = RequestMethod.GET)
	public String updateEquipmentForm(@RequestParam String equipment_num, Model model) throws Exception {
		EquipmentVO eVo = service.selectEquipmentByNum(equipment_num);
		model.addAttribute("equipment", eVo);
		return "/equipment/equipmentUpdateForm";
	}

	// 시설(비품)정보 수정
	@RequestMapping(value = "/equipment_update", method = RequestMethod.POST)
	public String updateEquipment(@ModelAttribute EquipmentVO eVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateEquipment(eVo));
		return "redirect:./equipment_list";
	}

	// 시설(비품)정보 삭제
	@RequestMapping(value = "/equipment_delete", method = RequestMethod.GET)
	public String deleteEquipment(@RequestParam String equipment_num, RedirectAttributes rttr, HttpServletResponse response) throws Exception {
		int result = service.deleteEquipment(equipment_num, response);

		rttr.addFlashAttribute("result", result);
		return "redirect:./equipment_list";

	}

	// 구매품 등록 폼으로 이동
	@RequestMapping(value = "/purchaseEquip_form", method = RequestMethod.GET)
	public String purchaseEquipForm(Model model, HttpSession session) throws Exception {
		int purchaseSeq =  service.selectPurchaseSeq();

		StaffIdVO sIvo = (StaffIdVO) session.getAttribute("staff");
		String staff_id = sIvo.getStaff_id();
		StaffVO staff = service.selectStaffNumNameById(staff_id);
		String staff_name = staff.getStaff_name();
		String staff_num = staff.getStaff_num();

		int equipSeqNum = service.selectEquipmentSeq();

		model.addAttribute("purchaseSeq", purchaseSeq);
		model.addAttribute("pur_staff_name", staff_name);
		model.addAttribute("pur_staff_num", staff_num);
		model.addAttribute("equipSeqNum", equipSeqNum);

		return "/equipment/purchaseEquipForm";
	}

	// 구매품 등록 - 재정 코드 선택란 이동
	@RequestMapping(value = "/equipment_finance_select", method = RequestMethod.GET)
	public String purchaseFinanceSelectForm() throws Exception {
		return "/equipment/financeSelectForm";
	}

	// 구매품 등록 - 재정 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_finance_list", method = RequestMethod.POST)
	public Object getFinanceList() throws Exception {
		return service.getFinanceList();
	}

	// 구매품 등록하기
	@RequestMapping(value = "/purchaseEquipRegister", method = RequestMethod.POST)
	public String purchaseEquipRegister(@ModelAttribute PurchaseVO pVo, RedirectAttributes rttr, HttpSession session) throws Exception {
		rttr.addFlashAttribute("result", service.purchaseEquipRegister(pVo, session));
		return "redirect:./equipment_list";
	}

	// 구매 리스트 이동
	@RequestMapping(value = "/purchase_list", method = RequestMethod.GET)
	public String purchaseList() throws Exception {
		return "/equipment/purchaseList";
	}

	// 구매 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_purchase_list", method = RequestMethod.POST)
	public Object getPurchaseList() throws Exception {
		return service.getPurchaseList();
	}

	// 구매 리스트 검색하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_purchase_list", method = RequestMethod.POST)
	public Object searchPurchaseList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchPurchaseList(map);
	}

	// 구매 정보 상세보기
	@RequestMapping(value = "/purchase_info", method = RequestMethod.GET)
	public String purchaseInfo(@RequestParam String purchase_num, Model model) throws Exception {
		PurchaseVO pVo = service.getPurchaseInfo(purchase_num);

		model.addAttribute("purchase", pVo);
		return "/equipment/purchaseInfo";
	}

	// 구매 정보 삭제하기
	@RequestMapping(value = "/purchase_delete", method = RequestMethod.GET)
	public String deletePurchase(@RequestParam String purchase_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deletePurchase(purchase_num));
		return "redirect:./purchase_list";
	}

	// 구매 정보 수정하기 폼 이동
	@RequestMapping(value = "/purchase_update_form", method = RequestMethod.GET)
	public String updatePurchase(@RequestParam String purchase_num, Model model) throws Exception {
		PurchaseVO pVo = service.getPurchaseInfo(purchase_num);
		model.addAttribute("purchase", pVo);
		return "/equipment/purchaseUpdateForm";
	}

	// 구매 정보 수정하기
	@RequestMapping(value = "/purchase_update", method = RequestMethod.POST)
	public String updatePurchase(@ModelAttribute PurchaseVO pVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updatePurchase(pVo));
		return "redirect:./purchase_list";
	}

}
