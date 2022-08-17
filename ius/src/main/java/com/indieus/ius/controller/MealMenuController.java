package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.MealMenuServiceImpl;
import com.indieus.ius.vo.AllergyVO;
import com.indieus.ius.vo.MealMenuVO;

@Controller
@RequestMapping("/meal")
public class MealMenuController {

	@Autowired
	private MealMenuServiceImpl service;

	@RequestMapping(value = "/meal_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<MealMenuVO> list = service.allMealMenuView();
		model.addAttribute("menuList", list);
		return "/meal/meal_list";
	}

	// 식단 등록 폼 이동
	@RequestMapping(value ="/addMealMenu")
	public String addMenu() throws Exception {
		return "/meal/addMealMenu";
	}

	// 알러지 정보 불러오기, 선택 페이지 이동
	@RequestMapping(value ="/allergyInfo")
	public String allergyInfo(Model model) throws Exception {
		List<AllergyVO> list = service.allergyInfo();
		model.addAttribute("allergyList", list);
		return "/meal/allergyInfo";
	}

//	@RequestMapping(value = "/addMenu", method = RequestMethod.POST)
//	public String inputMenu(String menu_edate, @RequestParam(value="meal_code[]") String[] meal_code, @RequestParam(value="menu[]") String[] menu, @RequestParam(value="kcal[]") int[] kcal, @RequestParam(value="allergy[]") String[] allergy) throws Exception {
//
//	//System.out.println(list);
//		service.inputMenu(menu_edate, meal_code, menu, kcal, allergy);
//
//		return "redirect:./meal_list";
//	}

	@RequestMapping(value = "/addMenu", method = RequestMethod.POST)
	public String inputMenu(HttpServletRequest request) throws Exception {

		service.inputMenu(request);
		return "redirect:./meal_list";
	}

	// 식단 수정 폼 이동
	@RequestMapping(value ="/menuSelectByMenuNum", method = RequestMethod.GET)
	public String menuSelectByMenuNum(String menu_edate, Model model) throws Exception {
		List<MealMenuVO> list = service.menuSelectByMenuNum(menu_edate);
		model.addAttribute("list", list);
		model.addAttribute("menu_edate", menu_edate);
		System.out.println(menu_edate);
		System.out.println(list);
		return "/meal/modifyMealMenu";
	}

	@ResponseBody
	@RequestMapping(value ="/meal_delete", method = RequestMethod.POST)
	public void mealDelete(@RequestParam Map<String, Object> map) throws Exception {
		service.mealDelete(map);
	}

	@RequestMapping(value = "/modifyMealMenu", method = RequestMethod.POST)
	public String modifyUpdateMenu(HttpServletRequest request) throws Exception {

		service.modifyUpdateMenu(request);
		return "redirect:./meal_list";
	}


}
