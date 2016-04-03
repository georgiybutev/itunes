<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<!-- Prevent unauthorised access to the web application. -->
<%
if(session.getAttribute("privileges") == null){
	pageContext.forward("Unauthorised.jsp");
}
%>

<%
/* Initialise file related variables. */
Boolean multipart;
FileItemFactory fileFactory;
ServletFileUpload servletUpload;
List files;
Iterator iterator;
File file;
FileItem item;
String fieldName = "";
String fileName = "";
String contentType = "";
Long fileSize;

/* Check whether the file was submitted using the multipart/form-data HTML form. */
multipart = ServletFileUpload.isMultipartContent(request);

/* Process the data only if it is a file. */
if(multipart){
	/* Store the file temporary in the memory. */
	fileFactory = new DiskFileItemFactory();
	/* Used to handle multiple files. */
	servletUpload = new ServletFileUpload(fileFactory);
	files = servletUpload.parseRequest(request);
	/* Get all form submitted files. */
	iterator = files.iterator();
	item = (FileItem) iterator.next();
	/* Get the submitted file's field name. */
	fieldName = item.getFieldName();
	/* Get the submitted file's original name. */
	fileName = item.getName();
	/* Get the submitted file's MIME type (e.g. JPEG, PNG, GIF). */
	contentType = item.getContentType();
	/* Get the submitted file's size in bytes. */
	fileSize = item.getSize();
	//out.println(fieldName + fileName + contentType);
	/* Get the storage path of the submitted file. */
	file = new File(config.getServletContext().getRealPath("/") + "img/"+ fileName);
	/* Store the file to the server's hard disk drive at the specified default img directory. */
	item.write(file);
	//out.println("<img src=\"img/" + fileName + "\" />");
} else {
	/* No file was selected for upload. */
	out.println("Please select a file first.");
}

%>

<jsp:forward page="Admin.jsp" />