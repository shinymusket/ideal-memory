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

import com.indieus.ius.service.ParentServiceImpl;
import com.indieus.ius.vo.ClassVO;
import com.indieus.ius.vo.ParentVO;

@Controller
@RequestMapping("/parent")
public class ParentController {

	@Autowired
	private ParentServiceImpl service;

	// 학부모 관리 홈페이지로 이동
	@RequestMapping(value = "/parent_list", method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<ClassVO> classList = service.selectAllClassNumName();

		model.addAttribute("classList", classList);
		return "parent/parentList";
	}

	// 원생 명단(학부모 성명 포함된) 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_kinder_list", method = RequestMethod.POST)
	public Object getKinderList() throws Exception {
		return service.getKinderList();
	}

	// 학급 별 원생 명단 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_kinder_list_by_class", method = RequestMethod.POST)
	public Object searchKinderListByClass(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchKinderListByClass(map);
	}

	// 학부모 정보 입력 폼으로 이동
	@RequestMapping(value = "/parent_register_form", method = RequestMethod.GET)
	public String parentRegister() throws Exception {
		return "parent/parentRegisterForm";
	}

	// 학부모 정보 입력 중 원생 조회 홈페이지
	@RequestMapping(value = "/select_kinder", method = RequestMethod.GET)
	public String selectKinder() throws Exception {
		return "parent/selectKinder";
	}

	// 원생 검색 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_kinder", method = RequestMethod.POST)
	public Object searchKinder(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchKinder(map);
	}

	// 원생 정보 입력시 부모님 데이터가 이미 있는지 조사 Ajax
	@ResponseBody
	@RequestMapping(value = "/check_kinder_parent", method = RequestMethod.POST)
	public Object checkKinderParent(@RequestParam Map<String, Object> map) throws Exception {
		return service.checkKinderParent(map);
	}

	// 학부모 정보 등록
	@RequestMapping(value = "/parent_register", method = RequestMethod.POST)
	public String parentRegister(@ModelAttribute ParentVO pVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.insertParent(pVo));
		return "redirect:./parent_list";
	}

	// 원생 별 학부모 정보 조회 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_kinder_parent_info", method = RequestMethod.POST)
	public Object getKinderParentInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getKinderParentInfo(map);
	}

	// 학부모 정보 삭제 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_parent_info", method = RequestMethod.POST)
	public void deleteParentInfo(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteParentInfo(map);
	}

	// 학부모 정보 수정 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_parent_info", method = RequestMethod.POST)
	public void UpdateParentInfo(@RequestParam Map<String, Object> map) throws Exception {
		service.updateParentInfo(map);
	}



}
