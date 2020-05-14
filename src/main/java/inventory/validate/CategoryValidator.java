package inventory.validate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import inventory.model.Category;
import inventory.service.ProductService;
@Component
public class CategoryValidator implements Validator{
	@Autowired
	private ProductService productService;
	public boolean supports(Class<?> clazz) {
		return clazz == Category.class;
	}

	public void validate(Object target, Errors errors) {
		Category category = (Category) target;
		ValidationUtils.rejectIfEmpty(errors, "code", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "name", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "description", "msg.required");
		if(category.getCode()!=null) {
			List<Category> result = productService.findCategory("code", category.getCode());
			if(result!=null && !result.isEmpty()) {
				if(category.getId()!=null && category.getId()!=0) {
					if(result.get(0).getId()!=category.getId()) {
						errors.reject("code","msg.code.exist");
					}
				}else {
					errors.reject("code","msg.code.exist");
				}
			}
		}
	}

}
