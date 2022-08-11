package com.indieus.ius.service;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartFile;

import com.indieus.ius.db.StaffDAO;
import com.indieus.ius.utils.UploadFileUtils;
import com.indieus.ius.vo.JobClassifiVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

public class StaffServiceImpl implements StaffService {

	@Value("${host.smtp.id}")
	private String hostSMTPid;
	@Value("${host.smtp.pwd}")
	private String hostSMTPpwd;

	@Bean
	public static PropertySourcesPlaceholderConfigurer properties() {
		PropertySourcesPlaceholderConfigurer configurer =
				new PropertySourcesPlaceholderConfigurer();
		configurer.setLocation(new ClassPathResource("message/smtp.properties"));
		return configurer;
	}

	@Inject
	private StaffDAO manager;

	@Resource(name="uploadPath")
	private String uploadPath;

	// 직무 리스트 가져오기
	@Override
	public List<JobClassifiVO> selectJobList() throws Exception {
		return manager.selectJobClassifi();
	}

	// 교직원 명단 가져오기
	@Override
	public List<StaffVO> selectStaffList() throws Exception {
		List<StaffVO> staffList = manager.selectStaffList();

		if (staffList.size() != 0) {
			for (StaffVO element : staffList) {
				String rrn1 = element.getStaff_rrn1();
				String rrn2 = element.getStaff_rrn2();

				int backNum = Integer.parseInt(rrn2.substring(0, 1));

				// 가져온 주민등록번호로 성별값 입력
				if ((backNum % 2) == 1) {
					 element.setStaff_sex("M");
				} else {
					 element.setStaff_sex("F");
				}

				// 가져온 주민등록번호로 생년월일 값 입력
				String birth = "";
				if (backNum == 3 || backNum == 4) {
					birth += "20";

				} else if (backNum == 1 || backNum == 2) {
					birth += "19";
				}

				birth += rrn1;
				element.setStaff_birth(birth);

				// 가져온 주민등록번호로 만 나이 계산
				int birthYear = Integer.parseInt(birth.substring(0, 4));
				int birthMonth = Integer.parseInt(birth.substring(4, 6));
				int birthDay = Integer.parseInt(birth.substring(6, 8));

				Calendar current = Calendar.getInstance();
				int currentYear = current.get(Calendar.YEAR);
				int currentMonth = current.get(Calendar.MONTH)+1;
				int currentDay = current.get(Calendar.DAY_OF_MONTH);

				int ageNum = currentYear-birthYear;
				if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
					ageNum--;
				}
				String age = Integer.toString(ageNum);

				element.setStaff_age(age);

			}
		}
		return staffList;
	}

	// 교직원 목록 가져오기 Ajax
	@Override
	public Object getStaffList() throws Exception {
		List<StaffVO> staffList = manager.selectStaffList();

		if (staffList.size() != 0) {
			for (StaffVO element : staffList) {
				String rrn1 = element.getStaff_rrn1();
				String rrn2 = element.getStaff_rrn2();

				int backNum = Integer.parseInt(rrn2.substring(0, 1));

				// 가져온 주민등록번호로 성별값 입력
				if ((backNum % 2) == 1) {
					 element.setStaff_sex("M");
				} else {
					 element.setStaff_sex("F");
				}

				// 가져온 주민등록번호로 생년월일 값 입력
				String birth = "";
				if (backNum == 3 || backNum == 4) {
					birth += "20";

				} else if (backNum == 1 || backNum == 2) {
					birth += "19";
				}

				birth += rrn1;
				element.setStaff_birth(birth);

				// 가져온 주민등록번호로 만 나이 계산
				int birthYear = Integer.parseInt(birth.substring(0, 4));
				int birthMonth = Integer.parseInt(birth.substring(4, 6));
				int birthDay = Integer.parseInt(birth.substring(6, 8));

				Calendar current = Calendar.getInstance();
				int currentYear = current.get(Calendar.YEAR);
				int currentMonth = current.get(Calendar.MONTH)+1;
				int currentDay = current.get(Calendar.DAY_OF_MONTH);

				int ageNum = currentYear-birthYear;
				if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
					ageNum--;
				}
				String age = Integer.toString(ageNum);

				element.setStaff_age(age);

			}
		}
		Map<String, Object> data = new HashMap();
		data.put("staffList", staffList);
		return data;

	}

	// 교직원 검색 Ajax
	@Override
	public Object searchStaffList(Map<String, Object> map) throws Exception {
		List<StaffVO> staffList = manager.searchStaffList(map);
		if (staffList.size() != 0) {
			for (StaffVO element : staffList) {
				String rrn1 = element.getStaff_rrn1();
				String rrn2 = element.getStaff_rrn2();

				int backNum = Integer.parseInt(rrn2.substring(0, 1));

				// 가져온 주민등록번호로 성별값 입력
				if ((backNum % 2) == 1) {
					 element.setStaff_sex("M");
				} else {
					 element.setStaff_sex("F");
				}

				// 가져온 주민등록번호로 생년월일 값 입력
				String birth = "";
				if (backNum == 3 || backNum == 4) {
					birth += "20";

				} else if (backNum == 1 || backNum == 2) {
					birth += "19";
				}

				birth += rrn1;
				element.setStaff_birth(birth);

				// 가져온 주민등록번호로 만 나이 계산
				int birthYear = Integer.parseInt(birth.substring(0, 4));
				int birthMonth = Integer.parseInt(birth.substring(4, 6));
				int birthDay = Integer.parseInt(birth.substring(6, 8));

				Calendar current = Calendar.getInstance();
				int currentYear = current.get(Calendar.YEAR);
				int currentMonth = current.get(Calendar.MONTH)+1;
				int currentDay = current.get(Calendar.DAY_OF_MONTH);

				int ageNum = currentYear-birthYear;
				if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
					ageNum--;
				}
				String age = Integer.toString(ageNum);

				element.setStaff_age(age);

			}
		}

		Map<String, Object> data = new HashMap();
		data.put("staffList", staffList);
		return data;
	}


	// 교직원 정보 조회 Ajax
	@Override
	public Object getStaffByStaffNum(Map<String, Object> map) throws Exception {
		String staff_num = (String) map.get("staff_num");
		String staff_cls = manager.selectStaffClsByStaffNum(staff_num);

		StaffVO staff = new StaffVO();
		staff = manager.selectStaffInfo(staff_num);


		String rrn1 = staff.getStaff_rrn1();
		String rrn2 = staff.getStaff_rrn2();

		int backNum = Integer.parseInt(rrn2.substring(0, 1));

		// 가져온 주민등록번호로 성별값 입력
		if ((backNum % 2) == 1) {
			staff.setStaff_sex("M");
		} else {
			staff.setStaff_sex("F");
		}

		// 가져온 주민등록번호로 생년월일 값 입력
		String birth = "";
		if (backNum == 3 || backNum == 4) {
			birth += "20";

		} else if (backNum == 1 || backNum == 2) {
			birth += "19";
		}

		birth += rrn1;
		staff.setStaff_birth(birth);

		// 가져온 주민등록번호로 만 나이 계산
		int birthYear = Integer.parseInt(birth.substring(0, 4));
		int birthMonth = Integer.parseInt(birth.substring(4, 6));
		int birthDay = Integer.parseInt(birth.substring(6, 8));

		Calendar current = Calendar.getInstance();
		int currentYear = current.get(Calendar.YEAR);
		int currentMonth = current.get(Calendar.MONTH)+1;
		int currentDay = current.get(Calendar.DAY_OF_MONTH);

		int ageNum = currentYear-birthYear;
		if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
			ageNum--;
		}
		String age = Integer.toString(ageNum);

		staff.setStaff_age(age);


		Map<String, Object> data = new HashMap();
		data.put("staff", staff);
		return data;
	}



	// 교직원 등록을 위한 현재 시퀀스값 가져오기
	@Override
	public int selectStaffSeq() throws Exception {
		int result = manager.selectStaffSeq();
		return result;
	}

	// 직무 분류 항목 가져오기
	@Override
	public List<JobClassifiVO> selectJobClassifi() throws Exception {
		return manager.selectJobClassifi();
	}

	// 직무 코드로 직무명 가져오기
	@Override
	public JobClassifiVO selectJobClassifiByNum(String staff_cls) throws Exception {
		return manager.selectJobClassifiByNum(staff_cls);
	}

	// 직무 목록 가져오기
	@Override
	public void getJobList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		List<JobClassifiVO> list = manager.selectJobClassifi();

		String json = "{\"jobList\":[";
		for (int i = 0; i < list.size(); i ++) {
			String staff_cls = list.get(i).getStaff_cls();
			int job_number = list.get(i).getJob_number();
			String job_Kname = list.get(i).getJob_Kname();
			String job_Ename = list.get(i).getJob_Ename();

			json += "[{\"staff_cls\":\"" + staff_cls + "\"},";
			json += "{\"job_number\":\"" + job_number + "\"},";
			json += "{\"job_Kname\":\"" + job_Kname + "\"},";
			json += "{\"job_Ename\":\"" + job_Ename + "\"}]";

			if (i != list.size() - 1) {
				json += ",";
			}

		}
		json += "]}";

		out.print(json);

	}

	// 직무 목록 추가하기
	@Override
	public void insertJobList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");

		JobClassifiVO jVo = new JobClassifiVO();

		int number = manager.selectJobNumber() + 1;
		jVo.setJob_number(number);
		jVo.setStaff_cls(request.getParameter("staff_cls"));
		jVo.setJob_Kname(request.getParameter("job_Kname"));
		jVo.setJob_Ename(request.getParameter("job_Ename"));
		manager.insertJob(jVo);

	}

	// 교직원 직무 분류 편집 - 아이디로 정보 가져오기
	@Override
	public JobClassifiVO getJobByStaffCls(String staff_cls) throws Exception {
		JobClassifiVO jVo = manager.selectJobClassifiByNum(staff_cls);
		return jVo;
	}

	// 교직원 직무 분류 편집 - 아이디로 데이터 삭제
	@Override
	public void deleteJobByStaffCls(String staff_cls, HttpServletResponse response) throws Exception {
		// 해당 항목의 데이터가 있는지 유무 확인

		int result = 0;

		result = manager.checkStaffFromStaffCls(staff_cls);
		PrintWriter out = response.getWriter();

		if (result == 0) {
			manager.deleteJobByStaffCls(staff_cls);
		}

		out.println(result);
		out.close();
	}

	// 교직원 직무 분류 편집 - 수정
	@Override
	public void updateJobList(JobClassifiVO jVo) throws Exception {
		manager.updateJobList(jVo);
	}

	// 교직원 아이디 중복 검사
	@Override
	public int idCheck(String staff_id) throws Exception  {
		return manager.idCheck(staff_id);
	}

	// 교직원 등록
	@Override
	public int insertStaff(StaffVO sVo, MultipartFile staff_picFile) throws Exception {
		MultipartFile file = staff_picFile;

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file.getSize() > 0 ) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			sVo.setStaff_picture(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		}

		String staff_id = sVo.getStaff_id();
		StaffIdVO sIvo = createTempPwd(sVo);
		manager.insertStaffId(sIvo);
		sendMail(sVo, sIvo);

		String staff_num = sVo.getStaff_num();
		int result = manager.insertStaff(sVo);

		// 담당 반 데이터 삽입.
		manager.insertStaffClassInfo(staff_num);
		return result;
	}

	// 교직원 계정 발급시 이메일 발송
	@Override
	public void sendMail(StaffVO sVo, StaffIdVO sIvo) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";

		// 보내는 사람 Email, 제목, 내용
		String fromEmail = "zz1489@naver.com";
		String fromName = "IUS Homepage";
		String subject = "";
		String msg = "";

		subject = "귀하의 IUS Homepage 계정이 등록되었습니다.";

		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += sVo.getStaff_name() + "님 계정이 등록되었습니다.";
		msg += "하단의 임시비밀번호를 확인 후 링크로 이동하여 새로운 비밀번호를 설정하세요.</h3></div><br/>";
		msg += "<p>임시 비밀번호 : ";
		msg += sIvo.getStaff_pwd() + "</p>";
		msg += "<a href='http://localhost:8085/ius/'>홈페이지로 이동</a></div>";

		String mail = sVo.getStaff_email();
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
	}

	// 교직원 계정 등록
	@Override
	public StaffIdVO createTempPwd(StaffVO sVo) throws Exception {
		// 임시 비밀번호 생성
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}

		StaffIdVO sIvo = new StaffIdVO();
		sIvo.setStaff_id(sVo.getStaff_id());
		sIvo.setStaff_pwd(pw);

		// 기본 권한 설정
		String staff_cls = sVo.getStaff_cls();
		if (staff_cls.equals("1")) { // 원장
			sIvo.setAuth_code("M");
		} else if (staff_cls.equals("2")) { // 교사
			sIvo.setAuth_code("T");
		} else if (staff_cls.equals("3")) { // 버스기사
			sIvo.setAuth_code("C");
		} else if (staff_cls.equals("4")) { // 영양사
			sIvo.setAuth_code("D");
		} else {
			sIvo.setAuth_code("C");
		}

		return sIvo;
	}


	// 교직원 정보 상세조회
	@Override
	public StaffVO selectStaffInfo(String staff_num) throws Exception {
		StaffVO sVo = manager.selectStaffInfo(staff_num);
		return sVo;
	}

	// 교직원 삭제
	@Override
	public int deleteStaff(String staff_num) throws Exception {
		// 계정 불러오기
		StaffVO sVo = manager.selectStaffInfo(staff_num);
		String staff_id = sVo.getStaff_id();

		// 학급 정보 삭제
		manager.deleteClassInfo(staff_num);
		// 교직원 정보 삭제
		int result = manager.deleteStaff(staff_num);

		manager.deleteStaffid(staff_id);
		return result;
	}

	// 교직원 정보수정
	@Override
	public int updateStaff(StaffVO sVo, MultipartFile staff_picFile) throws Exception {

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

		return manager.updateStaff(sVo);
	}

	//  로그인 되어 있는 세션 정보(아이디)로 교직원 정보 가져오기
	@Override
	public StaffVO selectStaffInfoStaffId(String staff_id) throws Exception {
		return manager.selectStaffInfoStaffId(staff_id);
	}



}
