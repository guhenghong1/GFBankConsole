package com.bank.console.file.controller;

import java.io.File;
import java.io.FileInputStream;
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
		
			resp.setCharacterEncoding("GBK");
			
			if(!file.exists()) {
				resp.getWriter().println("文件不存在， 下载失败！");
				return;
			}
			
			String fileName = filePath.substring(filePath.indexOf("/") + 1, filePath.length());
			resp.setContentType("application/octet-stream");
			resp.setContentLength((int)filePath.length());
			resp.setHeader("Content-Disposition", "attachment;filename=\"" + URLEncoder.encode(fileName, "GBK") + "\"");
			FileInputStream in = new FileInputStream(file);
			OutputStream out = resp.getOutputStream();
			byte[] buffer = new byte[1024];
			int index = 0;
			while((index = in.read(buffer))> -1) {
				out.write(buffer, 0, index);
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
