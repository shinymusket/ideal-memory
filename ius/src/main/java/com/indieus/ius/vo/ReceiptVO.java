package com.indieus.ius.vo;

public class ReceiptVO {

	private int receipt_code;
	private String kinder_num;
	private String parent_num;
	private String receipt_date;
	private String receipt_content;
	private int receipt_price;

	private String kinder_name;
	private String relation;
	private String parent_name;

	public int getReceipt_price() {
		return receipt_price;
	}
	public void setReceipt_price(int receipt_price) {
		this.receipt_price = receipt_price;
	}


	public int getReceipt_code() {
		return receipt_code;
	}
	public void setReceipt_code(int receipt_code) {
		this.receipt_code = receipt_code;
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
	public String getReceipt_date() {
		return receipt_date;
	}
	public void setReceipt_date(String receipt_date) {
		this.receipt_date = receipt_date;
	}
	public String getReceipt_content() {
		return receipt_content;
	}
	public void setReceipt_content(String receipt_content) {
		this.receipt_content = receipt_content;
	}
	public String getKinder_name() {
		return kinder_name;
	}
	public void setKinder_name(String kinder_name) {
		this.kinder_name = kinder_name;
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


}
