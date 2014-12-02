<!DOCTYPE html>
<html lang= "ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<%!
	String name = "";
	String msg = "";
	String host="jdbc:mysql://localhost/popidb";
	String user="popi";
	String pw="db1004";
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	String sql="select * from line_memo order by msg_time desc";
	String insert="insert into line_memo(name,msg) values(?,?)";
	ResultSet rs;
	boolean ok = true;
%>
</head>

<body>
<h1>한줄 메모장</h1>
<!-- request handle -->
<%
	request.setCharacterEncoding("UTF-8");
	name = request.getParameter("name");
	msg = request.getParameter("msg");
	out.println("<h1>message from post: " + name + ", " + msg + "</h1>");
%>

<!-- read from mysql -->
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(host, user, pw);
		stmt = conn.createStatement();

		//insert
		pstmt = conn.prepareStatement(insert);
		pstmt.setString(1, name);
		pstmt.setString(2, msg);
		pstmt.execute();
		
		//select
		rs = stmt.executeQuery(sql);
		out.println("<table border = '1'");
		out.println("<tr><th>이름</th><th>메세지</th><th>시간</th>");
		while(rs.next()) {
			name = rs.getString("name");
			msg = rs.getString("msg");
			String time = rs.getString("msg_time");
			out.println("<tr>");
			out.println("<td>" + name + "</td><td>" + msg + "</td><td>" + time + "</td>");
			out.println("<tr>");
		}
		
		out.println("</table>");

	} catch (Exception e) {
		ok = false;
		out.println("<p>500 ERROR</p>");
		out.println(e.getMessage());
	}
%>
</body>
</html>
