package com.indieus.ius.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.indieus.ius.vo.EquipmentVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffVO;

public interface EquipmentService {

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

	public PurchaseVO getPurchaseInfo(String purchase_num) throws Exception;

	public int deletePurchase(String purchase_num) throws Exception;

	public int updatePurchase(PurchaseVO pVo) throws Exception;
}
