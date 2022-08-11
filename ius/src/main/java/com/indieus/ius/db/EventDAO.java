package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.EventVO;

@Repository
public class EventDAO {

	@Autowired
	private SqlSession sqlsession;

	// 모든 일정 가져오기
	public List<EventVO> getAllEventList() throws Exception {
		return sqlsession.selectList("event.select_all_event_list");
	}

	// 행사 및 일정 등록
	@Transactional
	public int eventRegister(EventVO eVo) throws Exception {
		return sqlsession.insert("event.insert_event", eVo);
	}

	// 행사 및 일정 조회
	public List<EventVO> eventSelectByEventDate(String event_date) throws Exception {
		return sqlsession.selectList("event.select_by_event_date", event_date);
	}

	// 행사 번호로 행사명 가져오기
	public EventVO getEventNameByNum(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("event.select_by_event_num", map);
	}

	// 행사 번호로 행사 삭제하기
	@Transactional
	public void deleteEventByNum(Map<String, Object> map) throws Exception {
		sqlsession.delete("event.delete_by_event_num", map);

	}

	// 행사명 수정하기
	@Transactional
	public void updateEventByNum(Map<String, Object> map) throws Exception {
		sqlsession.update("event.update_event_name", map);

	}

	// 메인 화면에 띄울 행사 리스트 정보(최대 8개까지) 가져오기
	public List<EventVO> getEventListForMain(String today_date) throws Exception {
		return sqlsession.selectList("event.select_event_list_for_main", today_date);
	}

}
