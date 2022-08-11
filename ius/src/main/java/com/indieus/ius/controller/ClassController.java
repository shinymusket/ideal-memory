package com.indieus.ius.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.indieus.ius.service.ClassServiceImpl;
import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/class")
public class ClassController {

	@Autowired
	private ClassServiceImpl service;


	// 학급 관리 화면으로 이동
	@RequestMapping(value = "/class_list", method = RequestMethod.GET)
	public String List() throws Exception {
		return "class/classList";
	}

	// 전체 학급 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_class_list", method = RequestMethod.POST)
	public Object getClassList() throws Exception {
		return service.getClassList();
	}

	// 학급 정보 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_class_by_class_num", method = RequestMethod.POST)
	public Object getClassByClassNum(@RequestParam Map<String, Object> map) throws Exception  {
		return service.getClassByClassNum(map);
	}

	// 학급 등록 폼으로 이동
	@RequestMapping(value = "/class_register_form", method = RequestMethod.GET)
	public String classRegisterForm(Model model) throws Exception {
		int classNumber;
		try {
			classNumber = service.selectClassLastNumber() + 1;
		} catch(NullPointerException e) {
			classNumber = 1;
		}


		List<StaffVO> homeTeacherList = service.selectClassHomeTeacher();

		model.addAttribute("classNumber", classNumber);
		model.addAttribute("homeTeacherList", homeTeacherList);

		return "class/classRegisterForm";
	}

	// 학급 등록
	@RequestMapping(value = "/class_register", method = RequestMethod.POST)
	public String classRegister(@ModelAttribute ClassVO cVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.updateClass(cVo));
		return "redirect:./class_list";
	}

	// 학급 정보 수정을 위한 담임교사 명단 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_home_teacher_list", method = RequestMethod.POST)
	public Object getHomeTeacherList() throws Exception {
		return service.getHomeTeacherList();
	}

	// 학급 정보 수정 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_class_info", method = RequestMethod.POST)
	public void updateClassInfo(@RequestParam Map<String, Object> map) throws Exception {
		service.updateClassInfo(map);
	}

	// 학급 정보 삭제 Ajax (삭제시 학급 번호(시퀀스X)와 학급 이름만 삭제)
	@ResponseBody
	@RequestMapping(value = "/delete_class_info", method = RequestMethod.POST)
	public void deleteClassInfo(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteClassInfo(map);
	}


}
