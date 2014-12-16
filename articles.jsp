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
	String sql;

	ResultSet rs;
	boolean ok = true;

	int aid, sid;
	String name, title, write_date;
%>
        <title>Let's study DB Basic</title>
        <link rel="stylesheet" href="index.css">

</head>

<body>
<div id = "wrap">
<h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
<nav>
	<ul>
		<li><a href="articles.jsp?sid=0">전체</a></li>
		<li><a href="articles.jsp?sid=1">정치</a></li>
		<li><a href="articles.jsp?sid=2">사회</a></li>
		<li><a href="articles.jsp?sid=3">경제</a></li>
		<li><a href="articles.jsp?sid=4">국제</a></li>
		<li><a href="articles.jsp?sid=5">문화</a></li>
		<li><a href="articles.jsp?sid=6">스포츠</a></li>
		<li><a href="articles.jsp?sid=7">과학</a></li>
	</ul>
</nav>
<p class = "inputLink"><a href="input.jsp">기사 쓰기</a></p>
<!-- request handle -->
<%
	request.setCharacterEncoding("UTF-8");
	sid = Integer.parseInt(request.getParameter("sid"));
%>

<!-- read from mysql -->
<%
        try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(host, user, pw);
                stmt = conn.createStatement();
                if (sid == 0) {
			sql="SELECT aid, sid, members.name, title, write_date, detail FROM articles INNER JOIN members ON articles.mid = members.mid order by write_date desc;";
			rs = stmt.executeQuery(sql);
		} else {
			sql="SELECT aid, sid, members.name, title, write_date, detail FROM articles INNER JOIN members ON articles.mid = members.mid where sid=" + sid + " order by write_date desc;";
			rs = stmt.executeQuery(sql);
		}
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
