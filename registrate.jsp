<!DOCTYPE html>
<html lang= "ko">
        <head>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <%@page import="java.sql.*" %>
                <%!
                                String id, password, name;
                                boolean check;
                                String host="jdbc:mysql://localhost/popidb";
                                String user="popi";
                                String pw="db1004";
                                Connection conn;
                                Statement stmt;
                                String insert;
                                boolean ok = true;
                %>
                <title>Let's study DB Basic</title>
                <link rel="stylesheet" href="index.css">
        </head>
        <body>
                <div id = "wrap">
                        <h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
			<p class="inputLink"><a href="manage.jsp">기사관리</a></p>
			<p class="inputLink"><a href="logout.jsp">로그아웃</a></p>
			<!-- request handle -->
			<%
				request.setCharacterEncoding("UTF-8");
				name = request.getParameter("name");
				id = request.getParameter("id");
				password = request.getParameter("password");
                                try {
					insert = "insert into members(id, password, name) values ('" + id + "' , " + "PASSWORD('" + password + "'), '" + name + "');";
                                       	
					Class.forName("com.mysql.jdbc.Driver");
                                       	conn = DriverManager.getConnection(host, user, pw);
					stmt = conn.createStatement();
				 	stmt.execute(insert);
					
					session.invalidate();
				} catch (Exception e) {
                                       	ok = false;
                                       	out.println("<p>500 ERROR</p>");
                                       	out.println(e.getMessage());
                                }
			%>
		</div>
	</body>
</html>
