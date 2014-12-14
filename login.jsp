<!DOCTYPE html>
<html lang= "ko">
	<head>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<%@page import="java.sql.*" %>
		<%!
				String id;
				String password;
				String host="jdbc:mysql://localhost/popidb";
				String user="popi";
				String pw="db1004";
				Connection conn;
				Statement stmt;
				PreparedStatement pstmt;
				String sql;
				String select;
				ResultSet rs;
				boolean ok = true;
		%>
		<title>Let's study DB Basic</title>
		<link rel="stylesheet" href="index.css">
	</head>

	<body>
		<div id = "wrap">
			<h1><img src="logo.png"></h1>
			<!-- request handle -->
			<%
				request.setCharacterEncoding("UTF-8");
				mid = request.getParameter("id");
				password = request.getParameter("password");
				sql = "select count(*) as result from members where id ='" + id + "' and password=password('" + password + "');";
				
				try {
			 		Class.forName("com.mysql.jdbc.Driver");
				 	conn = DriverManager.getConnection(host, user, pw);
				 	stmt = conn.createStatement();
				 	rs = stmt.executeQuery(sql);
				 	
				 	out.println("<h3>" + rs + "</h3>");
				} catch (Exception e) {
				 	ok = false;
				 	out.println("<p>500 ERROR</p>");
				 	out.println(e.getMessage());
				}
			%>
		</div>
	</body>
</html>
