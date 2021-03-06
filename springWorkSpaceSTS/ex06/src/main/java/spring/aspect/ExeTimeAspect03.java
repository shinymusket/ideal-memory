package spring.aspect;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;



@Aspect
@Order(1)
public class ExeTimeAspect03 {
	
		@Pointcut("execution(public * spring.calc..*(..))")
		public void publicTarget() {}
		
		
		@Around("publicTarget()")
		public Object measure(ProceedingJoinPoint joinPoint) throws Throwable { 
			long start = System.nanoTime();
			try {
				Object result = joinPoint.proceed();
				return result;
			} finally {
				long end = System.nanoTime();
				Signature sig = joinPoint.getSignature();
				System.out.printf("%s.%s(%s) 실행 시간 : %d\n", 
						joinPoint.getTarget().getClass().getSimpleName(),
						sig.getName(), Arrays.toString(joinPoint.getArgs()),
						(end-start));
			}
			
		}
}
