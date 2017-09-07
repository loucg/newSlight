package com.fh.hzy.util;

/**
 * 语言包
 * @author hongzhiyuanzj
 *
 */
public class LanguageManager {
	
	public static final String zh_CN = "zh_CN";
	public static final String en_US = "en_US";
	
	public static IPageLanguage getIPageLanuage(String language){
		if(language.equals(zh_CN)){
			return new CNPageLanguage();
		}else if(language.equals(en_US)){
			return new ENPageLanguage();
		}
		return null;
	}
	
	public static String getLanguageString(String language_code){
		if(language_code.equals("1")){
			return zh_CN;
		}else if(language_code.equals("2")){
			return en_US;
		}
		return null;
		
	}
	
}
