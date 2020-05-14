package inventory.security;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;

import inventory.model.Auth;
import inventory.model.UserRole;
import inventory.model.Users;
import inventory.util.Constant;

public class FilterSystem implements HandlerInterceptor{
	Logger logger = Logger.getLogger(FilterSystem.class);
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("Request URL = "+request.getRequestURI());
		Users users = (Users) request.getSession().getAttribute(Constant.USER_INFO);
		if(users == null) {
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}
		if(users!=null) {
			String url = request.getServletPath();
			if(!hasPermission(url, users)) {
				response.sendRedirect(request.getContextPath()+"/access-denied");
				return false;
			}
		}
		return true;
	}
	private boolean hasPermission(String url,Users users) {
		if(url.contains("/index") || url.contains("/access-denied") || url.contains("/logout")) {
			return true;
		}
		UserRole userRole = (UserRole) users.getUserRoles().iterator().next();
		Set<Auth> auths = userRole.getRole().getAuths();
		for(Object obj : auths) {
			Auth auth = (Auth) obj;
			if(url.contains(auth.getMenu().getUrl())) {
				return auth.getPermission() == 1;
			}
		}
		return false;
	}
}
