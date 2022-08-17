package com.indieus.ius.db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

public class ShuttleBusDAO {

	@Autowired
	SqlSession sqlsession = null;

	public List<StaffVO> getDriverData() throws Exception {
		return sqlsession.selectList("shuttle.get_driver_data");
	}

	public StaffVO getDriverTel(String staff_num) throws Exception {
		return sqlsession.selectOne("shuttle.get_driver_tel", staff_num);
	}

	@Transactional
	public int inputBusRoute(Map<String, Object> map) throws Exception {
		return sqlsession.insert("shuttle.input_bus_route", map);
	}

	@Transactional
	public int inputBusInfo(ShuttleVO sVo) throws Exception {
		return sqlsession.insert("shuttle.input_bus_info", sVo);
	}

	public List<ShuttleVO> allShuttleInfo() throws Exception {
		return sqlsession.selectList("shuttle.all_shuttle_info");
	}

	public int selectNextShuttleSeq() throws Exception {
		return sqlsession.selectOne("shuttle.select_next_shuttle_seq");
	}

	public ShuttleVO selectRouteByShuttleId(String shuttle_num) throws Exception {
		System.out.println("DAO:" + shuttle_num);
		int s_id = Integer.parseInt(shuttle_num);
		Map<String, Object> map = new HashMap();
		map.put("shuttle_num", shuttle_num);

		return sqlsession.selectOne("shuttle.select_route_by_shuttle_id", s_id);
	}

	public List<ShuttleVO> shuttleRouteByShuttleId(String shuttle_num) throws Exception {
		int s_id = Integer.parseInt(shuttle_num);
		return sqlsession.selectList("shuttle.shuttle_route_by_shuttle_id", s_id);
	}

	public List<ShuttleVO> getRouteByShuttleId(String shuttle_num) throws Exception {
		int s_id = Integer.parseInt(shuttle_num);
		return sqlsession.selectList("shuttle.get_route_by_shuttle_id", s_id);
	}

	@Transactional
	public int routeDelete(String route_id) throws Exception {
		int r_id = Integer.parseInt(route_id);
		return sqlsession.delete("shuttle.route_delete", route_id);
	}

	public int modifyBusRoute(List<ShuttleVO> list) throws Exception {
		return sqlsession.update("shuttle.modify_bus_route", list);
	}

	public int modifyBusInfo(ShuttleVO sVo) throws Exception {
		return sqlsession.update("shuttle.modify_bus_info", sVo);
	}

	public int deleteBusInfo(String shuttle_num) {
		int s_num = Integer.parseInt(shuttle_num);
		sqlsession.delete("shuttle.delete_bus_route", s_num);
		return sqlsession.delete("shuttle.delete_bus_info", s_num);
	}



}
