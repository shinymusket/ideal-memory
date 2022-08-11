package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import com.indieus.ius.vo.EventVO;

public interface EventService {

	public List<EventVO> getAllEventList() throws Exception;

	public int eventRegister(EventVO eVo) throws Exception;

	public Object getEventInfo(Map<String, Object> map) throws Exception;

	public Object getEventNameByNum(Map<String, Object> map) throws Exception;

	public void deleteEventByNum(Map<String, Object> map) throws Exception;

	public void updateEventByNum(Map<String, Object> map) throws Exception;

	public void registerEvent(Map<String, Object> map) throws Exception;
}
