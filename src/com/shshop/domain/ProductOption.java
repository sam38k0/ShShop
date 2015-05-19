package com.shshop.domain;

public class ProductOption {
	private Integer optionId;
	private Integer optionTypeParentId;
	private String optionName;

	public ProductOption() {

	}

	public ProductOption(Integer optionId, String optionName) {
		this.optionId = optionId;
		this.optionName = optionName;
	}

	public Integer getOptionId() {
		return optionId;
	}

	public void setOptionId(Integer optionId) {
		this.optionId = optionId;
	}

	public Integer getOptionTypeParentId() {
		return optionTypeParentId;
	}

	public void setOptionTypeParentId(Integer optionTypeParentId) {
		this.optionTypeParentId = optionTypeParentId;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
}
