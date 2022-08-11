package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.ConsultDAO;
import com.indieus.ius.db.ReceiptDAO;
import com.indieus.ius.vo.ReceiptVO;

public class ReceiptServiceImpl implements ReceiptService {

	@Inject
	private ReceiptDAO manager;
	@Inject
	private ConsultDAO consultManager;

	// 원생별 수납 관리 내역 가져오기 Ajax
	@Override
	public Object getReceiptByKinderNum(Map<String, Object> map) throws Exception {
		List<ReceiptVO> receiptInfo = manager.getReceiptByKinderNum(map);
		String kinder_name = consultManager.getKinderNameByNum(map);

		Map<String, Object> data = new HashMap();
		data.put("receiptInfo", receiptInfo);
		data.put("kinder_name", kinder_name);
		return data;
	}

	// 원생 수납 관리 내역 날짜별 조회 Ajax
	@Override
	public Object selectReceipt(Map<String, Object> map) throws Exception {
		List<ReceiptVO> receiptInfo = manager.selectReceipt(map);

		Map<String, Object> data = new HashMap();
		data.put("receiptInfo", receiptInfo);
		return data;
	}

	// 수납 내역 등록 Ajax
	@Override
	public void registerReceipt(Map<String, Object> map) throws Exception {
		manager.registerReceip(map);
	}

	// 수정 혹은 삭제를 위해 데이터값 가져오기 Ajax
	@Override
	public Object getReceiptByReceiptCode(Map<String, Object> map) throws Exception {
		ReceiptVO receiptInfo = manager.getReceiptByReceiptCode(map);
		Map<String, Object> data = new HashMap();
		data.put("receiptInfo", receiptInfo);
		return data;

	}

	// 수납 내역 수정 Ajax
	@Override
	public void updateReceipt(Map<String, Object> map) throws Exception {
		manager.updateReceipt(map);

	}

	@Override
	// 수납 내역 삭제 Ajax
	public void deleteReceipt(Map<String, Object> map) throws Exception {
		manager.deleteReceipt(map);

	}


}
