<!DOCTYPE html>
<html lang= "ko">
        <head>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <%@page import="java.sql.*" %>
                <%!
                                int mid, sid;
                                String id, password, name, sessionId, aid, title, detail;
                                boolean check;
                                String host="jdbc:mysql://localhost/popidb";
                                String user="popi";
                                String pw="db1004";
                                Connection conn;
                                Statement stmt;
                                PreparedStatement pstmt;
                                String sql;
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
				aid = request.getParameter("aid");
				sid = Integer.parseInt(request.getParameter("sid"));
				title = request.getParameter("title");
				detail = request.getParameter("detail");
				if (sessionId == null || sessionId.equals("")) {
					response.sendRedirect("login.html");
				} else {
					mid = Integer.parseInt(sessionId);
					aid = request.getParameter("aid");
					sql = "update articles set sid=(?), title=(?), detail=(?) where aid=(?) and mid=(?)";			

                                	try {
                                        	Class.forName("com.mysql.jdbc.Driver");
                                        	conn = DriverManager.getConnection(host, user, pw);
                                        	stmt = conn.createStatement();
						
						//update
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, sid);
						pstmt.setString(2, title);
						pstmt.setString(3, detail);
						pstmt.setString(4, aid);
						pstmt.setInt(5, mid);
						pstmt.executeUpdate();
                                	
			%>
			<script>
				alert("기사를 수정했습니다.");
				location.href="manage.jsp";
			</script>
			<%
					} catch (Exception e) {
			%>
			<%
                                        	ok = false;
                                        	out.println("<p>500 ERROR</p>");
                                        	out.println(e.getMessage());
                                	}
				}
			%>
		</div>
	</body>
</html>
