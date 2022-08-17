package com.indieus.ius.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.indieus.ius.service.ShuttleBusServiceImpl;
import com.indieus.ius.vo.ShuttleVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/bus")
public class ShuttleBusController {

	@Autowired
	private ShuttleBusServiceImpl service;

	@RequestMapping(value = "/shuttle_bus", method = RequestMethod.GET)
	public String shuttleBus(Model model) throws Exception {
		List<ShuttleVO> list = service.allShuttleInfo();
		model.addAttribute("busList", list);
		return "/bus/shuttleList";
	}

	@RequestMapping(value = "/shuttle_bus_reg")
	public String shuttleBusRegister(Model model) throws Exception {
		List<StaffVO> list = service.getDriverData();
		int nextShuttleSeq = service.selectNextShuttleSeq();
		System.out.println(nextShuttleSeq);
		model.addAttribute("nextShuttleSeq", nextShuttleSeq);
		model.addAttribute("driverList", list);
		return "/bus/shuttleBusRegisterForm";
	}

	@ResponseBody
	@RequestMapping(value ="/get_driver_tel", method = RequestMethod.POST)
	public Object getDriverTell(@RequestParam("staff_num") String staff_num) throws Exception {
		return service.getDriverTel(staff_num);
	}

	@RequestMapping(value = "/input_bus_route", method = RequestMethod.POST)
	public String inputBusRoute(HttpServletRequest request) throws Exception {
		service.inputBusInfo(request);
		service.inputBusRoute(request);
		return "redirect:./shuttle_bus";
	}

	@RequestMapping(value = "/modify_route", method = RequestMethod.GET)
	public String selectRouteByShuttleId(@RequestParam String shuttle_num, Model model) throws Exception {
		ShuttleVO shuttleInfo = service.selectRouteByShuttleId(shuttle_num);
		List<ShuttleVO> shuttleRoute = service.shuttleRouteByShuttleId(shuttle_num);
		List<StaffVO> list = service.getDriverData();
		model.addAttribute("bus", shuttleInfo);
		model.addAttribute("route", shuttleRoute);
		model.addAttribute("driverList", list);
		return "/bus/routeInfo";
	}

	@ResponseBody
	@RequestMapping(value = "/get_route_by_shuttle_id", method = RequestMethod.POST)
	public Object getRouteByShuttleId(@RequestParam("shuttle_num") String shuttle_num) throws Exception {
		return service.getRouteByShuttleId(shuttle_num);
	}

	@ResponseBody
	@RequestMapping(value = "/route_delete")
	public void routeDelete(@RequestParam("route_id") String route_id) throws Exception {
		service.routeDelete(route_id);
	}

	@RequestMapping(value = "/modify_bus_route", method = RequestMethod.POST)
	public String modifyBusRoute(HttpServletRequest request) throws Exception {
		String[] bus_stop = request.getParameterValues("bus_stop[]");
		if(bus_stop == null) {
			return "redirect:./shuttle_bus";
		} else {
		service.modifyBusInfo(request);
		service.modifyBusRoute(request);
		return "redirect:./shuttle_bus";
		}
	}

	@RequestMapping(value = "/delete_bus_info")
	public String deleteBusInfo(@RequestParam String shuttle_num) throws Exception {
		service.deleteBusInfo(shuttle_num);
		return "redirect:./shuttle_bus";
	}
}
