<%-- 
    Document   : confirn_request_controller
    Created on : Jun 5, 2020, 2:29:26 PM
    Author     : Tommy
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
            int id = Integer.parseInt(request.getParameter("id").toString());
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            String query = "";
            int other;
            ResultSet rs;

            if (id == 0) {
                query = "SELECT * FROM REQUESTS WHERE \"SECOND\" = " + realid;
                rs = obj.select(query);
                while (rs.next()) {
                    other = rs.getInt("FIRST");
                    
                    query = "DELETE FROM REQUESTS WHERE \"SECOND\" = " + realid + " AND \"FIRST\" = " + other;
                    Statement stmt = conn.conn().createStatement();
                    stmt.execute(query);

                    query = "SELECT * FROM REQUESTS WHERE \"SECOND\" = " + other + " AND \"FIRST\" = " + realid;
                    int count = obj.getTotalRows(obj.select(query));
                    if (count != 0) {
                        query = "DELETE FROM REQUESTS WHERE \"SECOND\" = " + other + " AND \"FIRST\" = " + realid;
                        stmt = conn.conn().createStatement();
                        stmt.execute(query);
                    }

                    query = "INSERT INTO FRIENDS (ID, \"USER\", FRIEND) VALUES (" + obj.getLastId("FRIENDS") + ", " + other + ", " + realid + ")";
                    stmt.execute(query);

                    query = "INSERT INTO FRIENDS (ID, \"USER\", FRIEND) VALUES (" + obj.getLastId("FRIENDS") + ", " + realid + ", " + other + ")";
                    stmt.execute(query);
                }
                response.sendRedirect("friendrequest");

            } else {
                query = "DELETE FROM REQUESTS WHERE \"SECOND\" = " + realid + " AND \"FIRST\" = " + id;
                Statement stmt = conn.conn().createStatement();
                stmt.execute(query);

                query = "SELECT * FROM REQUESTS WHERE \"SECOND\" = " + id + " AND \"FIRST\" = " + realid;
                int count = obj.getTotalRows(obj.select(query));
                if (count != 0) {
                    query = "DELETE FROM REQUESTS WHERE \"SECOND\" = " + id + " AND \"FIRST\" = " + realid;
                    stmt = conn.conn().createStatement();
                    stmt.execute(query);
                }

                query = "INSERT INTO FRIENDS (ID, \"USER\", FRIEND) VALUES (" + obj.getLastId("FRIENDS") + ", " + id + ", " + realid + ")";
                stmt.execute(query);

                query = "INSERT INTO FRIENDS (ID, \"USER\", FRIEND) VALUES (" + obj.getLastId("FRIENDS") + ", " + realid + ", " + id + ")";
                stmt.execute(query);

                response.sendRedirect("profile?id=" + id);
            }

            out.print(query);
        %>
    </body>
</html>
