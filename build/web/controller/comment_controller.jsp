<%-- 
    Document   : comment_controller
    Created on : Jun 5, 2020, 1:15:36 PM
    Author     : Tommy
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            
            java.util.Date utilDate = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
            
            String id = request.getParameter("id");
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            String comment = request.getParameter("comment");
            
            String query = "INSERT INTO COMMENTS(ID, POST, COMMENTER, COMMENT, TIME, DATE) VALUES(?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.conn().prepareStatement(query);
            stmt.setInt(1, obj.getLastId("COMMENTS"));
            stmt.setString(2, id);
            stmt.setInt(3, realid);
            stmt.setString(4, comment);
            stmt.setTime(5, sqlTime);
            stmt.setDate(6, sqlDate);
            stmt.executeUpdate();
            response.sendRedirect("index");
            //response.sendRedirect("profile?id="+realid);
        %>
    </body>
</html>
