package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.BudgetServiceImpl;
import com.indieus.ius.service.FinanceServiceImpl;
import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.BudgetVO;
import com.indieus.ius.vo.FinanceVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/finance")
public class FinanceController {

	@Autowired
	private FinanceServiceImpl service;
	@Autowired
	private StaffServiceImpl staffService;
	@Autowired
	private BudgetServiceImpl budgetService;


	// 재정관리 처음 화면 - 리스트 불러오기
	@RequestMapping(value = "/finance_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<String> yearList = service.selectAllFinanceEyear();
		model.addAttribute("financeYearList", yearList);
		return "/finance/financeList";
	}

	// 재정 리스트 가져오기 Ajax
	@RequestMapping(value = "/get_finance_list", method = RequestMethod.POST)
	@ResponseBody
	public Object getFinanceList() throws Exception {
		return service.selectFinanceList();
	}

	// 년도별 재정 리스트 가져오기 Ajax
	@RequestMapping(value = "/get_finance_list_by_year", method = RequestMethod.POST)
	@ResponseBody
	public Object getFinanceListByYear(@RequestParam Map<String, Object> map) throws Exception {
		return service.getFinanceListByYear(map);
	}


	// 재정등록 폼
	@RequestMapping(value = "/finance_register_form", method = RequestMethod.GET)
	public String registerForm(Model model, @RequestParam String iE) throws Exception {
		// 예산 코드 가져오기
		int finance_num = service.selectFinanceSeq();
		// 예산 항목 가져오기
		List<BudgetVO> budgetList = budgetService.selectBudgetByBudgetIe(iE);
		// 교직원 명단 가져오기
		List<StaffVO> staffList = staffService.selectStaffList();

		model.addAttribute("iE", iE);
		model.addAttribute("finance_num", finance_num);
		model.addAttribute("budgetList", budgetList);
		model.addAttribute("staffList", staffList);

		return "/finance/financeRegisterForm";
	}

	// 재정 등록
	@RequestMapping(value = "/finance_register", method = RequestMethod.POST)
	public String register(@ModelAttribute FinanceVO fVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.insertFinance(fVo));
		return "redirect:./finance_list";
	}

	// 재정 정보 상세보기
	@RequestMapping(value = "/finance_info", method = RequestMethod.GET)
	public String info(Model model, @RequestParam String finance_num) throws Exception {
		FinanceVO fVo = service.selectFinanceByNum(finance_num);
		List<PurchaseVO> purchaseList = service.selectPurchaseFromNum(finance_num);
		int purchaseSum = service.selectPurchaseSumFromNum(finance_num);

		model.addAttribute("finance", fVo);
		model.addAttribute("purchaseList", purchaseList);
		model.addAttribute("purchaseSum", purchaseSum);

		return "/finance/finance_info";
	}

	// 재정 내역 삭제
	@RequestMapping(value = "/finance_delete", method = RequestMethod.GET)
	public String delete(@RequestParam String finance_num, RedirectAttributes rttr, HttpServletResponse response) throws Exception {
		int result =  service.deleteFinance(finance_num, response);

		if (result == 0) {
			return null;
		} else {
			rttr.addFlashAttribute("result", result);
			return "redirect:./finance_list";
		}

	}

	// 재정 수정 폼
	@RequestMapping(value = "/finance_update_form", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam String finance_num) throws Exception {
		FinanceVO fVo = service.selectFinanceByNum(finance_num);
		String iE = fVo.getFinance_iE();

		List<BudgetVO> budgetList = budgetService.selectBudgetByBudgetIe(iE);
		List<StaffVO> staffList = staffService.selectStaffList();

		model.addAttribute("budgetList", budgetList);
		model.addAttribute("staffList", staffList);
		model.addAttribute("finance", fVo);
		return "/finance/finance_update_form";
	}

	// 재정 수정
	@RequestMapping(value = "/finance_update", method = RequestMethod.POST)
	public String update(@ModelAttribute FinanceVO fVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateFinance(fVo));
		return "redirect:./finance_list";
	}

}
