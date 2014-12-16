<!DOCTYPE html>
<html lang= "ko">
        <head>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <title>Let's study DB Basic</title>
                <link rel="stylesheet" href="index.css">
        </head>

        <body>
                <div id = "wrap">
                        <h1><a href="articles.jsp?sid=0"><img src="logo.png"></a></h1>
			<% session.invalidate(); %>
			<p>로그아웃되었습니다.</p>
		</div>
	</body>
</html>

