package com.water.works.common.util.report;

import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.AxisLocation;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.block.BlockContainer;
import org.jfree.chart.block.BorderArrangement;
import org.jfree.chart.block.EmptyBlock;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.DatasetRenderingOrder;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.CompositeTitle;
import org.jfree.chart.title.LegendTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.ui.RectangleEdge;
import org.jfree.ui.RectangleInsets;
import org.jfree.ui.TextAnchor;

public class JFreeChartReportUtil {
	/**
	 * 柱状图
	 * @param title
	 * @param x
	 * @param y
	 * @param dataset
	 * @return
	 * @throws IOException
	 */
    public static Report barCharts(String title,String x,String y,DefaultCategoryDataset dataset, HttpServletRequest request) throws IOException{  
    	Report report = new Report();  
        JFreeChart chart = ChartFactory.createBarChart3D(title,   
                x,   
                y,   
                dataset,   
                PlotOrientation.VERTICAL,   
                false,   
                false,   
                false);   
        CategoryPlot plot = chart.getCategoryPlot();  
        CategoryAxis categoryaxis = plot.getDomainAxis();  
        NumberAxis numberaxis = (NumberAxis) plot.getRangeAxis();  
        categoryaxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);  
        categoryaxis.setLabelFont(new Font("宋体", Font.PLAIN, 15));//X说明的字体  
        categoryaxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 12));//X显示的字体  
        numberaxis.setLabelFont(new Font("宋体", Font.PLAIN, 15));//Y显示的字体  
        numberaxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 12));//Y说明的字体  
        numberaxis.setUpperMargin(0.1);  
        BarRenderer3D renderer = (BarRenderer3D) plot.getRenderer();  
        renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());  
        renderer.setBaseItemLabelsVisible(true);  
        renderer.setBaseItemLabelFont(new Font("TimesRoman", Font.PLAIN, 12)); //柱状图上面的字体  
        renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_CENTER));   
        renderer.setItemLabelAnchorOffset(20D);// 设置柱形图上的文字偏离值   
          
        int k = dataset.getColumnCount();   
        int b;  
      //以下判断是控制柱子的多少在页面上显示的距离  
      if (k == 1) {     
          plot.getDomainAxis().setLowerMargin(0.2);//设置柱子距离左端距离    
          plot.getDomainAxis().setUpperMargin(0.2);//设置柱子距离右端距离     
          ((BarRenderer3D) plot.getRenderer()).setItemMargin(0.5);   
         b=200;  
      }else if(k<4){  
          plot.getDomainAxis().setLowerMargin(0.2);//设置柱子距离左端距离    
          plot.getDomainAxis().setUpperMargin(0.2);//设置柱子距离右端距离     
          renderer.setItemMargin(0.001);   
         b=250;  
      }   
      else if (k < 8) {     
         b=500;  
          renderer.setMaximumBarWidth(0.04);//设置柱子的宽度  
          renderer.setMinimumBarLength(0.1);  
          double margin = (1.0 - k * 0.08) / 3;     
          plot.getDomainAxis().setLowerMargin(0.05);     
          plot.getDomainAxis().setUpperMargin(0.05);   
          ((BarRenderer3D) plot.getRenderer()).setItemMargin(margin);     
      } else if(k<15){     
         b=1000;  
         renderer.setMaximumBarWidth(0.04);//设置柱子的最大宽度  
          ((BarRenderer3D) plot.getRenderer()).setItemMargin(0.1);     
      }else if(k<40){  
          b=1000;  
          renderer.setMaximumBarWidth(0.03);//设置柱子的最大宽度  
          plot.getDomainAxis().setLowerMargin(0.02);     
          plot.getDomainAxis().setUpperMargin(0.02);   
          ((BarRenderer3D) plot.getRenderer()).setItemMargin(0.0001);     
      }else{  
          b=1000;  
      }     
  
  
        plot.setRenderer(renderer);  
        HttpSession  session = request.getSession();
        String context =  request.getSession().getServletContext().getContextPath();
        String sourcePath = session.getServletContext().getResource("/").getPath();
        String rootPath = request.getSession().getServletContext().getRealPath("/"); 
        String rootPath1 = request.getSession().getServletContext().getRealPath(""); 
        FileOutputStream fos_jpg = null; 
        try{
        	String filePath = "D:\\BarChart.jpg";
        	File file = new File(filePath);
	        fos_jpg = new FileOutputStream(file); 
	        String filename = ServletUtilities.saveChartAsPNG(chart, b, 400, null, session);   
	        ChartUtilities.writeChartAsJPEG(fos_jpg, 1.0f,chart,400,300,null); 
	        String graphURL =  "/DisplayChart?filename=" + filename;   
	        report.setFilename(file.getName());  
	        report.setGraphURL(file.getPath());  
        } finally { 
            try { 
                fos_jpg.close(); 
            } catch (Exception e) {} 
        }
        return report;  
    }  
   
    /**
     * 饼状图
     * @param data
     * @param title
     * @return
     * @throws IOException
     */
    public static Report pieCharts(DefaultPieDataset data,String title) throws IOException{  
    	Report report = new Report();  
        PiePlot plot = new PiePlot(data);  
        plot.setCircular(true);  
        plot.setLabelFont(new Font("宋体", Font.PLAIN, 13));  
        StandardPieSectionLabelGenerator generator = new StandardPieSectionLabelGenerator(("{0}={1}({2})"), NumberFormat.getNumberInstance(),new DecimalFormat("0.00%"));  
        plot.setLabelGenerator(generator);  
  
        JFreeChart chart = new JFreeChart("",JFreeChart.DEFAULT_TITLE_FONT, plot, true);  
        chart.setBackgroundPaint(java.awt.Color.white);//可选，设置图片背景色  
        chart.setTitle(title);//可选，设置图片标题  
  
        ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());  
        //500是图片长度，300是图片高度  
//        HttpSession  session = request.getSession();  
        String filename = ServletUtilities.saveChartAsPNG(chart, 600, 400, info, null);   
        String graphURL =  "/DisplayChart?filename=" + filename;    
        report.setFilename(filename);  
        report.setGraphURL(graphURL);  
        return report;  
    }  
    
    /**
     * 折线图
     * @return
     * @throws IOException
     */
    public static Report dualAxisCharts() throws IOException{  
    	Report report = new Report();  
        String s = "S1";  
        String s3 = "无锡--上海";  
        String s4 = "Category 2";  
        String s5 = "Category 3";  
        String s6 = "Category 4";  
        String s7 = "Category 5";  
        String s8 = "Category 6";  
        String s9 = "Category 7";  
        String s10 = "Category 8";  
        DefaultCategoryDataset defaultcategorydataset = new DefaultCategoryDataset();  
        defaultcategorydataset.addValue(1, s, s3);  
        defaultcategorydataset.addValue(4, s, s4);  
        defaultcategorydataset.addValue(3, s, s5);  
        defaultcategorydataset.addValue(5, s, s6);  
        defaultcategorydataset.addValue(5, s, s7);  
        defaultcategorydataset.addValue(7, s, s8);  
        defaultcategorydataset.addValue(7, s, s9);  
        defaultcategorydataset.addValue(8, s, s10);  
         JFreeChart chart = ChartFactory.createBarChart("Dual Axis Chart",  
                "Category", "Value", defaultcategorydataset, PlotOrientation.VERTICAL, false, true, false);  
            CategoryPlot categoryplot = (CategoryPlot)chart.getPlot();  
            categoryplot.setDomainAxisLocation(AxisLocation.BOTTOM_OR_RIGHT);  
            //CategoryDataset categorydataset =defaultcategorydataset_1;  
            //categoryplot.setDataset(1, categorydataset);  
            categoryplot.mapDatasetToRangeAxis(1, 1);  
            CategoryAxis categoryaxis = categoryplot.getDomainAxis();  
            categoryaxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);  
            NumberAxis numberaxis = new NumberAxis("Secondary");  
            categoryplot.setRangeAxis(1, numberaxis);  
            LineAndShapeRenderer lineandshaperenderer =new LineAndShapeRenderer();  
           // lineandshaperenderer.setToolTipGenerator(new StandardCategoryToolTipGenerator());  
            lineandshaperenderer.setBaseLinesVisible(true);  
//            lineandshaperenderer.setShapesFilled(true);  
//            lineandshaperenderer.setShapesVisible(true);  
//            lineandshaperenderer.setItemLabelsVisible(true);  
            categoryplot.setRenderer(1, lineandshaperenderer);  
            categoryplot.setDatasetRenderingOrder(DatasetRenderingOrder.FORWARD);  
            LegendTitle legendtitle = new LegendTitle(categoryplot.getRenderer(0));  
            legendtitle.setMargin(new RectangleInsets(2D, 2D, 2D, 2D));  
            //legendtitle.setBorder(new BlockBorder());  
            LegendTitle legendtitle1 = new LegendTitle(categoryplot.getRenderer(1));  
            legendtitle1.setMargin(new RectangleInsets(2D, 2D, 2D, 2D));  
            //legendtitle1.setBorder(new BlockBorder());  
  
            BlockContainer blockcontainer = new BlockContainer(new BorderArrangement());  
            blockcontainer.add(legendtitle, RectangleEdge.LEFT);  
            blockcontainer.add(legendtitle1, RectangleEdge.RIGHT);  
            blockcontainer.add(new EmptyBlock(2000D, 0.0D));  
            CompositeTitle compositetitle = new CompositeTitle(blockcontainer);  
            compositetitle.setPosition(RectangleEdge.BOTTOM);  
            chart.addSubtitle(compositetitle);  
            ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());  
            //500是图片长度，300是图片高度  
//            HttpSession  session = request.getSession();  
//            String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, info, session);   
//            String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename; 
            String filename = "";
            String graphURL = "";
            report.setFilename(filename);  
            report.setGraphURL(graphURL);  
            return report;  
    }  
}
