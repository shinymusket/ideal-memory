package com.indieus.ius.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.indieus.ius.utils.PagingVO;
import com.indieus.ius.vo.EquipClsVO;
import com.indieus.ius.vo.EquipmentSearchVO;
import com.indieus.ius.vo.EquipmentVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffVO;

public interface EquipmentService {

	// 리스트 총 갯수
	public int countEquipment() throws Exception;

	// 페이징 처리 게시글 조회
	public List<EquipmentVO> selectEquipment(PagingVO vo) throws Exception;

	public Object searchEquipmentList(Map<String, Object> map) throws Exception;

	public Object getEquipmentList() throws Exception;

	public int selectEquipmentSeq() throws Exception;

	public String selectStaffNameById(String staff_id) throws Exception;

	public Object getEquipmentClsList() throws Exception;

	public Object getEquipClsByNum(Map<String, Object> map) throws Exception;

	public void insertEquipCls(Map<String, Object> map) throws Exception;

	public void deleteEquipCls(Map<String, Object> map, HttpServletResponse response) throws Exception;

	public void updateEquipCls(Map<String, Object> map) throws Exception;

	public int insertEquipment(EquipmentVO eVo) throws Exception;

	public EquipmentVO selectEquipmentByNum(String equipment_num) throws Exception;

	public int updateEquipment(EquipmentVO eVo) throws Exception;

	public int deleteEquipment(String equipment_num, HttpServletResponse response) throws Exception;

	public int selectPurchaseSeq() throws Exception;

	public StaffVO selectStaffNumNameById(String staff_id) throws Exception;

	public Object getFinanceList() throws Exception;

	public int purchaseEquipRegister(PurchaseVO pVo, HttpSession session) throws Exception;

	public Object getPurchaseList() throws Exception;

	public Object searchPurchaseList(Map<String, Object> map) throws Exception;

	public PurchaseVO getPurchaseInfo(String purchase_num) throws Exception;

	public int deletePurchase(String purchase_num) throws Exception;

	public int updatePurchase(PurchaseVO pVo) throws Exception;

	public List<EquipClsVO> selEquipmentClsList() throws Exception;

	public int countSearchEquipment(EquipmentSearchVO searchInfo) throws Exception;

	public Object searchEquipment(EquipmentSearchVO searchInfo) throws Exception;
}
