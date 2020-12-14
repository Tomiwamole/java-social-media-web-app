<%-- 
    Document   : sendmessage
    Created on : Jun 7, 2020, 9:12:43 PM
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
        <title>Send Message</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            int id = Integer.parseInt(request.getParameter("id").toString());
            
            java.util.Date utilDate = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
            
            String query = "INSERT INTO MESSAGES(ID, OWNER, MESSAGER, MESSAGE, DATE, TIME, STATUS) VALUES(?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.conn().prepareStatement(query);
            stmt.setInt(1, obj.getLastId("MESSAGES"));
            stmt.setInt(2, id);
            stmt.setInt(3, realid);
            stmt.setString(4, request.getParameter("message"));
            stmt.setDate(5, sqlDate);
            stmt.setTime(6, sqlTime);
            stmt.setInt(7, 0);
            stmt.execute();
            response.sendRedirect("chat?id="+id);

        %>
    </body>
</html>
