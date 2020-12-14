<%-- 
    Document   : chat
    Created on : Jun 3, 2020, 6:10:40 PM
    Author     : Tommy
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            String id = request.getParameter("id");
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            List arr = obj.getUser("*", "ID", id);

        %>
        <jsp:include page="styles"></jsp:include>
        <title><%=arr.get(1)%>'s Message</title>

    </head>
    <body>
        <jsp:include page="navbar"></jsp:include>
            <div class="container posts">
                <div class="row">
                <jsp:include page="sideprofile"></jsp:include>

                    <div class="col-md-6" style="overflow:auto;">
                        <div class="card">

                            <div class="card-header" style="padding: 7px;">
                                <b> <a href="messages" class="nolink">&lt; Back</a> </b>
                                <div class="text-center" style="font-size: 25px;">
                                    <b><%=arr.get(1)%></b>

                                <%
                                    if (Integer.parseInt(String.valueOf(arr.get(7))) == 1) {
                                %>
                                &nbsp;<i class="fa fa-signal" style="color: green"></i>
                                <%
                                    }
                                %>

                                <br>
                            </div>
                        </div>

                        <div class="card-body" style="padding: 7px;">

                            <div class="chat">

                                <%
                                    String query = "SELECT * FROM MESSAGES WHERE OWNER = " + realid + " AND MESSAGER = " + id + " "
                                            + "OR MESSAGER = " + realid + " AND OWNER = " + id + " ORDER BY ID ASC";
                                    int count = obj.getTotalRows(obj.select(query));
                                    if (count == 0) {
                                %>
                                Be the First to send a message
                                <%
                                } else {
                                    ResultSet rs = obj.select(query);
                                    String align = "";
                                    while (rs.next()) {
                                    //out.print(rs.getInt("MESSAGER"));
                                        if (rs.getInt("MESSAGER") == realid) {
                                            align = "right";
                                        } else {
                                            align = "left";
                                        }
                                        arr = obj.getUser("*", "ID", rs.getString("MESSAGER"));

                                %>
                                <div style="text-align: <%=align%>" class="chate">
                                    <b><a href="profile?id=<%=arr.get(0)%>" class="nolink"><%=arr.get(1)%></a></b><br>
                                    [<%=rs.getString("MESSAGE")%>]<br>
                                    <b><%=rs.getString("DATE")%>  <%=rs.getString("TIME")%></b>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            
                            <form action="sendmessage?id=<%=id%>" method="post">
                                <div class="input-group chate">
                                    <input class="form-control" type="search" placeholder="Send a message" name="message" autocomplete="off">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary" type="submit"><i class="fa fa-bolt"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
