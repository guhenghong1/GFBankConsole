package com.bank.console.file.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bank.console.common.interceptor.Permission;

@Controller
@RequestMapping("/file")
public class FileController {
	private static Logger log = Logger.getLogger(FileController.class);
	
	/**
	 * 获取文件列表
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/download")
	public void download(@RequestParam("filePath") String filePath, HttpServletResponse resp) {
		if(StringUtils.isEmpty(filePath)) {
			log.error("filepath is empty...");
			return ;
		}
		
		try {
			filePath = filePath.replace("\\", "/");
			File file = new File(filePath);
		
			resp.setCharacterEncoding("UTF-8");
			
			if(!file.exists()) {
				resp.getWriter().println("文件不存在， 下载失败！");
				return;
			}
			resp.setHeader("content-type", "application/msword;charset=UTF-8");
			
			String fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length());
			//1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
		    resp.setContentType("multipart/form-data");  
			resp.setHeader("Content-Disposition", "attachment;filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");
			FileInputStream in = new FileInputStream(file);
			OutputStream out = resp.getOutputStream();
			
			File tempFile = new File("D:/uploadFile/temp.doc");
			FileOutputStream write = new FileOutputStream(tempFile);
			byte[] buffer = new byte[1024];
			int index = 0;
			while((index = in.read(buffer))> -1) {
				out.write(buffer, 0, index);
				write.write(buffer, 0, index);
			}
			out.flush();
			out.close();
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("file download successfully..");
	}
}
