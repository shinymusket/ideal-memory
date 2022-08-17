package com.indieus.ius.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import com.indieus.ius.db.AuthorityDAO;
import com.indieus.ius.db.EventDAO;
import com.indieus.ius.db.KinderDAO;
import com.indieus.ius.db.MainDAO;
import com.indieus.ius.db.MealMenuDAO;
import com.indieus.ius.db.NoticeDAO;
import com.indieus.ius.utils.UploadFileUtils;
import com.indieus.ius.vo.AuthorityVO;
import com.indieus.ius.vo.EventVO;
import com.indieus.ius.vo.MealMenuVO;
import com.indieus.ius.vo.NoticeVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

public class MainServiceImpl implements MainService {

	@Inject
	private MainDAO manager;
	@Inject
	private AuthorityDAO authManager;
	@Inject
	private NoticeDAO noticeManager;
	@Inject
	private EventDAO eventManager;
	@Inject
	private MealMenuDAO mealManager;
	@Inject
	private KinderDAO kinderManager;

	@Value("${host.smtp.id}")
	private String hostSMTPid;
	@Value("${host.smtp.pwd}")
	private String hostSMTPpwd;

	@Resource(name="uploadPath")
	private String uploadPath;

	// 이메일이 있는지 유무 체크 Ajax
	@Override
	public Object getEmailExistCheck(Map<String, Object> map) throws Exception {
		int result = manager.getEmailExistCheck(map);
		Map<String, Object> data = new HashMap();
		data.put("result", result);
		return data;
	}

	// 이메일로 임시비밀번호 발송하기 Ajax
	@Override
	public Object searchPasswordByEmail(Map<String, Object> map) throws Exception {
		int result = 0;

		int check = manager.getEmailExistCheck(map);
		String staff_email = (String) map.get("staff_email");
		if (check != 0) { // 이메일이 있을 때만 실행

			// 이메일로 해당 계정의 아이디, 비밀번호, 이름 가져오기.
			StaffIdVO sIvo = manager.getStaffInfoByEmail(staff_email);

			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}

			// 해당 계정의 비밀번호를 임시비밀번호로 재설정 후 변경 데이터 입력
			sIvo.setStaff_pwd(pw);
			manager.updateStaffPwd(sIvo);

			// 해당 임시비밀번호 발급 내용을 메일로 발송

			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";

			// 보내는 사람 Email, 제목, 내용
			String fromEmail = "zz1489@naver.com";
			String fromName = "IUS Homepage";
			String subject = "";
			String msg = "";

			subject = "귀하의 IUS Homepage 계정의 임시비밀번호가 발급되었습니다.";

			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += sIvo.getStaff_name() + "님 계정의 비밀번호가 임시로 발급되었습니다.";
			msg += "하단의 임시비밀번호를 확인 후 링크로 이동하여 새로운 비밀번호를 설정하세요.</h3></div><br/>";
			msg += "<p>임시 비밀번호 : ";
			msg += sIvo.getStaff_pwd() + "</p>";
			msg += "<a href='http://localhost:8085/ius/'>홈페이지로 이동</a></div>";

			String mail = staff_email;
			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg(msg);
				email.send();
			} catch(Exception e) {
				System.out.println("메일발송 실패 : " + e);
			}



			result = 1;
		}

		Map<String, Object> data = new HashMap();
		data.put("result", result);

		return data;


	}

	// 권한 코드로 권한 정보 가져오기
	@Override
	public AuthorityVO selectAuthByCode(String auth_code) throws Exception {
		return authManager.selectAuthByCode(auth_code);
	}

	// 로그인 후 권한 코드로 권한 정보 가져오기 Ajax
	@Override
	public Object getAuthInfoByCode(Map<String, Object> map) throws Exception {
		String auth_code = (String) map.get("auth_code");
		AuthorityVO authInfo = authManager.selectAuthByCode(auth_code);

		Map<String, Object> data = new HashMap();
		data.put("authInfo", authInfo);

		return data;
	}

	// 내 회원 정보 수정
	@Override
	public int myStaffInfoUpdate(StaffVO sVo, MultipartFile staff_picFile) throws Exception {
		if(staff_picFile.getSize() != 0) { // 수정 프로필 요청 사진이 있을 시
			MultipartFile file = staff_picFile;

			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = null;

			if(file != null) {
				fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			} else {
				fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
			}

			System.out.println(imgUploadPath);
			System.out.println(ymdPath);

			sVo.setStaff_picture(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		}

		return manager.myStaffInfoUpdate(sVo);
	}

	// 기존 비밀번호 일치 유무 체크 Ajax
	@Override
	public Object checkOriginPassword(Map<String, Object> map) throws Exception {
		int result = manager.checkOriginPassword(map);

		Map<String, Object> data = new HashMap();
		data.put("result", result);

		return data;
	}

	// 비밀번호 변경
	@Override
	public int updatePassword(Map<String, Object> map) throws Exception {
		int result = manager.updatePassword(map);
		return result;
	}

	// 초기 메인 화면에 띄울 정보 가져오기 Ajax
	@Override
	public Object getInfo(Map<String, Object> map) throws Exception {
		String today_date = (String) map.get("today_date");

		List<NoticeVO> noticeList = noticeManager.getNoticeListForMain();
		List<EventVO> eventList = eventManager.getEventListForMain(today_date);

		// 오늘의 식단 메뉴 가져옴.
		List<MealMenuVO> mealList = mealManager.getTodayMenuForMain(today_date);

		Map<String, Object> data = new HashMap();
		data.put("noticeList", noticeList);
		data.put("eventList", eventList);
		data.put("mealList", mealList);

		return data;
	}



}


