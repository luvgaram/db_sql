<!DOCTYPE html>
<html lang= "ko">
        <head>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <%@page import="java.sql.*" %>
                <%!
                                int mid;
                                String id, password, name, sessionId, aid, title, detail;
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
			<p class="inputLink"><a href="manage.jsp">기사관리</a></p>
			<p class="inputLink"><a href="logout.jsp">로그아웃</a></p>
			<!-- request handle -->
			<%
				request.setCharacterEncoding("UTF-8");
                                sessionId = (String)session.getAttribute("sessionId");
				if (sessionId == null || sessionId.equals("")) {
					response.sendRedirect("login.html");
				} else {
					mid = Integer.parseInt(sessionId);
					aid = request.getParameter("aid");
					sql = "select aid, members.mid, members.name, title, detail from articles inner join members on articles.mid = members.mid where aid = '" + aid + "';";			

                                	try {
                                        	Class.forName("com.mysql.jdbc.Driver");
                                        	conn = DriverManager.getConnection(host, user, pw);
                                        	stmt = conn.createStatement();
                                        	rs = stmt.executeQuery(sql);
                                        	rs.next();
                                       		name = rs.getString("name");
                                        	mid = rs.getInt("mid");
						title = rs.getString("title");
						detail = rs.getString("detail");

                                        	out.println("<form method=post action='updated.jsp?aid=" + aid + "'>");
                                        	out.println("<div class='title'><div>기자이름: " + name);
                                       		out.println("<div>기사제목: <input type='text' class='inputTitle' name='title' value='" + title + "'/></div></div>");
                                        	out.println("<div class='author'>분류: <select name='sid'><option value='1'>정치</option><option value='2'>사회</option><option value='3'>경제</option><option value='4'>국제</option><option value='5'>문화</option><option value='6'>스포츠</option><option value='7'>과학</option></select>");
                                        	out.println("<div class='contents'><p>기사내용:</p><textarea name='detail'>" + detail + "</textarea>");
                                        	out.println("<div><input type='submit' class='inputButton' value='기사 저장'><input type='reset' class='resetButton' value='지우기'></div></div></form>");
                                	} catch (Exception e) {
                                        	ok = false;
                                        	out.println("<p>500 ERROR</p>");
                                        	out.println(e.getMessage());
                                	}
				}
			%>
		</div>
	</body>
</html>
