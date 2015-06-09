package com.shshop.helper;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import com.shshop.domain.Post;
import com.shshop.domain.User;
import com.shshop.mapper.PostMapper;

public class PostHtmlBuilder {
	private static Comparator<Post> postSort = new Comparator<Post>() {
		public int compare(Post param1, Post param2) {
			return param1.getPostId().compareTo(param2.getPostId());
		}
	};

	private String userName;
	private String dateCreated;
	private String comment;
	private PostHtmlBuilder parent = null;
	private List<PostHtmlBuilder> items = new ArrayList<>();

	public static void main(String[] args) {
		PostHtmlBuilder htmlBuilder = new PostHtmlBuilder("name1", "comment1", "2014/01/01");
		PostHtmlBuilder htmlChild1 = new PostHtmlBuilder("name11", "comment11", "2014/01/02");
		PostHtmlBuilder htmlChild2 = new PostHtmlBuilder("name12", "comment12", "2014/01/02");
		PostHtmlBuilder htmlChild3 = new PostHtmlBuilder("name111", "comment111", "2014/01/02");
		htmlBuilder.add(htmlChild1);
		htmlBuilder.add(htmlChild2);
		htmlChild1.add(htmlChild3);

		System.out.println(htmlBuilder.buildHtml(true, false));

	}

	public static String getPostHtml(List<Post> posts, PostMapper postMapper) {
		if (posts == null)
			return null;

		posts.sort(postSort);

		List<PostHtmlBuilder> builders = new ArrayList<>();

		for (Post post : posts) {
			if (post == null || !post.isRootPost())
				continue;

			User user = postMapper.getUserOfPost(post.getPostId());
			if (user == null)
				continue;

			PostHtmlBuilder builder = new PostHtmlBuilder(post, user);

			addChildPosts(builder, post, postMapper);

			builders.add(builder);
		}
		
		boolean isFirst = true;
		boolean isGray = false;
		StringBuilder result = new StringBuilder();

		for (PostHtmlBuilder builder : builders) {
			result.append(builder.buildHtml(isFirst, isGray));
			isFirst = false;
			isGray = !isGray;
		}

		return result.toString();
	}

	public PostHtmlBuilder(Post post, User user) {
		this.setParent(parent);
		this.setUserName(user.getName());
		this.setComment(post.getComment());
		this.setDateCreated(Format.getStrDateFromSqlDate(post.getDateCreated()));
	}

	public PostHtmlBuilder(String userName, String comment, String dateCreated) {
		this.setUserName(userName);
		this.setComment(comment);
		this.setDateCreated(dateCreated);
	}

	public String buildHtml(boolean isFirst, boolean isGray) {
		StringBuilder result = new StringBuilder();

		if (getParent() != null) {
			result.append("<div class=\"cmtcmt\">");
			
			result.append("<div class=\"cmtView2\">");
			result.append("<p class=\"cmtReplyTitle\">댓글의댓글</p>");
			result.append("<dl>");
		} else {
			if (isFirst) {
				result.append("<dl class=\"first\">");
			} else {
				if (isGray) {
					result.append("<dl class=\"gray\">");
				} else {
					result.append("<dl>");
				}
			}
		}

		result.append("<dt><img src=\"/ShShopTest/content/image/user.gif\"></dt>");
		result.append("<dd>");
		result.append("<p class=\"name\">");
		result.append("<a href=\"#\" data-nick=\"" + getUserName() + "\">" + getUserName());
		result.append("</a><span class=\"time\">" + getDateCreated() + "</span>");
		result.append("</p>");
		result.append("<p class=\"text\">" + getComment() + "</p>");

		for (PostHtmlBuilder item : items) {
			item.setParent(this);
			result.append(item.buildHtml(isFirst, isGray));
			isFirst = false;
			isGray = !isGray;
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

	public void add(PostHtmlBuilder menuComponent) {
		items.add(menuComponent);
	}

	public void remove(PostHtmlBuilder menuComponent) {
		items.remove(menuComponent);
	}

	public PostHtmlBuilder getChild(int i) {
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

	public PostHtmlBuilder getParent() {
		return parent;
	}

	public void setParent(PostHtmlBuilder parent) {
		this.parent = parent;
	}

	private static void addChildPosts(PostHtmlBuilder builder, Post post, PostMapper postMapper) {
		List<Post> children = postMapper.getChildPosts(post);
		if (children == null || children.size() <= 0)
			return;

		for (Post child : children) {
			User user = postMapper.getUserOfPost(child.getPostId());
			if (user == null)
				continue;

			PostHtmlBuilder childBuilder = new PostHtmlBuilder(child, user);
			builder.add(childBuilder);

			addChildPosts(childBuilder, child, postMapper);
		}
	}
}
