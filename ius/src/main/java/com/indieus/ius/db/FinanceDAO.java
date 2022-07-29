package com.indieus.ius.db;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.FinanceVO;
import com.indieus.ius.vo.PurchaseVO;

@Repository
public class FinanceDAO {

	@Autowired
	SqlSession sqlsession = null;

	// 재정 리스트 가져오기
	public List<FinanceVO> selectFinanceList() throws Exception {
		return sqlsession.selectList("finance.select_finance_list");
	}

	// 재정 전체 회계 년도 조회
	public List<String> selectAllFinanceEyear() throws Exception {
		return sqlsession.selectList("finance.select_all_finance_eYear");
	}

	// 회계 년도별 재정 조회
	public List<FinanceVO> selectFinanceByEyear(String finance_eYear, String financeType) throws Exception {
		HashMap<String, String> selectInfo = new HashMap<>();

		selectInfo.put("finance_eYear", finance_eYear);
		selectInfo.put("financeType", financeType);

		return sqlsession.selectList("finance.select_finance_by_year", selectInfo);
	}

	// 회계 년도별 재정 총수입 가져오기
	public int selectTotalIncomeByEyear(String finance_eYear) throws Exception {
		int result = 0;
		if (sqlsession.selectOne("finance.select_total_income", finance_eYear) != null) {
			result = sqlsession.selectOne("finance.select_total_income", finance_eYear);
		}

		return result;
	}

	// 회계 년도별 재정 총지출 가져오기
	public int selectTotalExpenseByEyear(String finance_eYear) throws Exception {
		int result = 0;
		if (sqlsession.selectOne("finance.select_total_Expense", finance_eYear) != null) {
			result = sqlsession.selectOne("finance.select_total_Expense", finance_eYear);
		}

		return result;
	}



	//  재정등록을 위한 다음 시퀀스 값 확인하기
	public int selectFinanceSeq() throws Exception {
		return sqlsession.selectOne("finance.select_finance_seq");
	}


	// 재정등록
	@Transactional
	public int insertFinance(FinanceVO fVo) throws Exception {
		return sqlsession.insert("finance.insert_finance", fVo);
	}

	// 재정 상세보기
	public FinanceVO selectFinanceByNum(String finance_num) throws Exception {
		return sqlsession.selectOne("finance.select_finance_info", finance_num);
	}

	// 재정 삭제전 해당 항목의 구매 내역 유무 확인
	public int selectPurchaseCntFromFinance(String finance_num) throws Exception {
		return sqlsession.selectOne("finance.select_purchase_cnt_from_finance", finance_num);
	}

	// 재정 삭제
	@Transactional
	public int deleteFinance(String finance_num) throws Exception  {
		return sqlsession.delete("finance.delete_finance", finance_num);
	}

	// 재정 내역 수정
	@Transactional
	public int updateFinance(FinanceVO fVo) throws Exception {
		return sqlsession.update("finance.update_finance", fVo);
	}

	// 재정 사용 구매 내역 가져오기
	public List<PurchaseVO> selectPurchaseFromNum(String finance_num) throws Exception  {
		return sqlsession.selectList("finance.select_purchase_from_finance_num", finance_num);
	}

	// 재정 사용 구매 내역 총합 가져오기
	public int selectPurchaseSumFromNum(String finance_num) throws Exception {
		return sqlsession.selectOne("finance.select_purchase_sum_from_finance_num", finance_num);
	}

}
