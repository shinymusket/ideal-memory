package com.green.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.green.product.dao.ProductDAO;
import com.green.product.vo.ProductVO;


@WebServlet("/productList")
public class ProductListServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO dao = ProductDAO.getInstance();
		List<ProductVO> list = dao.selectAllProduct();
		
		request.setAttribute("productList", list);
		
		request.getRequestDispatcher("product/productList.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
