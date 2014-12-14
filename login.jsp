<!DOCTYPE html>
<html lang= "ko">
	<head>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<%@page import="java.sql.*" %>
		<%!
				String id, password, name;
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
				id = request.getParameter("id");
				password = request.getParameter("password");
				sql = "select count(*) as result from members where id ='" + id + "' and password=password('" + password + "');";
				
				try {
			 		Class.forName("com.mysql.jdbc.Driver");
				 	conn = DriverManager.getConnection(host, user, pw);
				 	stmt = conn.createStatement();
				 	rs = stmt.executeQuery(sql);
				 	
				 	if (rs.next() == "true") {
				   		sql = "select name from members where id = '" + id + "');";
				   		rs = stmt.executeQuery(sql);
				   		name = rs.next();
				   		
				   		out.println("<form method=post action='show.jsp'>");
				   		out.println("<div class = 'title'><div>기자이름: " + name);
				   		out.println("<div>기사제목: <input type='text' class='inputTitle' name='title' /></div></div>");
				   		out.println("<div class = 'contents'><p>기사내용:</p><textarea name='detail'></textarea>");
				   		out.println("<div><input type='submit' class='inputButton' value='기사 저장'><input type='reset' class='resetButton' value='지우기'></div></div></form>");
		   		
			   		} else {
			   			out.println("<p>기자ID나 비밀번호가 일치하지 않습니다.</p>");
			   		}
				} catch (Exception e) {
				 	ok = false;
				 	out.println("<p>500 ERROR</p>");
				 	out.println(e.getMessage());
				}
			%>
		</div>
	</body>
</html>
