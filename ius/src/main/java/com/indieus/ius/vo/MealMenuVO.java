package com.indieus.ius.vo;

import java.util.Date;

public class MealMenuVO {

	private String menu_num;
	private int staff_num;
	private String meal_code;
	private String meal_menu;
	private String menu_edate;
	private int menu_calorie;
	private String allergy_num;
	private Date menu_wdate;

	private String allergy_Yn;


	public String getAllergy_Yn() {
		return allergy_Yn;
	}
	public void setAllergy_Yn(String allergy_Yn) {
		this.allergy_Yn = allergy_Yn;
	}
	public String getMenu_num() {
		return menu_num;
	}
	public void setMenu_num(String menu_num) {
		this.menu_num = menu_num;
	}
	public int getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(int staff_num) {
		this.staff_num = staff_num;
	}
	public String getMeal_code() {
		return meal_code;
	}
	public void setMeal_code(String meal_code) {
		this.meal_code = meal_code;
	}
	public String getMeal_menu() {
		return meal_menu;
	}
	public void setMeal_menu(String meal_menu) {
		this.meal_menu = meal_menu;
	}
	public String getMenu_edate() {
		return menu_edate;
	}
	public void setMenu_edate(String menu_edate) {
		this.menu_edate = menu_edate;
	}
	public int getMenu_calorie() {
		return menu_calorie;
	}
	public void setMenu_calorie(int menu_calorie) {
		this.menu_calorie = menu_calorie;
	}
	public String getAllergy_num() {
		return allergy_num;
	}
	public void setAllergy_num(String allergy_num) {
		this.allergy_num = allergy_num;
	}
	public Date getMenu_wdate() {
		return menu_wdate;
	}
	public void setMenu_wdate(Date menu_wdate) {
		this.menu_wdate = menu_wdate;
	}


}
