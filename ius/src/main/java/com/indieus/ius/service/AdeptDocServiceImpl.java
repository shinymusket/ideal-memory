package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.EworksListDAO;
import com.indieus.ius.vo.EworksBoardVO;

public class AdeptDocServiceImpl implements AdeptDocService{

	@Inject
	private EworksListDAO manager;

	// 전자결재 리스트 가져오기 Ajax
	@Override
	public Object getEworksList() throws Exception {
		List<EworksBoardVO> eworksBoardList =  manager.selectAllEworkList();
		Map<String, Object> data = new HashMap();
		data.put("eworksBoardList", eworksBoardList);
		return data;
	}
}
