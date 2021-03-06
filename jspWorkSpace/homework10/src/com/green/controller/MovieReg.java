package com.green.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.green.dao.MovieDAO;
import com.green.vo.MovieVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/MR")
public class MovieReg extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("movieRegister.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		try {
			MultipartRequest multi = new MultipartRequest (
					request,
					"c:\\upload",
					100*1024*1024,
					"UTF-8",
					new DefaultFileRenamePolicy()
					);
			
			MovieVO mVo = new MovieVO();
			mVo.setMovieName(multi.getParameter("MovieName"));
			mVo.setMovieDirector(multi.getParameter("MovieDirector"));
			mVo.setLeadingActor(multi.getParameter("LeadingActor"));
			mVo.setMoviePrice(Integer.parseInt(multi.getParameter("MoviePrice")));
			mVo.setStillCutPath(multi.getFilesystemName("StillCutPath"));
			mVo.setGrade(Double.parseDouble(multi.getParameter("grade")));
			
			MovieDAO dao = MovieDAO.getInstance();
			dao.regMovie(mVo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		response.sendRedirect("MLS");
	}

}
