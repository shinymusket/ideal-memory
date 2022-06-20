package com.green.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.green.dao.CoffeeDAO;
import com.green.vo.CoffeeVO;


@WebServlet("/CR")
public class CoffeeReceipt extends HttpServlet {
		ArrayList<CoffeeVO> coffeeList = new ArrayList<>();
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		String cName = request.getParameter("cName");
		String cType = request.getParameter("cType");
		int count = Integer.parseInt(request.getParameter("count"));
		
		CoffeeDAO dao = CoffeeDAO.getInstance();
		CoffeeVO cVo = new CoffeeVO();
		cVo = dao.getCoffee(cName, cType, count);
		
		coffeeList.add(cVo);
		
		HttpSession session = request.getSession();
		session.setAttribute("coffeeList", coffeeList);
		
		request.getRequestDispatcher("cafeOrder.jsp").forward(request, response);
	}

}
