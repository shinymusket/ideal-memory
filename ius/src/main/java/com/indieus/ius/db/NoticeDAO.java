package com.indieus.ius.db;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.indieus.ius.vo.NoticeReplyVO;
import com.indieus.ius.vo.NoticeVO;

public class NoticeDAO {

	@Autowired
	private SqlSession sqlsession;


	// 전체 공지사항 게시물 불러오기
	public List<NoticeVO> getNoticeList() throws Exception {
		return sqlsession.selectList("notice.select_all_notice_list");
	}

	// 공지사항 등록
	@Transactional
	public int noticeRegister(NoticeVO nVo) throws Exception {
		return sqlsession.insert("notice.insert_notice", nVo);
	}

	// 글 조회수 증가
	@Transactional
	public void addReadCount(int notice_num) throws Exception {
		sqlsession.insert("notice.update_read_count", notice_num);

	}

	// 공지사항 조회
	public NoticeVO noticeInfo(int notice_num) throws Exception {
		return sqlsession.selectOne("notice.select_notice_info", notice_num);
	}

	// 공지사항 게시글 삭제
	@Transactional
	public int deleteNotice(int notice_num) throws Exception {
		return sqlsession.delete("notice.delete_notice", notice_num);
	}

	// 공지사항 글 수정
	@Transactional
	public int updateNotice(NoticeVO nVo) throws Exception {
		return sqlsession.update("notice.update_notice", nVo);
	}

	// 공지사항 글 검색
	public List<NoticeVO> searchNoticeList(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("notice.search_notice_list", map);
	}

	// 공지사항 글별 댓글 리스트 가져오기
	public List<NoticeReplyVO> getReplyList(Map<String, Object> map) throws Exception {
		return sqlsession.selectList("notice.select_reply_list_for_notice", map);
	}

	// 댓글 등록하기
	@Transactional
	public void addReply(Map<String, Object> map) throws Exception {
		sqlsession.insert("notice.insert_reply", map);

	}

	// 댓글 수정이나 삭제를 위해 뷰로 가져오기
	public NoticeReplyVO getReplyInfo(Map<String, Object> map) throws Exception {
		return sqlsession.selectOne("notice.select_reply_info", map);
	}

	// 댓글 수정
	@Transactional
	public void updateReply(Map<String, Object> map) throws Exception {
		sqlsession.update("notice.update_reply", map);

	}

	// 댓글 삭제
	@Transactional
	public void deleteReply(Map<String, Object> map) throws Exception{
		sqlsession.delete("notice.delete_reply", map);
	}

	// 메인에 게시하기 위한 최신 공지글 8개 가져오기
	public List<NoticeVO> getNoticeListForMain() throws Exception {
		return sqlsession.selectList("notice.select_notice_list_for_main");
	}



}
