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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.BudgetServiceImpl;
import com.indieus.ius.vo.BudgetVO;

@Controller
@RequestMapping("/budget")
public class BudgetController {

	@Autowired
	private BudgetServiceImpl service;

	// 예산 관리 처음 화면(리스트)
	@RequestMapping(value = "/budget_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<String> yearList = service.selectAllBudgetYear();
		model.addAttribute("budgetYearList", yearList);
		return "/budget/budgetList";
	}

	// 예산 리스트 가져오기 Ajax
	@RequestMapping(value = "/get_budget_list", method = RequestMethod.POST)
	@ResponseBody
	public Object getBudgetList() throws Exception {
		return service.getBudgetList();
	}

	// 년도별 예산 리스트 가져오기 Ajax
	@RequestMapping(value = "/get_budget_list_by_year", method = RequestMethod.POST)
	@ResponseBody
	public Object getBudgetListByYear(@RequestParam Map<String, Object> map) throws Exception {
		return service.getBudgetListByYear(map);
	}

	// 예산 등록 화면
	@RequestMapping(value = "/budget_register_form", method = RequestMethod.GET)
	public String registerForm() throws Exception {
		return "/budget/budgetRegisterForm";
	}

	// 예산 등록
	@RequestMapping(value = "/budget_register", method = RequestMethod.POST)
	public String register(@ModelAttribute BudgetVO bVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.registerBudget(bVo));
		return "redirect:./budget_list";
	}

	// 예산 정보 조회
	@RequestMapping(value = "/budget_info", method = RequestMethod.GET)
	public String info(Model model, @RequestParam String budget_num) throws Exception {
		BudgetVO bVo = service.selectBudgetNyNum(budget_num);
		model.addAttribute("budget", bVo);
		return "/budget/budgetInfo";
	}

	// 예산 항목 삭제
	@RequestMapping(value = "/budget_delete", method = RequestMethod.GET)
	public String delete(@RequestParam String budget_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deleteBudget(budget_num));
		return "redirect:./budget_list";
	}

	// 예상 항목 수정 폼
	@RequestMapping(value = "/budget_update_form", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam String budget_num) throws Exception {
		BudgetVO bVo = service.selectBudgetNyNum(budget_num);
		model.addAttribute("budget", bVo);
		return "/budget/budgetUpdateForm";
	}

	// 예산 항목 수정
	@RequestMapping(value = "/budget_update", method = RequestMethod.POST)
	public String update(@ModelAttribute BudgetVO bVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateBudget(bVo));
		return "redirect:./budget_list";
	}

}
