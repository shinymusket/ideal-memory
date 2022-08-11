package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.indieus.ius.vo.FinanceVO;
import com.indieus.ius.vo.PurchaseVO;

public interface FinanceService {

	public Object selectFinanceList() throws Exception;

	public List<String> selectAllFinanceEyear() throws Exception;

	public Object getBudgetList(Map<String, Object> map) throws Exception;

	public Object getFinanceListByYear(Map<String, Object> map) throws Exception;

	public int selectFinanceSeq() throws Exception;

	public int insertFinance(FinanceVO fVo) throws Exception;

	public FinanceVO selectFinanceByNum(String finance_num) throws Exception;

	public int deleteFinance(String finance_num, HttpServletResponse response) throws Exception;

	public int updateFinance(FinanceVO fVo) throws Exception;

	public List<PurchaseVO> selectPurchaseFromNum(String finance_num) throws Exception;

	public int selectPurchaseSumFromNum(String finance_num) throws Exception;

	public Object searchFinance(Map<String, Object> map) throws Exception;

}
