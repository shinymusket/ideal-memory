package com.green.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.green.vo.MemberVO;

/**
 * Servlet implementation class RegisterScore
 */
@WebServlet("/RS")
public class RegisterScore extends HttpServlet {
	ArrayList<MemberVO> StudentScoreList = new ArrayList<>();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		int korScore = Integer.parseInt(request.getParameter("korScore"));
		int engScore = Integer.parseInt(request.getParameter("engScore"));
		int mathScore = Integer.parseInt(request.getParameter("mathScore"));
		
		MemberVO mVo = new MemberVO();
		
		mVo.setName(name);
		mVo.setKorScore(korScore);
		mVo.setEngScore(engScore);
		mVo.setMathScore(mathScore);
		
		
		int rank = 1;
		
		if (StudentScoreList.size() == 0) {
			rank = 1;
		} else {
			for (int i = 0; i < StudentScoreList.size(); i++ ) {
				if (StudentScoreList.get(i) != null) {
						if (mVo.getSumScore() < StudentScoreList.get(i).getSumScore()) {
						    rank++;
						} else if (mVo.getSumScore() > StudentScoreList.get(i).getSumScore()) {
							StudentScoreList.get(i).setRank(StudentScoreList.get(i).getRank() + 1); 
						}
					}
				}
				
			}
		
		
		
		mVo.setRank(rank);
		
		
		StudentScoreList.add(mVo);
		
		session.setAttribute("StudentScoreList", StudentScoreList);
		request.getRequestDispatcher("studentScoreList.jsp").forward(request, response);
	}

}
