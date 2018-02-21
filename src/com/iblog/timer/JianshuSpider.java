package com.iblog.timer;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.iblog.model.Blog;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.ehcache.CacheKit;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.model.AfterExtractor;
import us.codecraft.webmagic.model.annotation.ExtractBy;
import us.codecraft.webmagic.model.annotation.ExtractByUrl;
import us.codecraft.webmagic.model.annotation.TargetUrl;

//TargetUrl的意思是只有以下格式的URL才会被抽取出生成model对象
//这里对正则做了一点改动，'.'默认是不需要转义的，而'*'则会自动被替换成'.*'，因为这样描述URL看着舒服一点...
//继承jfinal中的Model
//实现AfterExtractor接口可以在填充属性后进行其他操作
@TargetUrl(value = "https://www.jianshu.com/p/\\w+",
           sourceRegion="//ul[@class='note-list']/li/div[@class='content']/a[@class='title']")
public class JianshuSpider implements AfterExtractor {
	
  //用ExtractBy注解的字段会被自动抽取并填充
  //默认是xpath语法
  @ExtractBy("//div[@class='article']/h1/text()")
  private String title;
  
  @ExtractBy("//div[@class='article']/div[@class='author']/div[@class='info']//span[@class='name']/a/text()")
  private String sourceName;
  
  @ExtractByUrl
  private String sourceURL;
  
  @ExtractBy("//div[@class='show-content']/html()")
  private String content;
  
  @ExtractBy(value = "//div[@class='show-content-free']/p[1]/text()", notNull = true)
  private String p1;
  
  @ExtractBy(value = "//div[@class='image-view']/img/@data-original-src", notNull = true)
  private String titlePicture;

  @Override
  public void afterProcess(Page page) {
	  if(title.contains("简书"))
		  return;
      Blog blog = new Blog();
	  blog.setTitle(title);
	  blog.setTags(title);
	  blog.setSourceName(sourceName);
	  blog.setSourceURL(sourceURL);
	  blog.setContent(formatContent(content));
	  blog.setStatement(formatStatement(content));
	  blog.setCategoryId(2);
	  blog.setLogtime(new Date());
	  blog.setVisible("1");
	  blog.setTitlePicture("http:"+titlePicture+"?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/240");
	  //String imageName = downloadPicture(titlePicture);
      //blog.setTitlePicture("/IBlog/upload/"+imageName);
      //保存
	  try{
		  blog.save();
	  }catch(Exception e){
		  //e.printStackTrace();
	  }finally{
		  clearCache();  
	  }
  }
  
	private String downloadPicture(String picUrl) {
		URL url = null;
		String imageName = null;
		try {
			url = new URL("http:" + picUrl);
			DataInputStream dataInputStream = new DataInputStream(url.openStream());
			imageName = System.currentTimeMillis() + ".jpg";
			File file = new File(PathKit.getWebRootPath() + File.separator + "upload");
			if (!file.exists()) {
				file.mkdirs();
			}
			FileOutputStream fileOutputStream = new FileOutputStream(new File(PathKit.getWebRootPath() + File.separator + "upload" + File.separator + imageName));
			byte[] buffer = new byte[1024];
			int length;
			while ((length = dataInputStream.read(buffer)) > 0) {
				fileOutputStream.write(buffer, 0, length);
			}
			dataInputStream.close();
			fileOutputStream.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return imageName;
	}
	
	private String formatContent(String content){
		Document doc = Jsoup.parseBodyFragment(content);
		Elements imageDivs = doc.select("div.image-package");
		for(Element e : imageDivs){
			Element img = e.getElementsByTag("img").first();
			String imgsrc = "http:"+img.attr("data-original-src");
			e.after("<p><img src=\""+imgsrc+"\" title=\""+imgsrc+"\" alt=\""+imgsrc+"\"/></p><p>&nbsp;");
		}
		doc.select("div.image-package").remove();
		return doc.toString();
	}
	
	private String formatStatement(String content){
		Document doc = Jsoup.parseBodyFragment(content);
		Elements ps = doc.select("p");
		StringBuffer statement = new StringBuffer();
		Iterator<Element> it = ps.iterator();
		while(it.hasNext() && statement.length() < 255){
			Element p = it.next();
			statement.append(p.text());
		}
		String newStr = statement.toString();
		if(newStr.length() > 255){
			newStr = newStr.substring(0,252) + "...";
		}
		return newStr;
	}
	
	public void clearCache(){
		CacheKit.removeAll("index");
		CacheKit.removeAll("category");
		CacheKit.removeAll("commonAttr");
	}
  
}
