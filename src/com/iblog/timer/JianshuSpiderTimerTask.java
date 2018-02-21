package com.iblog.timer;

import java.util.TimerTask;

import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.model.OOSpider;
import us.codecraft.webmagic.scheduler.QueueScheduler;

public class JianshuSpiderTimerTask extends TimerTask{

	@Override
	public void run() {
		com.iblog.model.Site site = com.iblog.model.Site.dao.getSite();
    	if(1 == site.getSpiderStatus()){
            //启动webmagic
            OOSpider.create(Site.me().setSleepTime(1000), JianshuSpider.class)
                    .setScheduler(new QueueScheduler())
                    .addUrl("https://www.jianshu.com").start();
    	}
	}

}
