package com.shshop.system;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import com.shshop.domain.User;

public class AdminBean implements Serializable {
	private static final long serialVersionUID = 1L;

	private User user;
	private String userType;
	private String headerPage;
	private String footerPage;
	private String contentPage;
	private String scriptPage;
	private String stylePage;
	private String contextPath;

	public AdminBean() {
	
	}
	
	public AdminBean(HttpServletRequest request) {
		contextPath = request.getContextPath();
	}

	public void init(User user) throws Exception {
		this.user = user;
	}

	public User getUser() throws Exception {

		return user;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getContentPage() {
		return contentPage;
	}

	public void setContentPage(String contentPage) {
		this.contentPage = contentPage;
	}

	public String getHeaderPage() {
		return headerPage;
	}

	public void setHeaderPage(String headerPage) {
		this.headerPage = headerPage;
	}

	public String getFooterPage() {
		return footerPage;
	}

	public void setFooterPage(String footerPage) {
		this.footerPage = footerPage;
	}

	public String getContextPath() {
		return contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}

	public String getScriptPage() {
		return scriptPage;
	}

	public void setScriptPage(String scriptPage) {
		this.scriptPage = scriptPage;
	}

	public String getStylePage() {
		return stylePage;
	}

	public void setStylePage(String stylePage) {
		this.stylePage = stylePage;
	}
}
