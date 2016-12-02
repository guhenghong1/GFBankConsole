package com.bank.console.common.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;


public class CSVUtil {
	private static Logger log = Logger.getLogger(CSVUtil.class);
	
	public static File createCSVFile(List dataList, LinkedHashMap map, String outPutPath, String fileName) {
		File csvFile = null;
		BufferedWriter out = null;
		File file = new File(outPutPath+fileName+".csv");
		try {
			File parentFile = file.getParentFile();
			
			if(parentFile != null && !parentFile.exists()) {
				parentFile.mkdirs();
			}
			
			file.createNewFile();
//			csvFile = File.createTempFile(fileName, ".csv", new File(outPutPath));
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "utf-8"), 1024);
			//标题
			Iterator it = (Iterator) map.entrySet().iterator();
			for (Iterator i = map.values().iterator(); i.hasNext();) {
				String titleItem = i.next().toString();
				out.write("\""+titleItem+"\"");
				if(i.hasNext()) {
					out.write(",");
				}
			}
			out.newLine();
			
			//数据
			for(Iterator d = dataList.iterator(); d.hasNext();) {
				Map row = (Map) d.next();
				
				for(Iterator m = map.keySet().iterator(); m.hasNext();) {
					String key = (String)m.next();
					String dataValue = row.get(key) == null?"":row.get(key).toString();
					dataValue = dataValue.trim()+"";
					dataValue = dataValue.replace("\r\n", "").replace("\n", "").replace("\n", "");
					out.write(dataValue);
					if(m.hasNext()) {
						out.write(",");
					}
				}
				
				if(d.hasNext()) {
					out.newLine();
				}
			}
			
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
		} finally {
			try {
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return file;
	}
	
	  public static void main(String[] args) {
		    List exportData = new ArrayList<Map>();
		    Map row1 = new LinkedHashMap<String, String>();
		    row1.put("1", "11");
		    row1.put("2", "12");
		    row1.put("3", "13");
		    row1.put("4", "14");
		    exportData.add(row1);
		    row1 = new LinkedHashMap<String, String>();
		    row1.put("1", "21");
//		    row1.put("2", "22");
		    row1.put("3", "23");
		    row1.put("4", "24");
		    exportData.add(row1);
		    LinkedHashMap map = new LinkedHashMap();
		    map.put("1", "第一列");
		    map.put("2", "第二列");
		    map.put("3", "第三列");
		    map.put("4", "第四列");
		 
		    String path = "d:/export/";
		    String fileName = "文件导出";
		    File file = CSVUtil.createCSVFile(exportData, map, path, fileName);
		    String fileName2 = file.getName();
		    System.out.println("文件名称：" + fileName2);
		  }
}
