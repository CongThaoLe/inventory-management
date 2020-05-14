package inventory.validate;

import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.google.protobuf.compiler.PluginProtos.CodeGeneratorResponse.File;

import inventory.model.ProductInfo;
import inventory.service.ProductService;
@Component
public class ProductInfoValidator implements Validator{
	@Autowired
	private ProductService productService;
	public boolean supports(Class<?> clazz) {
		return clazz == ProductInfo.class;
	}

	public void validate(Object target, Errors errors) {
		ProductInfo productInfo = (ProductInfo ) target;
		ValidationUtils.rejectIfEmpty(errors, "code", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "name", "msg.required");
		ValidationUtils.rejectIfEmpty(errors, "description", "msg.required");
		if(productInfo.getId()!=null) {
			ValidationUtils.rejectIfEmpty(errors, "multipartFile", "msg.required");
		}
		if(productInfo.getCode()!=null) {
			List<ProductInfo> result = productService.findProductInfo("code", productInfo.getCode());
			if(result!=null && !result.isEmpty()) {
			if(productInfo.getId()!=null && productInfo.getId()!=0) {
				if(result.get(0).getId()!=productInfo.getId()) {
					errors.reject("code","msg.code.exist");
				}
			}else {
				errors.reject("code","msg.code.exist");
			}
			}
		}
		if(!productInfo.getMultipartFile().getOriginalFilename().isEmpty()) {
			String extension = FilenameUtils.getExtension(productInfo.getMultipartFile().getOriginalFilename());
			if(!extension.equals("jpg") && !extension.equals("png")) {
				errors.rejectValue("multipartFile", "msg.file.extension.error");
			}
		}
	}

}
