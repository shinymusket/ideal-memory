package com.indieus.ius.service;

import javax.servlet.http.HttpServletResponse;

import com.indieus.ius.vo.StaffIdVO;

public interface StaffIdService {

	public StaffIdVO login(StaffIdVO staff, HttpServletResponse response) throws Exception;

	public void logout(HttpServletResponse response) throws Exception;
}
