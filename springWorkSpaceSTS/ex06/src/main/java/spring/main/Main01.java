package spring.main;

import spring.calc.ImpeCalculator;
import spring.calc.RecCalculator;

public class Main01 {

	public static void main(String[] args) {
		// 두가지 방법의 팩토리얼을 구해서 시간을 측정해 봅시다.
		
		ImpeCalculator impeCal = new ImpeCalculator();
		long sevenFactorial1 = impeCal.factorial(7);
		
		RecCalculator recCal = new RecCalculator();
		long sevenFactorial2 = recCal.factorial(7);
		
		System.out.println("sevenFactorial1의 결과 : "  + sevenFactorial1);
		System.out.println("sevenFactorial2의 결과 : "  + sevenFactorial2);
	}

}
