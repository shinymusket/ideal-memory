package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.ReceiptVO;

@Repository
public class ReceiptDAO {

	@Autowired
	private SqlSession sqlsession;

	// 원생별 수납 관리 내역 가져오기
	public List<ReceiptVO> getReceiptByKinderNum(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("receipt.select_receipt_by_kinder_num", map);
	}

	// 원생 수납 관리 내역 날짜별 조회
	public List<ReceiptVO> selectReceipt(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("receipt.select_receipt_by_date", map);
	}

	// 수납 내역 등록
	@Transactional
	public void registerReceip(Map<String, Object> map) throws Exception {
		sqlsession.insert("receipt.insert_receipt", map);

	}

	// 수정 혹은 삭제를 위해 데이터값 가져오기
	public ReceiptVO getReceiptByReceiptCode(Map<String, Object> map) throws Exception{
		return sqlsession.selectOne("select_receipt_by_receipt_code", map);
	}

	// 수납 내역 수정
	@Transactional
	public void updateReceipt(Map<String, Object> map) throws Exception {
		sqlsession.update("receipt.update_receipt", map);

	}

	// 수납 내역 삭제
	@Transactional
	public void deleteReceipt(Map<String, Object> map) throws Exception {
		sqlsession.delete("receipt.delete_receipt", map);

	}


}
