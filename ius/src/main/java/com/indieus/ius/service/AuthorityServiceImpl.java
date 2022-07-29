package com.indieus.ius.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.AuthorityDAO;
import com.indieus.ius.vo.AuthorityVO;
import com.indieus.ius.vo.StaffIdVO;

public class AuthorityServiceImpl implements AuthorityService {

	@Inject
	private AuthorityDAO manager;

	// 권한 정보 불러오기 Ajax
	@Override
	public Object getAuthorityInfo(Map<String, Object> map) throws Exception {
		String staff_num = (String) map.get("staff_num");
		String auth_code = manager.selectAuthCodeByStaffNum(staff_num);
		AuthorityVO aVo = manager.selectAuthByCode(auth_code);

		Map<String, Object> retVal = new HashMap();
		retVal.put("authorityInfo", aVo);
		return retVal;
	}

	// 권한 정보 저장하기 Ajax
	@Override
	public void setAuthorityInfo(Map<String, Object> map) throws Exception {
		String staff_num = (String) map.get("staff_num");
		String staff_id = manager.selectStaffIdByStaffNum(staff_num);
		StaffIdVO sIvo = manager.selectStaffId(staff_id);

		String master = (String) map.get("master");
		String teacher = (String) map.get("teacher");
		String dietitian = (String) map.get("dietitian");
		String facilities = (String) map.get("facilities");
		String bus = (String) map.get("bus");
		String info = (String) map.get("info");
		String event = (String) map.get("event");
		String gallery = (String) map.get("gallery");






		AuthorityVO aVo = new AuthorityVO();
		if (master.equalsIgnoreCase("Y")) {
			aVo.setM("Y");
		} else if (master.equalsIgnoreCase("N")) {
			aVo.setM("N");
		}
		if (teacher.equalsIgnoreCase("Y")) {
			aVo.setT("Y");
		} else if (teacher.equalsIgnoreCase("N")) {
			aVo.setT("N");
		}
		if (dietitian.equalsIgnoreCase("Y")) {
			aVo.setD("Y");
		} else if (dietitian.equalsIgnoreCase("N")) {
			aVo.setD("N");
		}
		if (facilities.equalsIgnoreCase("Y")) {
			aVo.setF("Y");
		} else if (facilities.equalsIgnoreCase("N")) {
			aVo.setF("N");
		}
		if (bus.equalsIgnoreCase("Y")) {
			aVo.setS("Y");
		} else if (bus.equalsIgnoreCase("N")) {
			aVo.setS("N");
		}
		if (info.equalsIgnoreCase("Y")) {
			aVo.setI("Y");
		} else if (info.equalsIgnoreCase("N")) {
			aVo.setI("N");
		}
		if (event.equalsIgnoreCase("Y")) {
			aVo.setE("Y");
		} else if (event.equalsIgnoreCase("N")) {
			aVo.setE("N");
		}
		if (gallery.equalsIgnoreCase("Y")) {
			aVo.setG("Y");
		} else if (gallery.equalsIgnoreCase("N")) {
			aVo.setG("N");
		}

		int check = manager.selectCntAuth(aVo);

		if (check >= 1) { // 이미 존재하는 타입의 권한이 있음.
			String authCode = manager.selectAuthByContent(aVo);
			sIvo.setAuth_code(authCode);

		} else { // 존재하지 않는 타입일 경우 새로운 authCode 생성 check = 0;
			int num = manager.selectTotalCntAuth() - 3; // 기본 타입 4개만 있을 때는 1, 커스텀 타입이 하나만 있을 때는 2... 하나씩 증가
			String authCode = "cu";
			String authCodeName = "custom";


			String codeIdx = Integer.toString(num);
			authCode += codeIdx;
			authCodeName += codeIdx;

			System.out.println(authCode);
			System.out.println(authCodeName);


			// 새로운 이름을 가진 authCode 생성

			aVo.setAuth_name(authCodeName);
			aVo.setAuth_code(authCode);

			manager.insertNewAuth(aVo);

			sIvo.setAuth_code(authCode);

		}
		manager.updateStaffIdAuth(sIvo);

	}

}
