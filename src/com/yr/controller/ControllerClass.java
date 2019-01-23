package com.yr.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yr.entity.Page;
import com.yr.entity.User;
import com.yr.service.JurisdictionService;
import com.yr.service.LoginService;
import com.yr.service.RoleService;
import com.yr.service.UserService;
import com.yr.util.JsonUtils;

@Controller
public class ControllerClass {
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private JurisdictionService jurisdictionService;
	
	@RequestMapping(value="/login")
	public String login(User user,Map<String,Object> map){
		String account=user.getAccount();
		String password=user.getPassword();
		if(null==account||"".equals(account)||null==password||"".equals(password)){
			map.put("value","incompleteValues");
			return "login";
		}			
		String isExistence=userService.findOut(account);
		if("0".equals(isExistence)){
			map.put("value","Non-existent");
			return "login";
		}else{
			Subject subject = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(account, password);
			try{
	        	//执行认证操作. 
	            subject.login(token);
	            subject.isPermitted("authorization");
	        }catch (AuthenticationException ae) {
	        	System.out.println("登陆失败: " + ae.getMessage());
	        	map.put("value","loginFailure");
	        	return "login";
	        }
			return "user";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/forgetThePassword")
	public String queryPassword(String account){
		String result="";
		result=loginService.queryPassword(account);
		if(result==null){
			result="null";
		}
		return result;
	}
	
	@RequestMapping(value="/updatePassword")
	public String updatePassword(HttpServletRequest request){
		loginService.updatePassword(request.getParameter("password"),request.getParameter("account"));
		return "redirect:/jsp/login.jsp";
	}
//分割线
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/queryToId")
	public String queryToId(Integer userId){
		User user=userService.queryToId(userId);
		String result = new JsonUtils().beanToJson(user, new String[]{"roleSet","jurisdictionSet"}, false);
		System.out.println(result);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/user",method={RequestMethod.POST})
	public String addUser(User user){
		String result=userService.addUser(user);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/user",method={RequestMethod.DELETE})
	public String deleteUser(Integer userId){
		String result=userService.deleteUser(userId);
		return result;
	}
//	430421200008065862
	@RequestMapping(value="/user",method={RequestMethod.PUT})
	public String updateUser(String userName,String account,Integer id) throws Exception{
		userName=new String(userName.getBytes("ISO8859-1"),"utf-8");
		userService.updateUser(userName,account,id);
		return "user";
	}
	
	
//分割线
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/user")
	public String query(HttpServletRequest request){
		Page<User> page = new Page<User>();
		String pageNow = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		if(pageNow != null && !"".equals(pageNow))
		{
			page.setPage(Integer.valueOf(pageNow));
			page.setPageSize(Integer.valueOf(pageSize));
		}
		page = userService.query(page);
		String userjson = "";
		try {
			// false表示数组中的属性不需要转成json,如果是true代表只将数组中的属性转成json格式
			//aa = JsonUtils.beanListToJson(listUser, new String[] { "roleList" }, false);
			//pageServlet.resourcePageMoth(request, response);
			userjson = JsonUtils.beanToJson(page,new String[] { "jurisdictionSet"}, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userjson;
	}
}