package com.green.board.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.green.board.db.BoardDAO;
import com.green.member.service.Action;
import com.green.member.service.ActionForward;

public class RecCount implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO manager = BoardDAO.getInstance();
		// 게시글 총 추천수를 구함
		int count = manager.recCount(no);
		// 뷰 페이지(boardContent.jsp)에 추천수를 출력하도록 하는 역할
		out.print(count);
		out.close();
		
		return null;
	}

}
