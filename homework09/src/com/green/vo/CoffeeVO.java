package com.green.vo;

import java.io.Serializable;

public class CoffeeVO implements Serializable {
	private String cName;
	private String cType;
	private int price; 
	private int count;
	private int subtotal;
	
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSubtotal() {
		this.subtotal = this.count * this.price; 
		return subtotal;
	}
	
	
	
	
	
}
