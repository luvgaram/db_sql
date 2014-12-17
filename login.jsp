<!DOCTYPE html>
<html lang= "ko">
	<head>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<%@page import="java.sql.*" %>
		<%!
				int mid;
				String id, password, name, sessionId;
				boolean check;
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
			<h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
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
				 	rs.next();
					out.println(rs.getString("result"));
					check = rs.getString("result").equals("1");
				 	if (check) {
				   		sql = "select * from members where id = '" + id + "';";
				   		rs = stmt.executeQuery(sql);
						rs.next();
				   		name = rs.getString("name");
				   		mid = rs.getInt("mid");

						// session을 mid로 설정
						sessionId = String.valueOf(mid);
						out.println(sessionId);
						session.setAttribute("sessionId", sessionId);
						response.sendRedirect("manage.jsp");
		   		
			   		} else {%>
						<script>
			   				alert("기자ID나 비밀번호가 일치하지 않습니다");
						</script>
			<%
			   			response.sendRedirect("login.html");
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
