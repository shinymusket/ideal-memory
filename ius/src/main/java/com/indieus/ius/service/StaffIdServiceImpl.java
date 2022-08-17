package com.indieus.ius.service;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import com.indieus.ius.db.StaffIdDAO;
import com.indieus.ius.vo.StaffIdVO;

public class StaffIdServiceImpl implements StaffIdService {

	@Inject
	private StaffIdDAO manager;

	// 로그인
	@Override
	public StaffIdVO login(StaffIdVO staff, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		String staff_id = staff.getStaff_id();
		if(manager.check_id(staff_id) == 0) {
			out.println("<script>");
			out.println("alert('등록된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else if (manager.checkValidId(staff_id).equalsIgnoreCase("Y")) { // 삭제처리된 계정일 경우
			out.println("<script>");
			out.println("alert('사용할 수 없는 계정 입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
				String pw = staff.getStaff_pwd();
				staff = manager.login(staff.getStaff_id());

				if(!staff.getStaff_pwd().equals(pw)) {
					out.println("<script>");
					out.println("alert('비밀번호가 다릅니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					out.close();
					return null;
				} else {
					manager.update_log(staff.getStaff_id());
					return staff;
				}
			}


		}


	// 로그아웃
	@Override
	public void logout(HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='../'");
		out.println("</script>");
		out.close();
	}

}
