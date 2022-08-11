package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.ConsultVO;
import com.indieus.ius.vo.ParentVO;

@Repository
public class ConsultDAO {

	@Autowired
	private SqlSession sqlsession;

	// 원생별 상담 일지 정보 가져오기
	public List<ConsultVO> getConsultByKinderNum(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("consult.select_consult_by_kinder_num", map);

	}

	// 원생 번호로 이름 가져오기
	public String getKinderNameByNum(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("consult.select_kinder_name_by_num", map);
	}

	// 원생별 상담 일지 날짜로 조회하기
	public List<ConsultVO> selectConsultByDate(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("consult.select_consult_by_date", map);
	}

	// 원생 번호와 가족 관계로 부모님 성함 가져오기
	public ParentVO selectParentNumName(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("consult.select_parent_num_name", map);
	}

	// 상담 일지 수정 혹은 삭제를 위해 데이터 값 가져오기
	public ConsultVO getConsultByConsultCode(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("consult.select_consult_by_consult_code", map);
	}

	// 상담 일지 등록
	@Transactional
	public void registerConsult(Map<String, Object> map) throws Exception {
		sqlsession.insert("consult.insert_consult", map);

	}

	// 상담 일지 수정
	@Transactional
	public void updateConsult(Map<String, Object> map) throws Exception {
		sqlsession.update("consult.update_consult", map);

	}

	// 상담 일지 삭제
	@Transactional
	public void deleteConsult(Map<String, Object> map) throws Exception {
		sqlsession.delete("consult.delete_consult", map);
	}

	// 원생의 최근 상담 기록(1개) 가져오기
	public ConsultVO selectLatestConsult(String kinder_num) throws Exception {
		return sqlsession.selectOne("consult.select_latest_consult", kinder_num);
	}



}
