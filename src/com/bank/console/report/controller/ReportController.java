package com.bank.console.report.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bank.console.common.util.report.JFreeChartReportUtil;
import com.bank.console.common.util.report.Report;

@Controller
@RequestMapping("/report")
public class ReportController {
	
	@RequestMapping("/statistics")
	public String Statistics(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//柱状图
		String title = "柱状图报表";
		String x = "月份";
		String y = "水量";
		DefaultCategoryDataset dataset = this.getDataSet();
		Report report = JFreeChartReportUtil.barCharts(title, x, y, dataset, request);
		request.setAttribute("report", report);
		return "report/report";
	}
	
    /** 
    * 获取一个演示用的简单数据集对象
    * @return 
    */ 
    private  DefaultCategoryDataset getDataSet() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset(); 
        dataset.addValue(100, "", "1月份"); 
        dataset.addValue(203, "", "2月份"); 
        dataset.addValue(630, "", "3月份"); 
        dataset.addValue(300, "", "4月份"); 
        dataset.addValue(400, "", "5月份"); 
        dataset.addValue(500, "", "6月份"); 
        dataset.addValue(500, "", "7月份"); 
        dataset.addValue(500, "", "8月份"); 
        dataset.addValue(550, "", "9月份"); 
        dataset.addValue(1500, "", "10月份"); 
        dataset.addValue(1500, "", "11月份"); 
        dataset.addValue(1524, "", "12月份"); 
        return dataset; 
    } 
    
	
}
