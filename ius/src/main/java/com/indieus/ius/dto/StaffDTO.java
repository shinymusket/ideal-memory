package com.indieus.ius.dto;

public class StaffDTO { // 뷰를 위한 DTO
	 private String staff_num;
	 private String staff_cls;
	 private String staff_id;
	 private String staff_name;
	 private String staff_rrn;

	 private String staff_sex; // 주민등록번호 뒷자리 중 첫자리가 홀수이면 남성, 짝수이면 여성
	 private String staff_birth; // 주민등록번호 앞자리의 데이터
	 private String staff_age; // 주민등록번호 맨 앞자리의 데이터와 맨 뒷번호의 첫자리

	 private String staff_addr;
	 private String staff_zipcode;
	 private String staff_tel;
	 private String staff_hireD;
	 private String staff_retireD;
	 private String staff_workYn;
	 private int staff_salary;
	 private String staff_email;

	public String getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(String staff_num) {
		this.staff_num = staff_num;
	}
	public String getStaff_cls() {
		return staff_cls;
	}
	public void setStaff_cls(String staff_cls) {
		this.staff_cls = staff_cls;
	}
	public String getStaff_id() {
		return staff_id;
	}
	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getStaff_rrn() {
		return staff_rrn;
	}
	public void setStaff_rrn(String staff_rrn) {
		this.staff_rrn = staff_rrn;
	}
	public String getStaff_sex() {
		return staff_sex;
	}
	public void setStaff_sex(String staff_sex) {
		this.staff_sex = staff_sex;
	}
	public String getStaff_birth() {
		return staff_birth;
	}
	public void setStaff_birth(String staff_birth) {
		this.staff_birth = staff_birth;
	}
	public String getStaff_age() {
		return staff_age;
	}
	public void setStaff_age(String staff_age) {
		this.staff_age = staff_age;
	}
	public String getStaff_addr() {
		return staff_addr;
	}
	public void setStaff_addr(String staff_addr) {
		this.staff_addr = staff_addr;
	}
	public String getStaff_zipcode() {
		return staff_zipcode;
	}
	public void setStaff_zipcode(String staff_zipcode) {
		this.staff_zipcode = staff_zipcode;
	}
	public String getStaff_tel() {
		return staff_tel;
	}
	public void setStaff_tel(String staff_tel) {
		this.staff_tel = staff_tel;
	}
	public String getStaff_hireD() {
		return staff_hireD;
	}
	public void setStaff_hireD(String staff_hireD) {
		this.staff_hireD = staff_hireD;
	}
	public String getStaff_retireD() {
		return staff_retireD;
	}
	public void setStaff_retireD(String staff_retireD) {
		this.staff_retireD = staff_retireD;
	}
	public String getStaff_workYn() {
		return staff_workYn;
	}
	public void setStaff_workYn(String staff_workYn) {
		this.staff_workYn = staff_workYn;
	}
	public int getStaff_salary() {
		return staff_salary;
	}
	public void setStaff_salary(int staff_salary) {
		this.staff_salary = staff_salary;
	}
	public String getStaff_email() {
		return staff_email;
	}
	public void setStaff_email(String staff_email) {
		this.staff_email = staff_email;
	}


}
