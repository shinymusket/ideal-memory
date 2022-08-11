package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.BudgetDAO;
import com.indieus.ius.vo.BudgetVO;

public class BudgetServiceImpl implements BudgetService {

	@Inject
	private BudgetDAO manager;

	// 전체 예산 항목 조회
	@Override
	public List<BudgetVO> selectAllBudget() throws Exception {
		return manager.selectAllBudget();
	}

	// 수입 지출별 예산 항목 조회
	@Override
	public List<BudgetVO> selectBudgetByBudgetIe(String budget_iE) throws Exception {
		return manager.selectBudgetByBudgetIe(budget_iE);
	}

	// 예산 리스트 가져오기 Ajax
	@Override
	public Object getBudgetList() throws Exception {
		List<BudgetVO> budgetList = manager.selectAllBudget();
		Map<String, Object> retVal = new HashMap();
		retVal.put("budgetList", budgetList);
		return retVal;
	}

	// 년도별 예산 리스트 가져오기 Ajax
	@Override
	public Object getBudgetListByYear(Map<String, Object> map) throws Exception {
		String seachYear = (String) map.get("seachYear");
		String budgetType = (String) map.get("budgetType");

		List<BudgetVO> budgetList = manager.selectBudgetByYear(seachYear, budgetType);
		int totalIncome  = manager.selectTotalIncome(seachYear);
		int totalExpense = manager.selectTotalExpense(seachYear);


		Map<String, Object> retVal = new HashMap();
		retVal.put("budgetList", budgetList);
		retVal.put("totalIncome", totalIncome);
		retVal.put("totalExpense", totalExpense);
		return retVal;
	}

	// 전체 예산 년도 조회
	@Override
	public List<String> selectAllBudgetYear() throws Exception {
		return manager.selectAllBudgetYear();
	}

	// 예상 항목 추가
	@Override
	public int registerBudget(BudgetVO bVo) throws Exception {
		return manager.registerBudget(bVo);
	}

	// 예산 정보조회
	@Override
	public BudgetVO selectBudgetNyNum(String budget_num) throws Exception {
		return manager.selectBudgetByNum(budget_num);
	}

	// 예산 항목 삭제시 예산 항목으로 생성된 재정 데이터가 있는지 확인
	@Override
	public Object countFinanceFromBudget(Map<String, Object> map) throws Exception {
		int result = manager.countFinanceFromBudget(map);

		Map<String, Object> data = new HashMap();
		data.put("result", result);
		return data;
	}

	// 예산 항목 삭제
	@Override
	public int deleteBudget(String budget_num) throws Exception {
		return manager.deleteBudget(budget_num);
	}

	// 예산 항목 수정
	@Override
	public int updateBudget(BudgetVO bVo) throws Exception {
		return manager.updateBudget(bVo);
	}



}
