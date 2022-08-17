package com.indieus.ius.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

public interface ShuttleBusService {

	public List<StaffVO> getDriverData() throws Exception;

	public Object getDriverTel(String staff_num) throws Exception;

	public int inputBusRoute(HttpServletRequest request) throws Exception;

	int inputBusInfo(HttpServletRequest request) throws Exception;

	List<ShuttleVO> allShuttleInfo() throws Exception;

	int selectNextShuttleSeq() throws Exception;

	ShuttleVO selectRouteByShuttleId(String shuttle_num) throws Exception;

	List<ShuttleVO> shuttleRouteByShuttleId(String shuttle_num) throws Exception;

	public Object getRouteByShuttleId(String shuttle_num) throws Exception;

	void routeDelete(String route_id) throws Exception;

	int modifyBusRoute(HttpServletRequest request) throws Exception;

	int modifyBusInfo(HttpServletRequest request) throws Exception;

	int deleteBusInfo(String shuttle_num) throws Exception;

}