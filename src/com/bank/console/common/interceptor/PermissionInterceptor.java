package com.bank.console.common.interceptor;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bank.console.common.Constant;

/**
* @ClassName: PermissionInterceptor
* @Description: 权限拦截
*
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter{

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#afterCompletion(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#postHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		if(request.getRequestURL().indexOf("/login.jsp") >= 0 || request.getRequestURL().indexOf("/login") >= 0){
			return true;
		}
		if(handler.getClass().isAssignableFrom(HandlerMethod.class)){
			Permission per = ((HandlerMethod) handler).getMethodAnnotation(Permission.class);
			//不验证权限
			if(per == null || per.validate() == false){
				if(request.getSession().isNew()) {
					response.sendRedirect(request.getContextPath() + "/login.jsp");
		            return false;
				}
			}else{
				String userId = (String) request.getSession().getAttribute(Constant.SESSION_USER_ID);
				if(StringUtils.isEmpty(userId)){
					response.sendRedirect(request.getContextPath() + "/login.jsp");
		            return false;
				}
			}
		}
		return true;
	}

}
