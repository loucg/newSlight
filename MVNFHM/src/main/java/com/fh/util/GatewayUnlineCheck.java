package com.fh.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class GatewayUnlineCheck implements ServletContextListener{

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		try {
			QuartzLoad.stop();
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			QuartzLoad.run();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
