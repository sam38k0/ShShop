package com.shshop.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class SqlDataUtil {
	public static java.sql.Date getSqlDate(String date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        java.util.Date parsed;
        java.sql.Date sqlDate;
		try 
		{
			parsed = format.parse(date);
			sqlDate = new java.sql.Date(parsed.getTime());
		} catch (ParseException e) 
		{ 
			sqlDate = null;
			e.printStackTrace();
		}
		return sqlDate;
	}
}
