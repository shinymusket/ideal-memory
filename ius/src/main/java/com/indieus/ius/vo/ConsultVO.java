package com.indieus.ius.vo;


public class ConsultVO {
	private int consult_code;
	private String kinder_num;
	private String parent_num;
	private String staff_num;
	private String consult_date;
	private String consult_content;

	private String staff_name;
	private String relation;
	private String parent_name;
	private String kinder_name;

	public String getKinder_name() {
		return kinder_name;
	}
	public void setKinder_name(String kinder_name) {
		this.kinder_name = kinder_name;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getParent_name() {
		return parent_name;
	}
	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}
	public int getConsult_code() {
		return consult_code;
	}
	public void setConsult_code(int consult_code) {
		this.consult_code = consult_code;
	}
	public String getKinder_num() {
		return kinder_num;
	}
	public void setKinder_num(String kinder_num) {
		this.kinder_num = kinder_num;
	}
	public String getParent_num() {
		return parent_num;
	}
	public void setParent_num(String parent_num) {
		this.parent_num = parent_num;
	}
	public String getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(String staff_num) {
		this.staff_num = staff_num;
	}
	public String getConsult_date() {
		return consult_date;
	}
	public void setConsult_date(String consult_date) {
		this.consult_date = consult_date;
	}
	public String getConsult_content() {
		return consult_content;
	}
	public void setConsult_content(String consult_content) {
		this.consult_content = consult_content;
	}


}
