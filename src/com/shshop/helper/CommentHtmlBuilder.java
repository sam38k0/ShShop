package com.shshop.helper;

import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Post;
import com.shshop.domain.User;

public class CommentHtmlBuilder {
	private Post post;
	private String userName;
	private String dateCreated;
	private String comment;
	private CommentHtmlBuilder parent = null;
	private List<CommentHtmlBuilder> items = new ArrayList<>();

	public static void main(String[] args) {
		CommentHtmlBuilder htmlBuilder = new CommentHtmlBuilder("name1","comment1","2014/01/01");
		htmlBuilder.add(new CommentHtmlBuilder("name11","comment11","2014/01/02"));
		htmlBuilder.add(new CommentHtmlBuilder("name12","comment12","2014/01/02"));
		System.out.println(htmlBuilder.buildHtmlDebug());
		
	}

	public CommentHtmlBuilder(Post post, User user) {
		this.setParent(parent);
		this.setUserName(user.getName());
		this.setComment(post.getComment());
		this.setDateCreated(post.getDateCreated().toString());
	}

	public CommentHtmlBuilder(String userName, String comment, String dateCreated) {
		this.setUserName(userName);
		this.setComment(comment);
		this.setDateCreated(dateCreated);
	}

	public String buildHtml() {
		StringBuilder result = new StringBuilder();

		if (getParent() != null) {
			result.append("<div>");
			result.append("<div>");
		}

		result.append("<dl>");
		result.append("<dt><img src=\"${adminBean.contextPath}/content/image/user.gif\"></dt>");
		result.append("<dd>");
		result.append("<p class=\"name\">");
		result.append("<a href=\"#\" data-nick=\"" + getUserName() + "\">" + getUserName());
		result.append("</a><span class=\"time\">" + getDateCreated() + "</span>");
		result.append("</p>");
		result.append("<p class=\"text\">" + getComment() + "</p>");

		for (CommentHtmlBuilder item : items) {
			item.setParent(this);
			result.append(item.buildHtml());
		}

		result.append("</dd>");
		result.append("</dl>");

		if (getParent() != null) {
			result.append("</div>");
		}

		if (items.isEmpty()) {
			result.append("<p class=\"functionCmt\">");
			result.append("<a href=\"#\" class=\"cmtReply\">댓글달기</a>");
			result.append("</p>");
			result.append("<div class=\"cmtReply hide\" style=\"display: none;\">");
			result.append("<textarea placeholder=\"댓글을 입력하세요\" title=\"댓글을 입력하세요\" style=\"width: 522px; height: 17px\"></textarea>");
			result.append("</div>");
		}

		if (getParent() != null) {
			result.append("</div>");
		}

		return result.toString();
	}

	public String buildHtmlDebug() {
		String indent = "\t";
		String newline = "\r\n";
		StringBuilder result = new StringBuilder();

		if (getParent() != null) {
			result.append("<div>");
			result.append(newline);
			result.append(indent + "<div>");
			result.append(newline);
		}

		result.append(indent + "<dl>");
		result.append(newline);
		result.append(indent + "<dt><img src=\"${adminBean.contextPath}/content/image/user.gif\"></dt>");
		result.append(newline);
		result.append(indent + "<dd>");
		result.append(newline);
		result.append(indent + "<p class=\"name\">");
		result.append(newline);
		result.append(indent + "<a href=\"#\" data-nick=\"" + getUserName() + "\">" + getUserName());
		result.append("</a><span class=\"time\">" + getDateCreated() + "</span>");
		result.append(newline);
		result.append(indent + "</p>");
		result.append(newline);
		result.append(indent + "<p class=\"text\">" + getComment() + "</p>");
		result.append(newline);

		for (CommentHtmlBuilder item : items) {
			item.setParent(this);
			result.append(item.buildHtmlDebug());
		}

		result.append(indent + "</dd>");
		result.append(newline);
		result.append(indent + "</dl>");
		result.append(newline);

		if (getParent() != null) {
			result.append(indent + "</div>");
			result.append(newline);
		}

		if (items.isEmpty()) {
			result.append(indent + "<p class=\"functionCmt\">");
			result.append(newline);
			result.append(indent + "<a href=\"#\" class=\"cmtReply\">댓글달기</a>");
			result.append(newline);
			result.append(indent + "</p>");
			result.append(newline);
			result.append(indent + "<div class=\"cmtReply hide\" style=\"display: none;\">");
			result.append(newline);
			result.append(indent + "<textarea placeholder=\"댓글을 입력하세요\" title=\"댓글을 입력하세요\" style=\"width: 522px; height: 17px\"></textarea>");
			result.append(newline);
			result.append(indent + "</div>");
			result.append(newline);
		}

		if (getParent() != null) {
			result.append("</div>");
			result.append(newline);
		}

		return result.toString();
	}

	
	public void add(CommentHtmlBuilder menuComponent) {
		items.add(menuComponent);
	}

	public void remove(CommentHtmlBuilder menuComponent) {
		items.remove(menuComponent);
	}

	public CommentHtmlBuilder getChild(int i) {
		return items.get(i);
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public CommentHtmlBuilder getParent() {
		return parent;
	}

	public void setParent(CommentHtmlBuilder parent) {
		this.parent = parent;
	}
}
