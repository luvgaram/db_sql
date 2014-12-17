<!DOCTYPE html>
<html lang= "ko">
<head>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@page import="java.sql.*" %>
	<%!
		int aid, sid, mid;
		String sessionId, name, title, write_date;
		String host="jdbc:mysql://localhost/popidb";
		String user="popi";
		String pw="db1004";
		Connection conn;
		Statement stmt;
		PreparedStatement pstmt;
		String sql;
		String insert="insert into articles(sid, mid, title, detail) values(?, ?, ?, ?)";
		ResultSet rs;
		boolean ok = true;
	%>
	<title>Let's study DB Basic</title>
	<link rel="stylesheet" href="index.css">
</head>

<body>
<div id = "wrap">
<h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
<!-- request handle -->
<%
	request.setCharacterEncoding("UTF-8");
	
	sessionId = (String)session.getAttribute("sessionId");
	if (sessionId == null || sessionId.equals("")) {
		response.sendRedirect("login.html");
	} else {
		mid = Integer.parseInt(sessionId);
	}
%>

<p class="inputLink"><a href="input.jsp">기사 쓰기</a></p><p class="inputLink"><a href="logout.jsp">로그아웃</a></p>
<!-- read from mysql -->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();
		
		//select
		sql="SELECT aid, sid, members.name, title, detail, write_date FROM articles INNER JOIN members ON articles.mid = members.mid where articles.mid=" + mid + " order by write_date desc;";
		rs = stmt.executeQuery(sql);
		out.println("<table>");
		out.println("<tr><th>번호</th><th>기자이름</th><th>기사제목</th><th>시간</th><th>수정</th><th>삭제</th></tr>");
		while(rs.next()) {
			aid = rs.getInt("aid");
			name = rs.getString("name");
			title = rs.getString("title");
			write_date = rs.getString("write_date");
			out.println("<tr>");
			out.println("<td>" + aid + "</td><td>" + name + "</td><td class='manageTitle'><a href='detail.jsp?aid=" + aid + "'>" + title + "</a></td><td>" + write_date + "</td><td><a href='update.jsp?aid=" + aid + "'>수정</a></td><td><a href='delete.jsp?aid=" + aid + "'>삭제</a></td>");			
			out.println("</tr>");
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

