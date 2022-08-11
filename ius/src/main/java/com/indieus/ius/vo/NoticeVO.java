package com.indieus.ius.vo;

public class NoticeVO {

	private int notice_num;
	private String staff_id;
	private String notice_title;
	private String notice_content;
	private String notice_writeDate;
	private int notice_readCount;

	private String staff_name;

	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getNotice_writeDate() {
		return notice_writeDate;
	}
	public void setNotice_writeDate(String notice_writeDate) {
		this.notice_writeDate = notice_writeDate;
	}
	public int getNotice_readCount() {
		return notice_readCount;
	}
	public void setNotice_readCount(int notice_readCount) {
		this.notice_readCount = notice_readCount;
	}




}
