package com.bank.console.common.util;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
	/**
	 * 保存文件
	 * @param fileItem
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public static String saveFile(MultipartFile fileItem, String path) throws Exception{
		String fileName = fileItem.getOriginalFilename();
		if(fileName.isEmpty()) {
			return "";
		}
		path += File.separator + System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		path = path.replace("\\", "/");
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		fileItem.transferTo(new File(path));
		return path;
	}
}
