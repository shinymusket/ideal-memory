package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.EventDAO;
import com.indieus.ius.vo.EventVO;

public class EventServiceImpl implements EventService {

	@Inject
	private EventDAO manager;

	// 모든 일정 가져오기
	@Override
	public List<EventVO> getAllEventList() throws Exception {
		return manager.getAllEventList();
	}

	// 행사 및 일정 등록
	@Override
	public int eventRegister(EventVO eVo) throws Exception {
		return manager.eventRegister(eVo);
	}

	// 날짜별 행사 및 일정 정보 받아오기 Ajax
	@Override
	public Object getEventInfo(Map<String, Object> map) throws Exception {
		String event_date = (String) map.get("event_date");
		List<EventVO> eventList = manager.eventSelectByEventDate(event_date);
		Map<String, Object> data = new HashMap();
		data.put("eventList", eventList);
		return data;
	}


	// 행사 번호로 행사명 가져오기 Ajax
	@Override
	public Object getEventNameByNum(Map<String, Object> map) throws Exception {
		EventVO eventInfo = manager.getEventNameByNum(map);
		Map<String, Object> data = new HashMap();
		data.put("eventInfo", eventInfo);
		return data;
	}

	// 행사 번호로 행사명 삭제하기 Ajax
	@Override
	public void deleteEventByNum(Map<String, Object> map) throws Exception {
		manager.deleteEventByNum(map);

	}

	// 행사명 수정하기 Ajax
	@Override
	public void updateEventByNum(Map<String, Object> map) throws Exception {
		manager.updateEventByNum(map);

	}

	// 행사명 추가하기 Ajax
	@Override
	public void registerEvent(Map<String, Object> map) throws Exception {
		String event_date =  (String) map.get("event_date");
		String event_name =  (String) map.get("event_name");
		String staff_id =  (String) map.get("staff_id");
		EventVO eVo = new EventVO();
		eVo.setEvent_date(event_date);
		eVo.setEvent_name(event_name);
		eVo.setStaff_id(staff_id);

		manager.eventRegister(eVo);

	}



}
