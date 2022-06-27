package spring.bean;

public class Client2 {
	
	private String host;

	public void setHost(String host) { // 문자열 객체 주입
		this.host = host;
		System.out.println("Client2.setHost() 실행");
	}
	
	public void send() { // 실제 사용할 메서드
		System.out.println("Client2.send() to + " + host);
	}
	
	
	// 빈 초기화 및 소멸시 사용할 메서드를 임의로 생성
	public void open() throws Exception { // 초기화시 사용할 메서드
		System.out.println("빈 초기화 : Client2.open() 실행");
	}
	
	public void close() throws Exception  { // 소멸시 사용할 메서드
		System.out.println("빈 소멸시 : Client2.close() 실행");
	}
}
