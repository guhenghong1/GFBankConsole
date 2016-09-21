/**   
* @Title: Permission.java
* @Package com.nsbank.console.common.interceptor
* @Description: TODO
* @author gaohui   
* @date 2015年7月14日 上午11:30:49
* @version V1.0   
*/
package com.bank.console.common.interceptor;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @ClassName: Permission
 * @Description: 权限注解
 * 
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Permission {
	
	boolean validate() default true;

}
