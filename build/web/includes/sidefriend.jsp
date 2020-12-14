<%-- 
    Document   : sidefriend
    Created on : Jun 3, 2020, 5:11:24 PM
    Author     : Tommy
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="col-md-3" style="text-align: right;">
            <div>
                <span class="poster">Active Friends</span><br>
                <ul class="list-group list-group-flush" style="border:0px solid white">
                    <%
                        String query = "SELECT * FROM FRIENDS WHERE FRIEND = " + realid + "";
                        ResultSet rs = obj.select(query);
                        int count = obj.getTotalRows(rs);
                        if (count == 0) {
                    %>
                    <br>
                    <div class="text-center"><h4 style="font-weight: bold;">No friends active yet</h4></div>
                    <%
                    } else {
                        Statement stmt = conn.conn().createStatement();
                        stmt.setMaxRows(10);
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            String user = rs.getString("USER");
                            List arr = obj.getUser("*", "ID", user);
                            count = 0;
                            if (Integer.parseInt(arr.get(7).toString()) != 0) {
                                count++;
                    %>
                    <li class="list-group-item"><a href="profile?id=<%=arr.get(0)%>"><%=arr.get(1)%></a>&nbsp;<i class="fa fa-signal" style="color: green"></i> </li>
                        <%
                            }
                            if (count == 0) {
                        %>
                    <br>
                    <div class="text-center"><h4 style="font-weight: bold; font-style: italic">No Friends Found</h4></div>
                    <%
                                }
                            }
                        }
                    %>
                </ul>
            </div><br>

            <div>
                <span class="poster"><a href="friendrequest" class=" nolink">Friend Requests</a></span><br>
                <ul class="list-group list-group-flush" style="border:0px solid white">
                    <%
                        query = "SELECT * FROM REQUESTS WHERE \"SECOND\" = " + realid;
                        rs = obj.select(query);
                        if (obj.getTotalRows(rs) == 0) {
                    %>
                    <br>
                    <div class="text-center"><h4 style="font-weight: bold;">No friend requests yet </h4></div>
                    <%
                    } else {
                        Statement stmt = conn.conn().createStatement();
                        stmt.setMaxRows(10);
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            int other = rs.getInt("FIRST");
                            List arr = obj.getUser("*", "ID", String.valueOf(other));
                    %>
                    <li class="list-group-item"><a href="profile?id=<%=arr.get(0)%>" class="nolink"><%=arr.get(1)%></a> &nbsp;<a href="confirm_request_controller?id=<%=arr.get(0)%>">Confirm</a> | <a href="#">Delete</a> </li>
                        <%
                                }
                            }
                        %>
                </ul>
            </div><br>

            <div>
                <span class="poster"><a href="people" class="nolink">Friends</a></span><br>
                <ul class="list-group list-group-flush" style="border:0px solid white">
                    <%
                        query = "SELECT * FROM FRIENDS WHERE FRIEND = " + realid + "";
                        //out.print(query);
                        rs = obj.select(query);
                        count = obj.getTotalRows(rs);
                        if (count == 0) {
                    %>
                    <br>
                    <div class="text-center"><h4 style="font-weight: bold;">No friends yet </h4></div>
                    <%
                    } else {
                        Statement stmt = conn.conn().createStatement();
                        stmt.setMaxRows(10);
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            String user = rs.getString("USER");
                            List arr = obj.getUser("*", "ID", user);
                    %>
                    <li class="list-group-item"><a href="profile?id=<%=arr.get(0)%>" class="nolink"><%=arr.get(1)%></a></li>
                        <%
                                }

                            }

                        %>
                </ul>
            </div><br>
        </div>
    </body>
</html>
