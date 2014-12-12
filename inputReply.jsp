<html lang= "ko">
<head>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@page import="java.sql.*" %>
        <%!
                int aid;
                String author, detail, write_date;
                String host="jdbc:mysql://localhost/popidb";
                String user="popi";
                String pw="db1004";
                Connection conn;
                Statement stmt;
                PreparedStatement pstmt;
                String sql;
		String insert="insert into replies(author, detail, aid) values(?, ?, ?)";
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
	request.setCharacterEncoding("UTF-8");
	aid = Integer.parseInt(request.getParameter("aid"));
	author = request.getParameter("author");
	detail = request.getParameter("detail");
	out.println("<h3>" + author + "님의 댓글이 " + aid + "번 기사에 입력됐습니다.</h3>");
	out.println("<p class = 'back'><a href='detail.jsp?aid=" + aid + "'>돌아가기</a></p>");
	sql="select * from replies where aid=" + aid + " order by write_date desc";
%>

<!-- read from mysql -->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();
		
		//insert
		pstmt = conn.prepareStatement(insert);
		pstmt.setString(1, author);
		pstmt.setString(2, detail);
		pstmt.setInt(3, aid);
		pstmt.execute();

		//select
		rs = stmt.executeQuery(sql);
		out.println("<table>");	
		out.println("<tr><th>이름</th><th>시간</th><th>댓글내용</th>");
		while(rs.next()) {
			author = rs.getString("author");
			detail = rs.getString("detail");
			write_date = rs.getString("write_date");
			out.println("<tr>");
			out.println("<td>" + author + "</td><td>" + write_date + "</td><td>" + detail + "</td>");			
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
