package spring.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import spring.vo.RegisterRequest;

public class RegisterRequestValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return RegisterRequest.class.isAssignableFrom(clazz);
	}

	// 콜 바이 레퍼런스 / 콜 바이 벨류
	
	private static final String emailExp = 
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	
	private Pattern pattern = Pattern.compile(emailExp);
	
	@Override
	public void validate(Object target, Errors errors) {
		// 					검사 대상 객체	검사 결과 어러 코드
		// 검사 대상 객체의 특정 프로퍼티의 값이나 상태등이 올바른지 체크하고
		// 값이 올바르지 않다면 errors에 에러코드를 저장
		
//		형 변환이 가능한지 검증.
//		if(target instanceof RegisterRequest) {
//			RegisterRequest regReq = (RegisterRequest) target;
//		}
		
		RegisterRequest regReq = (RegisterRequest) target;
		
		if(regReq.getEmail() == null || regReq.getEmail().trim().isEmpty()) {
			errors.rejectValue("email", "required");
		} else { // 이메일 형식 체크 ~~~@~~.~~
			Matcher matcher = pattern.matcher(regReq.getEmail());
			if(!matcher.matches()) { // true : 정규식 일치 / false : 정규식 불일치
				errors.rejectValue("email", "badMatch");
			}
		}
		
		
		
		
		// 입력받은 프로퍼티가 공백인가 비었는가?
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		// ValidationUtils 객체는 자주 사용되는 값 검증 코드를 메서드화 한 것
		ValidationUtils.rejectIfEmpty(errors, "password", "required");
		ValidationUtils.rejectIfEmpty(errors, "confirmPassword", "required");
		
		// 비밀번호와 비밀번호 확인이 일치하는가?
		if(!regReq.getPassword().isEmpty()) {
			if(!regReq.isPasswordEqualConfirmPassword()) { // 일치하지 않는다면
				errors.rejectValue("confirmPassword", "nomatch");
			}
		}
	}

}
