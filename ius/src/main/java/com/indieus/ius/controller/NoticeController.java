package com.indieus.ius.controller;

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

import com.indieus.ius.service.NoticeServiceImpl;
import com.indieus.ius.service.StaffServiceImpl;
import com.indieus.ius.vo.NoticeVO;
import com.indieus.ius.vo.StaffIdVO;
import com.indieus.ius.vo.StaffVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeServiceImpl service;

	@Autowired
	private StaffServiceImpl staffService;


	// 공지사항 목록으로 이동
	@RequestMapping(value = "/notice_list", method = RequestMethod.GET)
	public String list() throws Exception {
		return "notice/noticeList";
	}

	// 전체 공지사항 게시물 불러오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_notice_list", method = RequestMethod.POST)
	public Object getNoticeList() throws Exception {
		return service.getNoticeList();
	}

	// 공지사항 등록 폼으로 이동
	@RequestMapping(value = "/notice_register_form", method = RequestMethod.GET)
	public String noticeRegisterForm(Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();
		model.addAttribute("staff_id", staff_id);
		return "notice/noticeRegister";
	}

	// 공지사항 등록
	@RequestMapping(value = "/notice_register", method = RequestMethod.POST)
	public String noticeRegister(@ModelAttribute NoticeVO nVo, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.noticeRegister(nVo));
		return "redirect:./notice_list";
	}

	// 공지사항 조회(상세보기)
	@RequestMapping(value = "/notice_info", method = RequestMethod.GET)
	public String noticeInfo(@RequestParam int notice_num, Model model, HttpSession session) throws Exception {
		StaffIdVO staff = (StaffIdVO) session.getAttribute("staff");
		String staff_id = staff.getStaff_id();
		StaffVO staffInfo = staffService.selectStaffInfoStaffId(staff_id);

		NoticeVO noticeInfo = service.noticeInfo(notice_num);
		model.addAttribute("noticeInfo", noticeInfo);
		model.addAttribute("staffInfo", staffInfo);
		return "notice/noticeInfo";
	}

	// 공지사항 게시글 삭제
	@RequestMapping(value = "/delete_notice", method = RequestMethod.GET)
	public String deleteNotice(@RequestParam int notice_num, RedirectAttributes rttr) throws Exception {
		rttr.addFlashAttribute("result", service.deleteNotice(notice_num));
		return "redirect:./notice_list";
	}

	// 공지사항 글 수정 폼 이동
	@RequestMapping(value = "/update_notice_form", method = RequestMethod.GET)
	public String updateNoticeForm(@RequestParam int notice_num, Model model) throws Exception {
		NoticeVO noticeInfo = service.noticeInfo(notice_num);
		model.addAttribute("noticeInfo", noticeInfo);
		return "notice/updateNotice";
	}

	// 공지사항 글 수정
	@RequestMapping(value = "/notice_update", method = RequestMethod.POST)
	public String updateNotice(@ModelAttribute NoticeVO nVo) throws Exception {
		int result = service.updateNotice(nVo);
		return "redirect:./notice_list";
	}

	// 공지사항 글 검색 Ajax
	@ResponseBody
	@RequestMapping(value = "/search_notice_list", method = RequestMethod.POST)
	public Object searchNoticeList(@RequestParam Map<String, Object> map) throws Exception {
		return service.searchNoticeList(map);
	}

	// 공지사항 글별 댓글 리스트 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_reply_list", method = RequestMethod.POST)
	public Object getReplyList(@RequestParam Map<String, Object> map) throws Exception {
		return service.getReplyList(map);
	}

	// 댓글 등록하기 Ajax
	@ResponseBody
	@RequestMapping(value = "/add_reply", method = RequestMethod.POST)
	public void addReply(@RequestParam Map<String, Object> map) throws Exception {
		service.addReply(map);
	}

	// 댓글 수정이나 삭제를 위해 뷰로 가져오기 Ajax
	@ResponseBody
	@RequestMapping(value = "/get_reply_Info", method = RequestMethod.POST)
	public Object getReplyInfo(@RequestParam Map<String, Object> map) throws Exception {
		return service.getReplyInfo(map);
	}

	// 댓글 수정 Ajax
	@ResponseBody
	@RequestMapping(value = "/update_reply", method = RequestMethod.POST)
	public void updateReply(@RequestParam Map<String, Object> map) throws Exception {
		service.updateReply(map);
	}

	// 댓글 삭제 Ajax
	@ResponseBody
	@RequestMapping(value = "/delete_reply", method = RequestMethod.POST)
	public void deleteReply(@RequestParam Map<String, Object> map) throws Exception {
		service.deleteReply(map);
	}


}
