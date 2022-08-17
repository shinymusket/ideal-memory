package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.AllergyVO;
import com.indieus.ius.vo.MealMenuVO;

public class MealMenuDAO {

	@Autowired
	SqlSession sqlsession = null;

	public List<MealMenuVO> allMealMenuView() throws Exception {
		return sqlsession.selectList("meal.all_meal_menu_view");
	}

	public List<AllergyVO> allergyInfo() throws Exception {
		return sqlsession.selectList("meal.allergy_info");
	}

	@Transactional
	public int inputMenu(Map<String, Object> map) {
		return sqlsession.insert("meal.insert_meal_menu", map);

	}

	public List<MealMenuVO> menuSelectByMenuNum(String menu_edate) throws Exception{
		return sqlsession.selectList("meal.meal_select_by_num", menu_edate);
	}

	@Transactional
	public int mealDelete(Map<String, Object> map) {
		return sqlsession.delete("meal.meal_delete", map);
	}

	@Transactional
	public int modifyUpdateMenu(List<MealMenuVO> list) {
		return sqlsession.update("meal.modify_update_meal_menu", list);
	}

	// 메인뷰에 띄울 오늘의 식단 정보 가져오기
	public List<MealMenuVO> getTodayMenuForMain(String today_date) throws Exception {
		return sqlsession.selectList("meal.select_today_menu_for_main", today_date);
	}


}
