<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
    import="java.io.*,
            net.sf.jasperreports.engine.*,
            net.sf.jasperreports.engine.util.*,
            java.util.*,java.sql.*,
            net.sf.jasperreports.engine.export.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预览</title>
</head>
<body>
<%
	response.setContentType("text/html");
	response.setCharacterEncoding("utf-8");

	System.setProperty("java.awt.headless", "true");

	String id = request.getParameter("id");
	String type = request.getParameter("type");
	Map<String, Object> parameters = new HashMap<String, Object>();
	
	String path = null;
	if("file_handling".equals(type)){
		path = "common/template/file_handling.jasper";
		parameters.put("fileId", id);
	}else if("warrant_apply".equals(type)){
		path = "common/template/warrant_apply.jasper";
		parameters.put("id", id);
	}else{
		path = "common/template/warrant_in.jasper";
		parameters.put("id", id);
	}
	
    File reportFile = new File(application.getRealPath(path));
    JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile);  
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/water", "root", "zzx");
    JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);
    JRHtmlExporter exporter = new JRHtmlExporter();
    //request.getSession().setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE,exporter);
    
    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
    exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
    exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
    //exporter.setParameter(JRHtmlExporterParameter.FRAMES_AS_NESTED_TABLES, false);
    exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT,"pt"); //默认情况下用的是px,会导致字体缩小
    //exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath()+"/servlets/image?image=");
    //exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, request.getContextPath()+"/servlets/image?image=");
	//exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
	//exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,Boolean.TRUE); 
	
	exporter.exportReport();
%>
</body>
</html>