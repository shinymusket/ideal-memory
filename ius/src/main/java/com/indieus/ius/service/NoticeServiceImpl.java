package com.indieus.ius.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.indieus.ius.db.NoticeDAO;
import com.indieus.ius.vo.NoticeReplyVO;
import com.indieus.ius.vo.NoticeVO;

public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO manager;

	// 전체 공지사항 게시물 불러오기 Ajax
	@Override
	public Object getNoticeList() throws Exception {
		List<NoticeVO> noticeList = manager.getNoticeList();
		Map<String, Object> data = new HashMap();
		data.put("noticeList", noticeList);
		return data;
	}

	// 공지사항 등록
	@Override
	public int noticeRegister(NoticeVO nVo) throws Exception {
		return manager.noticeRegister(nVo);
	}

	// 공지사항 조회(상세보기)
	@Override
	public NoticeVO noticeInfo(int notice_num) throws Exception {
		// 글 조회수 증가
		manager.addReadCount(notice_num);
		return manager.noticeInfo(notice_num);
	}

	// 공지사항 글 삭제
	@Override
	public int deleteNotice(int notice_num) throws Exception {
		return manager.deleteNotice(notice_num);
	}

	// 공지사항 글 수정
	@Override
	public int updateNotice(NoticeVO nVo) throws Exception {
		return manager.updateNotice(nVo);
	}

	// 공지사항 글 검색 Ajax
	@Override
	public Object searchNoticeList(Map<String, Object> map) throws Exception {
		List<NoticeVO> noticeList = manager.searchNoticeList(map);
		Map<String, Object> data = new HashMap();
		data.put("noticeList", noticeList);
		return data;
	}

	// 공지사항 글별 댓글 리스트 가져오기 Ajax
	@Override
	public Object getReplyList(Map<String, Object> map) throws Exception {
		List<NoticeReplyVO> replyList = manager.getReplyList(map);
		Map<String, Object> data = new HashMap();
		data.put("replyList", replyList);
		return data;
	}

	// 댓글 등록하기 Ajax
	@Override
	public void addReply(Map<String, Object> map) throws Exception {
		manager.addReply(map);

	}

	// 댓글 수정이나 삭제를 위해 뷰로 가져오기 Ajax
	@Override
	public Object getReplyInfo(Map<String, Object> map) throws Exception {
		NoticeReplyVO replyInfo = manager.getReplyInfo(map);
		Map<String, Object> data = new HashMap();
		data.put("replyInfo", replyInfo);
		return data;
	}

	// 댓글 수정 Ajax
	@Override
	public void updateReply(Map<String, Object> map) throws Exception {
		manager.updateReply(map);

	}

	// 댓글 삭제 Ajax
	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		manager.deleteReply(map);

	}


}
