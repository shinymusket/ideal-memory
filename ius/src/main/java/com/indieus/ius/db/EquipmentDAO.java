package com.indieus.ius.db;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.EquipClsVO;
import com.indieus.ius.vo.EquipmentVO;
import com.indieus.ius.vo.FinanceVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffVO;

@Repository
public class EquipmentDAO {

	@Inject
	private SqlSession sqlsession;


	// 전체 비품 리스트 가져오기
	public List<EquipmentVO> getAllEquipList() throws Exception {
		return sqlsession.selectList("equipment.get_all_equipment_list");
	}

	// 비품 등록을 위한 다음 시퀀스 번호 가져오기
	public int selectEquipmentSeq() throws Exception {
		return sqlsession.selectOne("equipment.select_equipment_seq");
	}

	// 교직원 아이디로 이름 가져오기
	public String selectStaffNameById(String staff_id) throws Exception {
		return sqlsession.selectOne("equipment.select_staff_name_by_id", staff_id);
	}

	// 시설(비품) 분류 항목 리스트 가져오기
	public List<EquipClsVO> selectEquipClsList() throws Exception {
		return sqlsession.selectList("equipment.select_equip_cls_list");
	}

	// 시설(비품) 분류 항목 - 코드로 정보 가져오기
	public EquipClsVO selectEquipClsByNum(String equip_cls_num) throws Exception {
		return sqlsession.selectOne("equipment.select_equip_cls_by_num", equip_cls_num);
	}

	// 시설(비품) 분류 항목 -  추가하기
	@Transactional
	public int insertEquipcls(EquipClsVO ecVo) throws Exception {
		return sqlsession.insert("equipment.insert_equip_cls", ecVo);
	}

	// 시설(비품) 분류 항목 수 가져오기
	public int selectEquipClsCnt() throws Exception {
		return sqlsession.selectOne("equipment.select_equip_cls_cnt");
	}

	// 시설(비품) 분류 항목 삭제하기
	@Transactional
	public int deleteEquipcls(String equip_cls_num) throws Exception {
		return sqlsession.delete("equipment.delete_equip_cls", equip_cls_num);
	}

	// 시설(비품) 분류 항목 수정하기
	@Transactional
	public int updateEquipcls(EquipClsVO ecVo) throws Exception {
		return sqlsession.update("equipment.update_equip_cls", ecVo);

	}

	// 시설(비품) 등록하기
	@Transactional
	public int insertEquipment(EquipmentVO eVo) throws Exception  {
		return sqlsession.insert("equipment.insert_equipment", eVo);
	}

	// 시설(비품) 정보 가져오기
	public EquipmentVO selectEquipmentByNum(String equipment_num) throws Exception {
		return sqlsession.selectOne("equipment.select_equipment_by_num", equipment_num);
	}

	// 시설(비품) 정보 수정 혹은 삭제 전 해당 항목의 데이터가 있는지 체크
	public int checkEquipmentFromCls(String equip_cls_num) throws Exception {
		return sqlsession.selectOne("equipment.check_equipment_from_cls", equip_cls_num);
	}

	// 시설(비품) 정보 수정하기
	@Transactional
	public int updateEquipment(EquipmentVO eVo) throws Exception {
		return sqlsession.update("equipment.update_equipment", eVo);
	}

	// 시설(비품) 정보 삭제 전 해당 항목의 구매내역이 있는지 유무 확인
	public int checkPurchaseCntFromEquipment(String equipment_num) throws Exception {
		return sqlsession.selectOne("equipment.check_purchase_cnt_from_equipment", equipment_num);
	}


	// 시설(비품) 정보 삭제하기
	@Transactional
	public int deleteEquipment(String equipment_num) throws Exception {
		return sqlsession.delete("equipment.delete_equipment", equipment_num);
	}

	// 구매품 등록-------------------------------

	// 구매품 등록을 위한 다음 구매번호 시퀀스 가져오기
	public int selectPurchaseSeq() throws Exception {
		return sqlsession.selectOne("equipment.select_purchase_seq");
	}

	// 교직원 아이디로 교직원 사번과 이름 가져오기
	public StaffVO selectStaffNumNameById(String staff_id) throws Exception {
		return sqlsession.selectOne("equipment.select_staff_num_name_by_id", staff_id);
	}

	// 구매품 등록을 위한 재정 리스트 가져오기
	public List<FinanceVO> selectFinanceList() throws Exception {
		return sqlsession.selectList("equipment.select_finance_list");
	}

	// 구매품 등록
	@Transactional
	public int insertPurchaseEquipment(PurchaseVO pVo) throws Exception {
		return sqlsession.insert("equipment.insert_purchase", pVo);
	}

	// 구매리스트 가져오기
	public List<PurchaseVO> selectPurchaseList() throws Exception {
		return sqlsession.selectList("equipment.select_purchase_list");
	}

	// 구매 정보 가져오기
	public PurchaseVO getPurchaseInfo(String purchase_num) {
		return sqlsession.selectOne("equipment.select_purchase_info", purchase_num);
	}

	// 구매 정보 삭제하기
	@Transactional
	public int deletePurchase(String purchase_num) {
		return sqlsession.delete("equipment.delete_purchase" , purchase_num);
	}

	// 구매 정보 수정하기
	@Transactional
	public int updatePurchase(PurchaseVO pVo) throws Exception {
		return sqlsession.update("update_purchase", pVo);
	}

}
