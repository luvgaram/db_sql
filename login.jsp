<!DOCTYPE html>
<html lang= "ko">
	<head>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<%@page import="java.sql.*" %>
		<%!
				String mid;
				String password;
				String host="jdbc:mysql://localhost/popidb";
				String user="popi";
				String pw="db1004";
				Connection conn;
				Statement stmt;
				PreparedStatement pstmt;
				String sql="select * from users";
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
				 mid = request.getParameter("mid");
				 password = request.getParameter("password");
				 select = "select count(*) as result from users where mid =" + mid + " and password=password('" + password + "');";
				 rs = stmt.executeQuery(sql);

				 out.println("<h3>" + rs + "</h3>");
			%>
		</div>
	</body>
</html>
