package com.shshop.ui;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class DropDownMenuGeneratorTest {

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGenerateSelect() {
		DropDownMenuContainer container = new DropDownMenuContainer();
		
		DropDownMenu menu = new DropDownMenu();
		menu.setMenuKey("key 1");
		menu.setMenuName("product 1");
		container.addMenuItems(menu);
 
		menu = new DropDownMenu();
		menu.setMenuKey("key 2");
		menu.setMenuName("product 2");
		container.addMenuItems(menu); 
		
		String result = DropDownMenuGenerator.generateSelect(container,"productTypeFieldSet","productTypeSelect");
		System.out.println(result);
		
		String indent = "  ";
		StringBuilder builder = new StringBuilder();
		builder.append("<fieldset class=\"productTypeFieldSet\">\n");
		builder.append(indent + "<legend>Choose Product</legend>\n");
		builder.append(indent + indent + "<label for=\"productTypeSelect\">type</label>\n");
		builder.append(indent + indent + "<select id=\"productTypeSelect\" name=\"productTypeSelect\">\n");
		builder.append(indent + indent + indent + "<option value=\"choose\">Please choose a type</option>\n");
		builder.append(indent + indent + indent + "<option value=\"key 1\">prodcut 1</option>\n");
		builder.append(indent + indent + indent + "<option value=\"key 2\">prodcut 2</option>\n");
		builder.append(indent + indent + "<select id=\"productType\" name=\"productType\">\n");
		builder.append(indent + "</select>\n"); 
		builder.append("</fieldset>\n"); 

		assertEquals("testGenerateSelect",builder.toString().replaceAll("\\p{Z}", "")==result.replaceAll("\\p{Z}", ""));
	}

}
