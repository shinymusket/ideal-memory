package com.indieus.ius.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import com.indieus.ius.db.ShuttleBusDAO;
import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

public class ShuttleBusServiceImpl implements ShuttleBusService {

	@Inject
	private ShuttleBusDAO manager;

	@Override
	public List<StaffVO> getDriverData() throws Exception {
		List<StaffVO> list = null;

		try {
			list = manager.getDriverData();
		}catch(Exception e) {
			e.printStackTrace();
		}

		return list;
	}

//	기사 연락처 불러오기
	@Override
	public Object getDriverTel(String staff_num) throws Exception {
		StaffVO sVo = manager.getDriverTel(staff_num);
		String staff_tel = sVo.getStaff_tel();

		System.out.println(staff_tel);
		Map<String, Object> data = new HashMap();
		data.put("staff_tel", staff_tel);

		return data;
	}


// 버스 정보 등록
	@Override
	public int inputBusInfo(HttpServletRequest request) throws Exception {
		String shuttle_name = request.getParameter("shuttle_name");
		String staff_num = request.getParameter("staff_num");
		String shuttle_carnum = request.getParameter("shuttle_carnum");

		ShuttleVO sVo = new ShuttleVO();
		sVo.setShuttle_name(shuttle_name);
		sVo.setStaff_num(staff_num);
		sVo.setShuttle_carnum(shuttle_carnum);

		return manager.inputBusInfo(sVo);
	}

	@Override
	public int inputBusRoute(HttpServletRequest request) throws Exception {
		String shuttle_num = request.getParameter("shuttle_num");
		String shuttle_carnum = request.getParameter("shuttle_carnum");
		String staff_num = request.getParameter("staff_num");
		String[] shuttle_hour = request.getParameterValues("shuttle_hour[]");
		String[] shuttle_minute = request.getParameterValues("shuttle_minute[]");
		String[] bus_stop = request.getParameterValues("bus_stop[]");

		List<ShuttleVO> list = new ArrayList<>();
		for(int i=0; i < shuttle_hour.length; i++) {
			ShuttleVO sVo = new ShuttleVO();

			sVo.setShuttle_num(shuttle_num);
			sVo.setShuttle_carnum(shuttle_carnum);
			sVo.setStaff_num(staff_num);
			sVo.setShuttle_hour(shuttle_hour[i]);
			sVo.setShuttle_minute(shuttle_minute[i]);
			sVo.setBus_stop(bus_stop[i]);

			list.add(sVo);
		}

		Map<String, Object> map = new HashMap();
		map.put("list", list);

		return manager.inputBusRoute(map);

	}

	@Override
	public List<ShuttleVO> allShuttleInfo() throws Exception {
		List<ShuttleVO> list = null;

		try {
			list = manager.allShuttleInfo();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int selectNextShuttleSeq() throws Exception {
		return manager.selectNextShuttleSeq();
	}

	@Override
	public ShuttleVO selectRouteByShuttleId(String shuttle_num) throws Exception {
		System.out.println("서비스:"+shuttle_num);
		ShuttleVO sVo = manager.selectRouteByShuttleId(shuttle_num);
		return sVo;
	}

	@Override
	public List<ShuttleVO> shuttleRouteByShuttleId(String shuttle_num) throws Exception {

		List<ShuttleVO> list = null;
		try {
			list = manager.shuttleRouteByShuttleId(shuttle_num);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Object getRouteByShuttleId(String shuttle_num) throws Exception {
		List<ShuttleVO> sVo = manager.getRouteByShuttleId(shuttle_num);
		Map<String, Object> data = new HashMap();
		data.put("route", sVo);

		return data;
	}

	@Override
	public void routeDelete(@RequestParam String route_id) throws Exception {
		manager.routeDelete(route_id);
	}

	@Override
	public int modifyBusRoute(HttpServletRequest request) throws Exception {
		String[] route_id = request.getParameterValues("route_id[]");
		String shuttle_num = request.getParameter("shuttle_num");
		String[] shuttle_hour = request.getParameterValues("shuttle_hour[]");
		String[] shuttle_minute = request.getParameterValues("shuttle_minute[]");
		String[] bus_stop = request.getParameterValues("bus_stop[]");

		List<ShuttleVO> list = new ArrayList<>();

		for(int i=0; i < bus_stop.length; i++) {
			ShuttleVO sVo = new ShuttleVO();

			sVo.setRoute_id(route_id[i]);
			sVo.setShuttle_num(shuttle_num);
			sVo.setShuttle_hour(shuttle_hour[i]);
			sVo.setShuttle_minute(shuttle_minute[i]);
			sVo.setBus_stop(bus_stop[i]);

			list.add(sVo);
		}

		return manager.modifyBusRoute(list);
	}

	@Override
	public int modifyBusInfo(HttpServletRequest request) throws Exception {
		String shuttle_num = request.getParameter("shuttle_num");
		String shuttle_name = request.getParameter("shuttle_name");
		String staff_num = request.getParameter("staff_num");
		String shuttle_carnum = request.getParameter("shuttle_carnum");

		ShuttleVO sVo = new ShuttleVO();
		sVo.setShuttle_num(shuttle_num);
		sVo.setShuttle_name(shuttle_name);
		sVo.setStaff_num(staff_num);
		sVo.setShuttle_carnum(shuttle_carnum);

		return manager.modifyBusInfo(sVo);

	}

	@Override
	public int deleteBusInfo(String shuttle_num) throws Exception {
		System.out.println(shuttle_num);
		return manager.deleteBusInfo(shuttle_num);
	}


}
