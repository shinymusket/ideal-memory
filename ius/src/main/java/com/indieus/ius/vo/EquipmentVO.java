package com.indieus.ius.vo;

public class EquipmentVO {

	private String equipment_num;
	private String staff_id;
	private String equip_cls_num;
	private String equipment_name;
	private int equipment_count;
	private String equipment_regdate;

	private String equipment_cate;


	private String staff_name;
	private String equip_cls_name;



	public String getEquipment_cate() {
		return equipment_cate;
	}
	public void setEquipment_cate(String equipment_cate) {
		this.equipment_cate = equipment_cate;
	}
	public String getEquip_cls_name() {
		return equip_cls_name;
	}
	public void setEquip_cls_name(String equip_cls_name) {
		this.equip_cls_name = equip_cls_name;
	}

	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getEquipment_num() {
		return equipment_num;
	}
	public void setEquipment_num(String equipment_num) {
		this.equipment_num = equipment_num;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public String getEquip_cls_num() {
		return equip_cls_num;
	}
	public void setEquip_cls_num(String equip_cls_num) {
		this.equip_cls_num = equip_cls_num;
	}
	public String getEquipment_name() {
		return equipment_name;
	}
	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}
	public int getEquipment_count() {
		return equipment_count;
	}
	public void setEquipment_count(int equipment_count) {
		this.equipment_count = equipment_count;
	}

	public String getEquipment_regdate() {
		return equipment_regdate;
	}
	public void setEquipment_regdate(String equipment_regdate) {
		this.equipment_regdate = equipment_regdate;
	}

}
