package inventory.validate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import inventory.model.Users;
import inventory.service.UserService;

@Component
public class UserValidator implements Validator{
	@Autowired
	private UserService userService;

	public boolean supports(Class<?> clazz) {
		return clazz==Users.class;
	}

	public void validate(Object target, Errors errors) {
		Users user = (Users) target;
		ValidationUtils.rejectIfEmpty(errors, "userName", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "password", "msg.required");
		if(user.getId()!=null) {
			ValidationUtils.rejectIfEmpty(errors, "name", "msg.required");
		}
		List<Users> users = userService.findByProperty("userName", user.getUserName());
		if(users!=null && !users.isEmpty()) {
			if(users.get(0).getId()!=user.getId() && users.get(0).getUserName().equals(user.getUserName())) {
				errors.rejectValue("userName", "msg.username.exists");
			}
			
		}
		
	}

}
