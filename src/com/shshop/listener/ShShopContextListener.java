package com.shshop.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.shshop.service.CategoryControlService;
import com.shshop.threading.AleadyClosedException;
import com.shshop.threading.ThreadPool;

public class ShShopContextListener implements ServletContextListener {

	private static ThreadPool pool = new ThreadPool(5, 10, 5, 2);

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try {
			if (CategoryControlService.getBuildHtmlResult().equals("")) {
				pool.execute(new Runnable() {
					public void run() {
						CategoryControlService categoryControlService = new CategoryControlService();
						categoryControlService.buildHtml(true, true);
					}
				});
			}
		} catch (AleadyClosedException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {

	}
}
