package com.shshop.helper;

import java.util.ArrayList;
import java.util.List;

import com.shshop.domain.Category;

public class CategoryHtmlBuilder {
	private String name;
	private Category category;
	private List<CategoryHtmlBuilder> items = new ArrayList<>();

	public CategoryHtmlBuilder(String name) {
		this.setName(name);
	}

	public CategoryHtmlBuilder(Category category) {
		this.category = category;
		this.name = category.getName();
	}

	@Override
	public String toString() {
		StringBuilder result = new StringBuilder();

		if (items.isEmpty()) {
			result.append("<li><a href=\"searchCategory?categoryName=");
			result.append(getName());
			result.append("\">");
			result.append(getName());
			result.append("</a></li>");
			return result.toString();
		} else {
			result.append("<li><a href=\"#");
			result.append("\" class=\"choice\">");
			result.append(getName());
			result.append("</a>");
			return result.toString();
		}
	}

	public void add(CategoryHtmlBuilder menuComponent) {
		items.add(menuComponent);
	}

	public void remove(CategoryHtmlBuilder menuComponent) {
		items.remove(menuComponent);
	}

	public CategoryHtmlBuilder getChild(int i) {
		return items.get(i);
	}

	public String buildHtml() {
		StringBuilder result = new StringBuilder();
		result.append(this.toString());
		result.append("\r\n");

		boolean hasItem = !items.isEmpty();

		if (hasItem) {
			result.append("<ul class=\"allcategory\">");
			result.append("\r\n");
		}

		for (int i = 0; i < items.size(); i++) {
			result.append(items.get(i).buildHtml());
		}

		if (hasItem) {
			result.append("</ul></li>");
			result.append("\r\n");
		}

		return result.toString();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
