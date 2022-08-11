package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.indieus.ius.vo.AllergyVO;
import com.indieus.ius.vo.MealMenuVO;

public interface MealMenuService {
	public List<MealMenuVO> allMealMenuView() throws Exception;

	public List<AllergyVO> allergyInfo() throws Exception;

	public int inputMenu(String menu_edate, @RequestParam(value="meal_code[]") String[] meal_code, @RequestParam(value="menu[]") String[] menu, @RequestParam(value="kcal[]") int[] kcal, @RequestParam(value="allergy[]") String[] allergy) throws Exception;

	public List<MealMenuVO> menuSelectByMenuNum(String menu_edate) throws Exception;

	public void mealDelete(@RequestParam Map<String, Object> map) throws Exception;

	public int modifyUpdateMenu(String menu_edate, @RequestParam(value="menu_num[]") String[] menu_num, @RequestParam(value="meal_code[]") String[] meal_code, @RequestParam(value="menu[]") String[] menu, @RequestParam(value="kcal[]") int[] kcal,
			@RequestParam(value="allergy[]") String[] allergy) throws Exception;
}
