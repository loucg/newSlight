package com.fh.hzy.util;

import com.fh.entity.system.User;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;

/**
 * 
 * @author hongzhiyuanzj
 *
 */

public class UserUtils {
	public static String getUserid(){
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		System.out.println("userid:"+user.getUSER_ID());
		return user.getUSER_ID();
	}
	
	public static String getRoleid(){
		User user = (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		return user.getROLE_ID();
		
	}
}
