package com.green.vo;

import java.io.Serializable;

public class MovieVO implements Serializable {
	private String movieCode;
	private String movieName;
	private String movieDirector;
	private String leadingActor;
	private int moviePrice;
	private String stillCutPath;
	private Double grade;
	
	public String getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getLeadingActor() {
		return leadingActor;
	}
	public void setLeadingActor(String leadingActor) {
		this.leadingActor = leadingActor;
	}
	public int getMoviePrice() {
		return moviePrice;
	}
	public void setMoviePrice(int moviePrice) {
		this.moviePrice = moviePrice;
	}
	public String getStillCutPath() {
		return stillCutPath;
	}
	public void setStillCutPath(String stillCutPath) {
		this.stillCutPath = stillCutPath;
	}
	public Double getGrade() {
		return grade;
	}
	public void setGrade(Double grade) {
		this.grade = grade;
	}
	
}
