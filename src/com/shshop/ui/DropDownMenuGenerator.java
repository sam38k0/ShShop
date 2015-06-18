package com.shshop.ui;

import java.util.List;

public class DropDownMenuGenerator {

	static public String generateSelect(DropDownMenuContainer container, String fieldsetId, String selectId) {
		String indent = "  ";
		StringBuilder builder = new StringBuilder();
		builder.append("<fieldset class=\"" + fieldsetId + "\">\n");
		builder.append(indent + "<legend>Choose Product</legend>\n");
		builder.append(indent + indent + "<label for=\"" + selectId + "\">type</label>\n");
		builder.append(indent + indent + "<select id=\"" + selectId + "\" name=\"" + selectId + "\">\n");
		builder.append(indent + indent + indent + "<option value=\"choose\">Please choose a type</option>\n");

		List<DropDownMenu> menuList = container.getMenuItems();
		for (int i = 0; i < menuList.size(); i++) {
			builder.append(indent + indent + indent + "<option value=\"" + menuList.get(i).getMenuKey() + "\">" + menuList.get(i).getMenuName()
					+ "</option>\n");
		}

		builder.append(indent + "</select>\n");
		builder.append("</fieldset>\n");

		return builder.toString();
	}
}
