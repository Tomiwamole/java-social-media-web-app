<%-- 
    Document   : logout
    Created on : Jun 5, 2020, 5:42:47 PM
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
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            
            String query = "UPDATE USERS SET ACTIVE = 0 WHERE ID = "+realid;
            Statement stmt = conn.conn().createStatement();
            stmt.executeUpdate(query);
            
            session.removeAttribute("logged");
            response.sendRedirect("login");
        %>
    </body>
</html>
