package com.green.pt001.vo;

import oracle.sql.DATE;

public class FinanceVO {
	private String finance_num;
	private String budget_num;
	private String staff_num;
	private DATE finance_eDate;
	private String finance_cls;
	private String finance_iE;
	private int finance_amount;
	
	public String getFinance_num() {
		return finance_num;
	}
	public void setFinance_num(String finance_num) {
		this.finance_num = finance_num;
	}
	public String getBudget_num() {
		return budget_num;
	}
	public void setBudget_num(String budget_num) {
		this.budget_num = budget_num;
	}
	public String getStaff_num() {
		return staff_num;
	}
	public void setStaff_num(String staff_num) {
		this.staff_num = staff_num;
	}
	public DATE getFinance_eDate() {
		return finance_eDate;
	}
	public void setFinance_eDate(DATE finance_eDate) {
		this.finance_eDate = finance_eDate;
	}
	public String getFinance_cls() {
		return finance_cls;
	}
	public void setFinance_cls(String finance_cls) {
		this.finance_cls = finance_cls;
	}
	public String getFinance_iE() {
		return finance_iE;
	}
	public void setFinance_iE(String finance_iE) {
		this.finance_iE = finance_iE;
	}
	public int getFinance_amount() {
		return finance_amount;
	}
	public void setFinance_amount(int finance_amount) {
		this.finance_amount = finance_amount;
	}
	
	
}
