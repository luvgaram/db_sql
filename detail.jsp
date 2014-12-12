<html lang= "ko">
<head>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@page import="java.sql.*" %>
        <%!
                int aid;
                String author, title, detail, write_date;
                String host="jdbc:mysql://localhost/popidb";
                String user="popi";
                String pw="db1004";
                Connection conn;
                Statement stmt;
                PreparedStatement pstmt;
                String sql;
                ResultSet rs;
                boolean ok = true;
        %>
        <title>Let's study DB Basic</title>
        <link rel="stylesheet" href="index.css">
</head>

<body>
<div id = "wrap">
<h1><img src="logo.png"></h1>

<%	
	sql="select * from articles where aid=" + request.getParameter("aid");
	request.setCharacterEncoding("UTF-8");
	aid = Integer.parseInt(request.getParameter("aid"));
//	out.println("<h1>sql: " + sql + "</h1>");
%>

<!-- read from mysql -->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();
		
		//select
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			author = rs.getString("author");
			title = rs.getString("title");
			write_date = rs.getString("write_date");
			detail = rs.getString("detail");
			out.println("<article>");
			out.println("<h3> 제목: " + title + "</h3>");
			out.println("<p>기사번호: " + aid + ", 기자이름: " + author + ", 작성일: " + write_date + "</p>");
			out.println("<p>" + detail + "</p></article>");
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
