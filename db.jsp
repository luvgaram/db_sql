<!DOCTYPE html>
<html lang= "ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<%!
	String host="jdbc:mysql://localhost/popidb";
	String user="popi";
	String pw="db1004";
	Connection conn;
	Statement stmt;
	String sql="select * from stu";
	ResultSet rs;
	boolean ok = true;
%>
</head>

<body>
<h1>Hello, JSP</h1>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		out.println("<table border = '1'");
		out.println("<tr><th>id</th><th>이름</th><th>교수</th>");
		while(rs.next()) {
			int id = rs.getInt(1);
			String name = rs.getString("name");
			int pid = rs.getInt("pid");
			out.println("<tr>");
			out.println("<td>" + id + "</td><td>" + name + "</td><td>" + pid + "</td>");
			out.println("<tr>");
		}
		
		out.println("</table>");

	} catch (Exception e) {
		ok = false;
		out.println("<p>500 ERROR</p>");
		out.println(e.getMessage());
	}
%>
</body>
</html>
