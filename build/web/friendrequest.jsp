<%-- 
    Document   : friendrequest
    Created on : Jun 3, 2020, 9:20:13 PM
    Author     : Tommy
--%>

<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
        %>
        <jsp:include page="styles"></jsp:include>
            <title>Tom Chat | Friend Requests</title>

        </head>
        <body>
        <jsp:include page="navbar"></jsp:include>
            <div class="container posts">
                <div class="row">
                <jsp:include page="sideprofile"></jsp:include>

                    <div class="col-md-6" style="overflow:auto;">
                        <div class="card">
                            <div class="card-header" style="padding: 7px;">
                                <div class="text-center" style="font-size: 30px;">
                                    <b>Friend Requests</b><br>
                                    <small><a href="confirm_request_controller?id=0">Confirm All</a> | <a href="#">Delete All</a></small>
                                </div>
                            </div>
                            <div class="card-body" style="padding: 7px;">
                                <ul class="list-group list-group-flush" style="border:0px solid white">
                                <%
                                    String query = "SELECT * FROM REQUESTS WHERE \"SECOND\" = " + realid;
                                    ResultSet rs = obj.select(query);
                                    if (obj.getTotalRows(rs) == 0) {
                                %>
                                <br>
                                <div class="text-center"><h2 style="font-weight: bold;">No friend requests yet </h2></div>
                                <%
                                } else {
                                    rs = obj.select(query);
                                    while (rs.next()) {
                                        int other = rs.getInt("FIRST");
                                        List arr = obj.getUser("*", "ID", String.valueOf(other));
                                %>
                                <li class="list-group-item">-><a href="profile?id=<%=arr.get(1)%>" class="nolink"><%=arr.get(1)%></a> &nbsp;<a href="confirm_request_controller?id=<%=arr.get(0)%>">Confirm</a> | <a href="#">Delete</a> </li>
                                    <%
                                            }
                                        }
                                    %>
                            </ul>
                        </div>
                    </div>
                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
