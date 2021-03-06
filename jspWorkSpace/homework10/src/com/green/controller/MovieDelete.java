package com.green.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.green.dao.MovieDAO;

/**
 * Servlet implementation class MovieDelete
 */
@WebServlet("/MD")
public class MovieDelete extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String movieCode = request.getParameter("movieCode");
		MovieDAO dao = MovieDAO.getInstance();
		dao.deleteMovie(movieCode);
		
		response.sendRedirect("MLS");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
