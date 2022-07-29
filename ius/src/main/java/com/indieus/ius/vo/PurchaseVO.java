package com.indieus.ius.vo;

public class PurchaseVO {
	private String purchase_num;
	private String finance_num;
	private String staff_num;
	private String equipment_num;
	private String purchase_date;
	private int purchase_price;
	private int purchase_count;

	private String equip_cls_num;
	private String equipment_name;
	private String staff_name;
	private String finance_cls;





	public String getFinance_cls() {
		return finance_cls;
	}
	public void setFinance_cls(String finance_cls) {
		this.finance_cls = finance_cls;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getEquipment_name() {
		return equipment_name;
	}
	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}
	public String getEquip_cls_num() {
		return equip_cls_num;
	}
	public void setEquip_cls_num(String equip_cls_num) {
		this.equip_cls_num = equip_cls_num;
	}
	public String getPurchase_num() {
		return purchase_num;
	}
	public void setPurchase_num(String purchase_num) {
		this.purchase_num = purchase_num;
	}
	public String getFinance_num() {
		return finance_num;
	}
	public void setFinance_num(String finance_num) {
		this.finance_num = finance_num;
	}
	public String getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(String staff_num) {
		this.staff_num = staff_num;
	}
	public String getEquipment_num() {
		return equipment_num;
	}
	public void setEquipment_num(String equipment_num) {
		this.equipment_num = equipment_num;
	}
	public String getPurchase_date() {
		return purchase_date;
	}
	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
	}
	public int getPurchase_price() {
		return purchase_price;
	}
	public void setPurchase_price(int purchase_price) {
		this.purchase_price = purchase_price;
	}
	public int getPurchase_count() {
		return purchase_count;
	}
	public void setPurchase_count(int purchase_count) {
		this.purchase_count = purchase_count;
	}


}
