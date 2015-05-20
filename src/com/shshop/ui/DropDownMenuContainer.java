package com.shshop.ui;

import java.util.ArrayList;
import java.util.List;

public class DropDownMenuContainer {
	List<DropDownMenu> menuItems = new ArrayList<>();
	String menuSetName;
	String menuSetKey;
	
	public void addMenuItems(DropDownMenu menu) {
		menuItems.add(menu);
	}

	public List<DropDownMenu> getMenuItems() {
		return menuItems;
	}

	public void setMenuItems(List<DropDownMenu> menuItems) {
		this.menuItems = menuItems;
	}

	public String getMenuSetName() {
		return menuSetName;
	}

	public void setMenuSetName(String menuSetName) {
		this.menuSetName = menuSetName;
	}

	public String getMenuSetKey() {
		return menuSetKey;
	}

	public void setMenuSetKey(String menuSetKey) {
		this.menuSetKey = menuSetKey;
	}

}
