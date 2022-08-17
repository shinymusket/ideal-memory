package com.indieus.ius.service;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.indieus.ius.db.EquipmentDAO;
import com.indieus.ius.utils.PagingVO;
import com.indieus.ius.vo.EquipClsVO;
import com.indieus.ius.vo.EquipmentSearchVO;
import com.indieus.ius.vo.EquipmentVO;
import com.indieus.ius.vo.FinanceVO;
import com.indieus.ius.vo.PurchaseVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

public class EquipmentServiceImpl implements EquipmentService {

	@Inject
	private EquipmentDAO manager;

	// 리스트 총 갯수
	@Override
	public int countEquipment() throws Exception {
		return manager.countEquipment();
	}

	// 페이징 처리 게시글 조회
	@Override
	public List<EquipmentVO> selectEquipment(PagingVO vo) throws Exception {
		return manager.selectEquipment(vo);
	}

	// 검색된 리스트 총 갯수
	@Override
	public int countSearchEquipment(EquipmentSearchVO searchInfo) throws Exception {
		return manager.countSearchEquipment(searchInfo);
	}

	// 검색된 리스트 페이징 처리 조회
	@Override
	public List<EquipmentVO> searchEquipment(EquipmentSearchVO searchInfo) throws Exception {
		return manager.searchEquipment(searchInfo);
	}

	// 시설(비품) 검색 Ajax
	@Override
	public Object searchEquipmentList(Map<String, Object> map) throws Exception {
		List<EquipmentVO> equipmentList = manager.searchEquipmentList(map);

		Map<String, Object> data = new HashMap();
		data.put("equipmentList", equipmentList);
		return data;
	}


	// 시설(비품) 리스트 가져오기 Ajax
	@Override
	public Object getEquipmentList() throws Exception {
		List<EquipmentVO> equipmentList = manager.getAllEquipList();
		Map<String, Object> data = new HashMap();
		data.put("equipmentList", equipmentList);
		return data;
	}

	// 시설(비품) 등록을 위한 다음 시퀀스 가져오기
	@Override
	public int selectEquipmentSeq() throws Exception {
		return manager.selectEquipmentSeq();
	}

	// 교직원 아이디로 이름 가져오기
	@Override
	public String selectStaffNameById(String staff_id) throws Exception {
		return manager.selectStaffNameById(staff_id);
	}

	// 시설(비품) 분류 항목 리스트 가져오기 Ajax
	@Override
	public Object getEquipmentClsList() throws Exception {
		List<EquipClsVO> equipClsList = manager.selectEquipClsList();
		Map<String, Object> data = new HashMap();
		data.put("equipClsList", equipClsList);
		return data;
	}

	// 시설(비품) 분류 항목 - 코드로 항목 정보 가져오기 Ajax
	@Override
	public Object getEquipClsByNum(Map<String, Object> map) throws Exception {
		String equip_cls_num = (String) map.get("equip_cls_num");

		EquipClsVO ecVo = manager.selectEquipClsByNum(equip_cls_num);


		Map<String, Object> data = new HashMap();
		data.put("equip_cls_num", equip_cls_num);
		data.put("equip_cls_name", ecVo.getEquip_cls_name());
		return data;
	}

	// 시설(비품) 분류 항목 - 추가하기 Ajax
	@Override
	public void insertEquipCls(Map<String, Object> map) throws Exception {
		String equip_cls_name = (String) map.get("equip_cls_name");
		int equip_num = manager.selectEquipClsCnt() + 1;

		EquipClsVO ecVo = new EquipClsVO();
		ecVo.setEquip_cls_name(equip_cls_name);
		ecVo.setEquip_num(equip_num);

		manager.insertEquipcls(ecVo);
	}

	// 시설(비품) 분류 항목 - 삭제하기 Ajax
	@Override
	public void deleteEquipCls(Map<String, Object> map, HttpServletResponse response) throws Exception {
		String equip_cls_num = (String) map.get("equip_cls_num");

		int result = 0;

		result = manager.checkEquipmentFromCls(equip_cls_num);
		PrintWriter out = response.getWriter();

		if (result == 0) {
			manager.deleteEquipcls(equip_cls_num);
		}

		out.println(result);
		out.close();


	}

	// 시설(비품) 분류 항목 - 수정하기 Ajax
	@Override
	public void updateEquipCls(Map<String, Object> map) throws Exception {
		String equip_cls_name = (String) map.get("equip_cls_name");
		String equip_cls_num = (String) map.get("equip_cls_num");

		EquipClsVO ecVo = new EquipClsVO();
		ecVo.setEquip_cls_name(equip_cls_name);
		ecVo.setEquip_cls_num(equip_cls_num);
		manager.updateEquipcls(ecVo);


	}

	// 시설(비품) 등록하기
	@Override
	public int insertEquipment(EquipmentVO eVo) throws Exception {
		eVo.setEquipment_cate("시설(비품)");
		return manager.insertEquipment(eVo);
	}

	// 시설(비품) 정보 가져오기
	@Override
	public EquipmentVO selectEquipmentByNum(String equipment_num) throws Exception {
		return manager.selectEquipmentByNum(equipment_num);
	}

	// 시설(비품) 정보 수정하기
	@Override
	public int updateEquipment(EquipmentVO eVo) throws Exception {
		return manager.updateEquipment(eVo);
	}

	// 시설(비품) 정보 삭제하기
	@Override
	public int deleteEquipment(String equipment_num, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		// 시설(비품) 정보 삭제 전 해당 항목의 구매내역이 있는지 확인
		int result = manager.checkPurchaseCntFromEquipment(equipment_num);

		if (result > 0) {
			out.println("<script>");
			out.println("alert('해당 시설(비품)의 구매 내역이 있어 삭제할 수 없습니다.');");
			out.println("history.go(-1)");
			out.println("</script>");
			out.close();
			return 0;
		} else {
			return manager.deleteEquipment(equipment_num);
		}

	}

	// 검색 기능을 위한 분류 항목 리스트 가져오기
	@Override
	public List<EquipClsVO> selEquipmentClsList() throws Exception {
		return manager.selectEquipClsList();
	}



	// 구매품 -------------------------


	// 구매품 등록을 위한 다음 구매번호 시퀀스 가져오기
	@Override
	public int selectPurchaseSeq() throws Exception {
		return manager.selectPurchaseSeq();
	}

	// 교직원 아이디로 교직원 사번과 이름 가져오기
	@Override
	public StaffVO selectStaffNumNameById(String staff_id) throws Exception {
		return manager.selectStaffNumNameById(staff_id);
	}

	// 구매픔 등록을 위한 재정 리스트 가져오기 Ajax
	@Override
	public Object getFinanceList() throws Exception {
		List<FinanceVO> financeList = manager.selectFinanceList();
		Map<String, Object> data = new HashMap();
		data.put("financeList", financeList);
		return data;
	}

	// 구매품 등록
	@Override
	public int purchaseEquipRegister(PurchaseVO pVo, HttpSession session) throws Exception {
		EquipmentVO eVo = new EquipmentVO();
		eVo.setEquipment_num(pVo.getEquipment_num());
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");

		eVo.setStaff_id(staff.getStaff_id());
		eVo.setEquip_cls_num(pVo.getEquip_cls_num());
		eVo.setEquipment_name(pVo.getEquipment_name());
		eVo.setEquipment_count(pVo.getPurchase_count());
		eVo.setEquipment_regdate(pVo.getPurchase_date());
		eVo.setEquipment_cate("구매품");

		manager.insertEquipment(eVo);
		return manager.insertPurchaseEquipment(pVo);
	}

	// 구매 리스트 가져오기 Ajax
	@Override
	public Object getPurchaseList() throws Exception {
		List<PurchaseVO> purchaseList = manager.selectPurchaseList();
		Map<String, Object> data = new HashMap();
		data.put("purchaseList", purchaseList);
		return data;
	}

	// 구매 리스트 검색하기 Ajax
	@Override
	public Object searchPurchaseList(Map<String, Object> map) throws Exception {
		List<PurchaseVO> purchaseList = manager.searchPurchaseList(map);
		Map<String, Object> data = new HashMap();
		data.put("purchaseList", purchaseList);
		return data;
	}


	// 구매 정보 상세보기
	@Override
	public PurchaseVO getPurchaseInfo(String purchase_num) throws Exception {
		return manager.getPurchaseInfo(purchase_num);
	}

	// 구매 정보 삭제하기
	@Override
	public int deletePurchase(String purchase_num) throws Exception {
		return manager.deletePurchase(purchase_num);
	}

	// 구매 정보 수정하기
	@Override
	public int updatePurchase(PurchaseVO pVo) throws Exception {
		return manager.updatePurchase(pVo);
	}









}
