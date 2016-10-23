package com.bank.console.file.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
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
	 * 
	 * @param form
	 * @return
	 */
	@Permission
	@RequestMapping("/download")
	public void download(@RequestParam("filePath") String filePath, HttpServletRequest req, HttpServletResponse resp) {
		OutputStream out = null;
		FileInputStream in = null;
		try {
			req.setCharacterEncoding("UTF-8");
			if (StringUtils.isEmpty(filePath)) {
				log.error("filepath is empty...");
				return;
			}

			filePath = new String(filePath.getBytes("ISO-8859-1"), "UTF-8");

			// String ff = new
			// String(req.getParameter("filePath").getBytes("ISO-8859-1"),"utf-8");
			filePath = filePath.replace("\\", "/");
			File file = new File(filePath);

			resp.setCharacterEncoding("UTF-8");

			if (!file.exists()) {
				resp.getWriter().println("文件不存在， 下载失败！");
				return;
			}
			resp.setHeader("content-type", "application/x-msdownload;charset=UTF-8");

			String fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length());
			// 1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
			resp.setContentType("multipart/form-data");
			resp.setHeader("Content-Disposition",
					"attachment;filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");
			in = new FileInputStream(file);

			// resp.reset();
			out = resp.getOutputStream();

			byte[] buffer = new byte[1024];
			int index = 0;
			while ((index = in.read(buffer)) != -1) {
				out.write(buffer, 0, index);
			}
			out.flush();
			out.close();
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		}
		log.info("file download successfully..");
	}

	/**
	 * 下载文件
	 * 
	 * @param response
	 * @param csvFilePath
	 *            文件路径
	 * @param fileName
	 *            文件名称
	 * @throws IOException
	 */
	@Permission
	@RequestMapping("/exportFile")
	public void exportFile(@RequestParam("filePath") String filePath, HttpServletRequest req,
			HttpServletResponse response) {
		InputStream in = null;
		try {
			String fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length());
			response.setContentType("application/csv;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));

			in = new FileInputStream(filePath);
			int len = 0;
			response.setCharacterEncoding("UTF-8");
			OutputStream out;
			out = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int index = 0;
			while ((index = in.read(buffer)) != -1) {
				out.write(buffer, 0, index);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
