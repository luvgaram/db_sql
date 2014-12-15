<!DOCTYPE html>
<html lang= "ko">
<head>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@page import="java.sql.*" %>
	<%!
		int aid, sid, mid;
		String name, title, detail, write_date;
		String host="jdbc:mysql://localhost/popidb";
		String user="popi";
		String pw="db1004";
		Connection conn;
		Statement stmt;
		PreparedStatement pstmt;
		String sql="SELECT aid, sid, members.name, title, detail, write_date FROM articles INNER JOIN members ON articles.mid = members.mid;";
		String insert="insert into articles(sid, mid, title, detail) values(?, ?, ?, ?)";
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
	sid = Integer.parseInt(request.getParameter("sid"));
	mid = Integer.parseInt(request.getParameter("mid"));
	title = request.getParameter("title");
	detail = request.getParameter("detail");
	out.println("<h3>" + title + "' 기사가 입력됐습니다.</h3>");
%>

<!-- read from mysql -->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();

		//insert
		pstmt = conn.prepareStatement(insert);
		pstmt.setInt(1, sid);
		pstmt.setInt(2, mid);
		pstmt.setString(3, title);
		pstmt.setString(4, detail);
		pstmt.execute();
		
		//select
		rs = stmt.executeQuery(sql);
		out.println("<table>");
		out.println("<tr><th>번호</th><th>기자이름</th><th>기사제목</th><th>시간</th>");
		while(rs.next()) {
			aid = rs.getInt("aid");
			name = rs.getString("name");
			title = rs.getString("title");
			write_date = rs.getString("write_date");
			out.println("<tr>");
			out.println("<td>" + aid + "</td><td>" + name + "</td><td><a href='detail.jsp?aid=" + aid + "'>" + title + "</a></td><td>" + write_date + "</td>");			
			out.println("<tr>");
		}
		
		out.println("</table>");

	} catch (Exception e) {
		ok = false;
		out.println("<p>500 ERROR</p>");
		out.println(e.getMessage());
	}
%>
</div>
</body>
</html>

