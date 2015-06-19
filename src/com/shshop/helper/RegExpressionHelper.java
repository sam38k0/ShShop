package com.shshop.helper;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegExpressionHelper {
	public static Pattern EMAIL_FILTER = Pattern.compile("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");

	public static boolean isValidEmail(String email) {
		Matcher m = EMAIL_FILTER.matcher(email);
		if (m.matches())
			return true;

		return false;
	}
}
