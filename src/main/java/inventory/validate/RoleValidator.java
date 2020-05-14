package inventory.validate;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import inventory.model.Role;
@Component
public class RoleValidator implements Validator {

	public boolean supports(Class<?> clazz) {
		return clazz==Role.class;
	}

	public void validate(Object target, Errors errors) {
		Role role = (Role) target;
		ValidationUtils.rejectIfEmpty(errors, "roleName", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "description", "msg.required");
		
	}

}
