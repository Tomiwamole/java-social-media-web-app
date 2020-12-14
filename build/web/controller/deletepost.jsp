<%-- 
    Document   : deletepost
    Created on : Jun 5, 2020, 9:52:07 PM
    Author     : Tommy
--%>

<%@page import="java.sql.Statement"%>
<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
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
            String id = request.getParameter("id");
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            
            String query = "DELETE FROM POST WHERE ID = "+id;
            Statement stmt = conn.conn().createStatement();
            stmt.execute(query);
            
            query = "DELETE FROM COMMENTS WHERE POST = "+id;
            stmt = conn.conn().createStatement();
            stmt.execute(query);
            
            query = "DELETE FROM LIKES WHERE POST = "+id;
            stmt = conn.conn().createStatement();
            stmt.execute(query);
            
            response.sendRedirect("profile?id="+realid);
            
        %>
    </body>
</html>
