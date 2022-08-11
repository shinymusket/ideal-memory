package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.ConsultDAO;
import com.indieus.ius.vo.ConsultVO;
import com.indieus.ius.vo.ParentVO;

public class ConsultServiceImpl implements ConsultService {

	@Inject
	private ConsultDAO manager;

	// 원생별 상담 일지 정보 가져오기 Ajax
	@Override
	public Object getConsultByKinderNum(Map<String, Object> map) throws Exception {
		List<ConsultVO> consultInfo = manager.getConsultByKinderNum(map);
		String kinder_name = manager.getKinderNameByNum(map);


		Map<String, Object> data = new HashMap();
		data.put("consultInfo", consultInfo);
		data.put("kinder_name", kinder_name);
		return data;
	}

	// 원생별 상담 일지 날짜로 조회하기 Ajax
	@Override
	public Object selectConsultByDate(Map<String, Object> map) throws Exception {
		List<ConsultVO> consultInfo = manager.selectConsultByDate(map);
		Map<String, Object> data = new HashMap();
		data.put("consultInfo", consultInfo);
		return data;
	}

	// 상담 일지 작성 - 원생 번호와 가족 관계로 부모님 성함 가져오기 Ajax
	@Override
	public Object selectParentNumName(Map<String, Object> map) throws Exception {
		ParentVO parentInfo = manager.selectParentNumName(map);
		Map<String, Object> data = new HashMap();
		data.put("parentInfo", parentInfo);
		return data;
	}

	// 상담 일지 수정 혹은 삭제를 위해 데이터 값 가져오기 Ajax
	@Override
	public Object getConsultByConsultCode(Map<String, Object> map) throws Exception {
		ConsultVO consultInfo = manager.getConsultByConsultCode(map);
		Map<String, Object> data = new HashMap();
		data.put("consultInfo", consultInfo);
		return data;
	}

	// 상담 일지 등록 Ajax
	@Override
	public void registerConsult(Map<String, Object> map) throws Exception {
		manager.registerConsult(map);
	}

	// 상담 일지 수정 Ajax
	@Override
	public void updateConsult(Map<String, Object> map) throws Exception {
		manager.updateConsult(map);

	}

	// 상담 일지 삭제 Ajax
	@Override
	public void deleteConsult(Map<String, Object> map) throws Exception {
		manager.deleteConsult(map);

	}



}
