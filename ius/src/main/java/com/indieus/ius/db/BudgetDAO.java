package com.indieus.ius.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.BudgetVO;

@Repository
public class BudgetDAO {

	@Autowired
	SqlSession sqlsession = null;

	// 전체 예산 항목 조회
	public List<BudgetVO> selectAllBudget() throws Exception {
		return sqlsession.selectList("budget.select_all_budget");
	}

	// 년도별 예산 조회
	public List<BudgetVO> selectBudgetByYear(String seachYear, String budgetType) throws Exception {
		HashMap<String, String> selectInfo = new HashMap<>();
		selectInfo.put("seachYear", seachYear);
		selectInfo.put("budgetType", budgetType);
		return sqlsession.selectList("budget.select_budget_by_year", selectInfo);
	}


	// 년도별 총 수입 예산 조회
	public int selectTotalIncome(String budget_year) throws Exception {
		int result = 0;
		if (sqlsession.selectOne("budget.select_total_Income", budget_year) !=  null) {
			result = sqlsession.selectOne("budget.select_total_Income", budget_year);
		}
		return result;
	}

	// 년도별 총 지출 예산 조회
	public int selectTotalExpense(String budget_year) throws Exception {
		int result = 0;
		if (sqlsession.selectOne("budget.select_total_Expense", budget_year) != null) {
			result = sqlsession.selectOne("budget.select_total_Expense", budget_year);
		}
		return result;
	}

	// 수입 지출별 예산 항목 조회
	public List<BudgetVO> selectBudgetByBudgetIe(String budget_iE) throws Exception {
		return sqlsession.selectList("budget.select_all_budget_by_iE", budget_iE);
	}

	// 전체 예산 년도 조회
	public List<String> selectAllBudgetYear() throws Exception {
		return sqlsession.selectList("budget.select_all_budget_year");
	}

	// 예산 항목 추가
	@Transactional
	public int registerBudget(BudgetVO bVo) throws Exception {
		return sqlsession.insert("budget.register_budget", bVo);
	}

	// 예산 정보 조회
	public BudgetVO selectBudgetByNum(String budget_num) throws Exception {
		return sqlsession.selectOne("budget.select_budget_by_num", budget_num);
	}

	// 예산 항목 삭제시 예산 항목으로 생성된 재정 데이터가 있는지 확인
	public int countFinanceFromBudget(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("budget.count_finance_from_budget", map);
	}

	// 예산 항목 삭제
	@Transactional
	public int deleteBudget(String budget_num) throws Exception {
		return sqlsession.delete("budget.delete_budget_by_num", budget_num);
	}

	// 예산 항목 수정
	@Transactional
	public int updateBudget(BudgetVO bVo) throws Exception {
		return sqlsession.update("budget.update_budget", bVo);
	}



}
