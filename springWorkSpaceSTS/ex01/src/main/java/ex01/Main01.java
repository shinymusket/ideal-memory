package ex01;

public class Main01 {

	public static void main(String[] args) {
		// 스프링을 사용하지 않는 순수 자바 예제
		
		Greeter g = new Greeter(); // 순수 자바코드는 객체를 new 연산을 이용해서 생성한다.
		g.setFormat("%s, 반갑습니다.");
		
		String msg = g.greet("홍길동");
		
		System.out.println(msg);

	}

}
