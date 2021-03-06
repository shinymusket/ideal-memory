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

import com.green.vo.CoffeeVO;

@WebServlet("/CL")
public class CleanList extends HttpServlet {
		ArrayList<CoffeeVO> coffeeList = new ArrayList<>();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("coffeeList", coffeeList);
		request.getRequestDispatcher("cafeOrder.jsp").forward(request, response);
	}

}
