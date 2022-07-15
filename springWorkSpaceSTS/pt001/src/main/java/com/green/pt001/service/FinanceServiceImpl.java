package com.green.pt001.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import com.green.pt001.db.FinanceDAO;
import com.green.pt001.vo.FinanceVO;

public class FinanceServiceImpl implements FinanceService {
	
	
	@Inject
	private FinanceDAO manager;
	
	
	// 재정 목록 가져오기
	@Override
	public List<FinanceVO> selectFinanceList(HttpServletResponse response) throws Exception {
		List<FinanceVO> list = manager.selectFinanceList();
		return list;
	}
	
}
