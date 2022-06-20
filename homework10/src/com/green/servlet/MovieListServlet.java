package com.green.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.green.dao.MovieDAO;
import com.green.vo.MovieVO;


@WebServlet("/MLS")
public class MovieListServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		MovieDAO dao = MovieDAO.getInstance();
		
		ArrayList<MovieVO> movieList = dao.getMoiveList();
		
		session.setAttribute("movieList", movieList);
		request.getRequestDispatcher("movieList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
