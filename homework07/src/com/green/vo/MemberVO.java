package com.green.vo;
public class MemberVO {
	
	
	
	
	private String name;
	private int korScore;
	private int engScore;
	private int mathScore;
	private int sumScore;
	private double avgScore;
	private int rank;
	
	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getKorScore() {
		return korScore;
	}

	public void setKorScore(int korScore) {
		this.korScore = korScore;
	}

	public int getEngScore() {
		return engScore;
	}

	public void setEngScore(int engScore) {
		this.engScore = engScore;
	}

	public int getMathScore() {
		return mathScore;
	}

	public void setMathScore(int mathScore) {
		this.mathScore = mathScore;
	}

	public int getSumScore() {
		sumScore = this.korScore + this.engScore + this.mathScore;
		return sumScore;
	}


	public double getAvgScore() {
		avgScore = (double) (sumScore/3);
		return avgScore;
	}

		
	
}
