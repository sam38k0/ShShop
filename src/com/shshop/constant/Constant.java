package com.shshop.constant;
 
public class Constant {
	//Command
	public static final String login = "/login";
	public static final String logout = "/logout";
	public static final String join = "/join";
	public static final String insertProduct = "/insertProduct";
	public static final String search = "/search";
	public static final String viewMain = "/viewMain";
	public static final String insertHopeProductView = "/insertHopeProduct";
	public static final String headerView = "/headerView";
	public static final String checklogin = "/checklogin";

	//Attribute
	public static final String attrUser = "user";
	public static final String attrEmail = "email";
	public static final String attrPassword = "password";
	
	//ContentType
	public static final String textHtml = "text/html;charset=UTF-8";
	public static final String textPlain = "text/plain;charset=UTF-8";
	
	//Message
	public static final String wrongEmail = "이메일 입력 형식 정보가 잘못 되었습니다.";
	public static final String noPassword = "패스워드를 입력하시지 않았습니다.";
	public static final String noUser = "사용자 정보를 찾을 수 없습니다.";
	
	//Ajax
	public static final String Success = "Success";
	public static final String Failed = "Failed"; 
	public static final String onLogin = "onLogin";
}
