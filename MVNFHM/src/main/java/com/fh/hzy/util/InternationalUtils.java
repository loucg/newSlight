package com.fh.hzy.util;

import com.fh.service.slight.language.InternationalService;
import com.fh.util.PageData;

public class InternationalUtils {
	
	
	public static String getLanguage(InternationalService service, PageData pd)throws Exception{
		String language = service.getLanguage(pd).getString("language");
		String result = LanguageManager.getLanguageString(language);
		System.out.println(result);
		return result;
	}
}
