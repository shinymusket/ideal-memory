package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import com.indieus.ius.vo.BudgetVO;

public interface BudgetService {

	public List<BudgetVO> selectAllBudget() throws Exception;

	public List<BudgetVO> selectBudgetByBudgetIe(String budget_iE) throws Exception;

	public Object getBudgetList() throws Exception;

	public Object getBudgetListByYear(Map<String, Object> map) throws Exception;

	public List<String> selectAllBudgetYear() throws Exception;

	public int registerBudget(BudgetVO bVo) throws Exception;

	BudgetVO selectBudgetNyNum(String budget_num) throws Exception;

	public int deleteBudget(String budget_num) throws Exception;

	public int updateBudget(BudgetVO bVo) throws Exception;

}
