package com.green.pt001.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.green.pt001.vo.FinanceVO;

public interface FinanceService {
	public List<FinanceVO> selectFinanceList(HttpServletResponse response) throws Exception;
}
