package com.indieus.ius.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.indieus.ius.db.MealMenuDAO;
import com.indieus.ius.vo.AllergyVO;
import com.indieus.ius.vo.MealMenuVO;

public class MealMenuServiceImpl implements MealMenuService {

	@Inject
	private MealMenuDAO manager;

	// 식단표 보여주기 //
	@Override
	public List<MealMenuVO> allMealMenuView() throws Exception {

		List<MealMenuVO> list = null;

		try {
		list =  manager.allMealMenuView();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 알러지 정보 불러오기 //
	@Override
	public List<AllergyVO> allergyInfo() throws Exception {
		List<AllergyVO> list = null;

		list = manager.allergyInfo();

		return list;
	}

	// 식단 메뉴 추가 //
//	@Override
//	public int inputMenu
//	(String menu_edate, @RequestParam(value="meal_code[]") String[] meal_code, @RequestParam(value="menu[]") String[] menu, @RequestParam(value="kcal[]") int[] kcal, @RequestParam(value="allergy[]") String[] allergy) throws Exception {
//		List<MealMenuVO> list = new ArrayList<>();
//		for(int i=0; i < menu.length; i++) {
//			MealMenuVO mmVo = new MealMenuVO();
//
//			mmVo.setMenu_edate(menu_edate);
//			mmVo.setMeal_code(meal_code[i]);
//			mmVo.setMeal_menu(menu[i]);
//			mmVo.setMenu_calorie(kcal[i]);
//			mmVo.setAllergy_num(allergy[i]);
//
//			list.add(mmVo);
//		}
//		Map<String, Object> map = new HashMap();
//		map.put("list", list);
//
//		return manager.inputMenu(map);
//	}

	@Override
	public int inputMenu (HttpServletRequest request) throws Exception {

		String[] menu_num = request.getParameterValues("menu_num[]");
		String[] meal_code = request.getParameterValues("meal_code[]");
		String[] menu = request.getParameterValues("menu[]");
		String[] kcal = request.getParameterValues("kcal[]");
		String[] allergy = request.getParameterValues("allergy[]");
		String menu_edate = request.getParameter("menu_edate");


		try {
			List<MealMenuVO> list = new ArrayList<>();
			for(int i=0; i < menu.length; i++) {
				MealMenuVO mmVo = new MealMenuVO();

				mmVo.setMenu_edate(menu_edate);
				mmVo.setMeal_code(meal_code[i]);
				mmVo.setMeal_menu(menu[i]);
				mmVo.setMenu_calorie(Integer.parseInt(kcal[i]));
				mmVo.setAllergy_num(allergy[i]);

				list.add(mmVo);
			}
			Map<String, Object> map = new HashMap();
			map.put("list", list);

			return manager.inputMenu(map);

		}catch(NullPointerException e) {
			return 0;
		}


	}

	// 날짜 식단 정보 불러오기 //
	@Override
	public List<MealMenuVO> menuSelectByMenuNum(String menu_edate) throws Exception {
		List<MealMenuVO> list = manager.menuSelectByMenuNum(menu_edate);
		return list;
	}

	// 식단 정보에서 삭제 //
	@Override
	public void mealDelete(@RequestParam Map<String, Object> map) throws Exception {
		manager.mealDelete(map);
	}


	@Override
	public int modifyUpdateMenu(HttpServletRequest request) throws Exception {

		String[] menu_num = request.getParameterValues("menu_num[]");
		String[] meal_code = request.getParameterValues("meal_code[]");
		String[] menu = request.getParameterValues("menu[]");
		String[] kcal = request.getParameterValues("kcal[]");
		String[] allergy = request.getParameterValues("allergy[]");
		String menu_edate = request.getParameter("menu_edate");

		List<MealMenuVO> list = new ArrayList<>();

		for(int i=0; i < meal_code.length; i++) {

			MealMenuVO mmVo = new MealMenuVO();

			mmVo.setMenu_num(menu_num[i]);
			mmVo.setMeal_code(meal_code[i]);
			mmVo.setMenu_edate(menu_edate);
			mmVo.setMeal_menu(menu[i]);
			mmVo.setMenu_calorie(Integer.parseInt(kcal[i]));
			mmVo.setAllergy_num(allergy[i]);

			System.out.println(menu_num[i]+ ", " + meal_code[i]+ ", " +menu_edate+ ", " + menu[i]+ ", " + kcal[i]+ ", " +allergy[i]);
			list.add(mmVo);
		}


		return manager.modifyUpdateMenu(list);

	}

}
