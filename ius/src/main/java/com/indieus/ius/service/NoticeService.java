package com.indieus.ius.service;

import java.util.Map;

import com.indieus.ius.vo.NoticeVO;

public interface NoticeService {

	public Object getNoticeList() throws Exception;

	public int noticeRegister(NoticeVO nVo) throws Exception;

	public NoticeVO noticeInfo(int notice_num) throws Exception;

	public int deleteNotice(int notice_num) throws Exception;

	public int updateNotice(NoticeVO nVo) throws Exception;

	public Object searchNoticeList(Map<String, Object> map) throws Exception;

	public Object getReplyList(Map<String, Object> map) throws Exception;

	public void addReply(Map<String, Object> map) throws Exception;

	public Object getReplyInfo(Map<String, Object> map) throws Exception;

	public void updateReply(Map<String, Object> map) throws Exception;

	public void deleteReply(Map<String, Object> map) throws Exception;


}
