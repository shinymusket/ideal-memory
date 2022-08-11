package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.EventServiceImpl;
import com.indieus.ius.vo.EventVO;
import com.indieus.ius.vo.StaffIdVO;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventServiceImpl service;

	// 행사 및 일정 리스트로 이동
	@RequestMapping(value = "/event_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<EventVO> eventList = service.getAllEventList();

		model.addAttribute("eventList", eventList);
		return "event/eventList";
	}

	// 행사 및 일정 등록 폼 이동
	@RequestMapping(value = "/addEvent", method = RequestMethod.GET)
	public String addEvent(Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();

		model.addAttribute("staff_id", staff_id);
		return "event/addEventForm";
	}

	// 행사 및 일정 등록
	@RequestMapping(value = "/event_register", method = RequestMethod.POST)
	public String eventRegister(@ModelAttribute EventVO eVo, RedirectAttributes rttr) throws Exception {
		int result = service.eventRegister(eVo);

		return "redirect:./event_list";
	}

	// 행사 및 일정 조회(상세보기) 이동
	@RequestMapping(value = "/event_select_by_event_date", method = RequestMethod.GET)
	public String eventSelectByEventDate(@RequestParam (value = "event_date", required = false )String event_date, Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();

		model.addAttribute("staff_id", staff_id);
		model.addAttribute("event_date", event_date);
		return "event/eventInfo";
	}

	// 날짜별 행사 및 일정 정보 받아오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_event_Info", method = RequestMethod.POST)
	public Object getEventInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getEventInfo(map);
	}


	// 행사 번호로 행사명 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_event_name_by_num", method = RequestMethod.POST)
	public Object getEventNameByNum(@RequestParam Map<String, Object> map) throws Exception {
		return service.getEventNameByNum(map);
	}

	// 행사 번호로 행사 삭제하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_event_by_num", method = RequestMethod.POST)
	public void deleteEventByNum(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteEventByNum(map);
	}

	// 행사명 수정하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_event_by_num", method = RequestMethod.POST)
	public void updateEventByNum(@RequestParam Map<String, Object> map) throws Exception {
		service.updateEventByNum(map);
	}

	// 행사명 추가하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/register_event", method = RequestMethod.POST)
	public void registerEvent(@RequestParam Map<String, Object> map) throws Exception {
		service.registerEvent(map);
	}
}
