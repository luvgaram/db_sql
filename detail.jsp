<html lang= "ko">
<head>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@page import="java.sql.*" %>
        <%!
                int aid;
                String name, title, detail, write_date;
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
<h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
<p class="inputLink"><a href="articles.jsp?sid=0">돌아가기</a></p>
<%	
	aid = Integer.parseInt(request.getParameter("aid"));
	sql="select aid, sid, members.name, title, detail, write_date from articles INNER JOIN members ON articles.mid = members.mid where aid=" + aid;
	request.setCharacterEncoding("UTF-8");
%>

<!-- read from mysql - articles-->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();
		
		//select
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			name = rs.getString("name");
			title = rs.getString("title");
			write_date = rs.getString("write_date");
			detail = rs.getString("detail");
			out.println("<article>");
			out.println("<h3> 제목: " + title + "</h3>");
			out.println("<p class='detailTitle'>기사번호: " + aid + ", 기자이름: " + name + ", 작성일: " + write_date + "</p></br>");
			out.println("<p class='detailDetail'>" + detail + "</p></article>");
		}
		
	} catch (Exception e) {
		ok = false;
		out.println("<p>500 ERROR</p>");
		out.println(e.getMessage());
	}
	out.println("<form method = post action = 'inputReply.jsp?aid=" + aid + "'>");
%>
<div class="reply">

<div class="title">
	<div>이름: <input type="text" class="inputAuthor" name="author" /></div>
	<div>댓글: <input type="text" class="inputTitle" name="detail" /></div>
	<div><input type="submit" class="inputReply" value="저장"></div>
</div>
</form>

<!-- read from mysql - replies -->
<%
	try {
		sql = "select * from replies where aid=" + aid + " order by write_date desc";
		rs = stmt.executeQuery(sql);
		out.println("<table>");	
		while(rs.next()) {
			name = rs.getString("author");
			detail = rs.getString("detail");
			write_date = rs.getString("write_date");
			out.println("<tr>");
			out.println("<td>" + name + "</td><td>" + write_date + "</td><td>" + detail + "</td>");			
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
</div>
</body>
</html>
