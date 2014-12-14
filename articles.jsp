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
	String sql="select * from articles order by write_date desc";
	ResultSet rs;
	boolean ok = true;

	int aid;
	String author;
	String title;
	String write_date;
%>
        <title>Let's study DB Basic</title>
        <link rel="stylesheet" href="index.css">

</head>

<body>
<div id = "wrap">
<h1><img src="logo.png"></h1>
<p class = "inputLink"><a href="login.html">기자 로그인</a></p>
<!-- read from mysql -->
<%
        try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(host, user, pw);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
                out.println("<table>");
                out.println("<tr><th>번호</th><th>기자이름</th><th>기사제목</th><th>시간</th>");
                while(rs.next()) {
                        aid = rs.getInt("aid");
                        author = rs.getString("author");
                        title = rs.getString("title");
                        write_date = rs.getString("write_date");
                        out.println("<tr>");
                        out.println("<td>" + aid + "</td><td>" + author + "</td><td><a href='detail.jsp?aid=" + aid + "'>" + title + "</a></td><td>" + write_date + "</td>");
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
