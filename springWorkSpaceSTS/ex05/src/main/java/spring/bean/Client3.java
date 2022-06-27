package spring.bean;

public class Client3 {
	
	private String host;

	public void setHost(String host) { // 문자열 객체 주입
		this.host = host;
		System.out.println("Client3.setHost() 실행");
	}
	
	public void send() { // 실제 사용할 메서드
		System.out.println("Client3.send() to + " + host);
	}
	
}
