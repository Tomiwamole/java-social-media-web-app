<%-- 
    Document   : messages
    Created on : Jun 3, 2020, 5:29:22 PM
    Author     : Tommy
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
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
        <jsp:include page="styles"></jsp:include>
            <title>Tommy | Messages</title>

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
                                    <b>My Messages</b><br>
                                <%                                    String query = "SELECT DISTINCT MESSAGER FROM MESSAGES WHERE OWNER = " + realid + " AND STATUS = 0";
                                    int count = obj.getTotalRows(obj.select(query));

                                %>
                                <small>[<%=count%> unread]</small>
                            </div>
                        </div>
                        <div class="card-body" style="padding: 0px;">
                            <div>
                                <!--
                                <form method="post" action="" style="padding: 10px;">
                                    <input list="browsers"  class="form-control" placeholder="Select a friend to message" type="search" name="friend">
                                    <datalist id="browsers">
                                        
                                    </datalist>
                                </form> -->
                                <%
                                    query = "SELECT DISTINCT MESSAGER FROM MESSAGES WHERE OWNER = " + realid + " OR MESSAGER = " + realid + " AND STATUS = 0";
                                    count = obj.getTotalRows(obj.select(query));
                                    if (count == 0) {
                                %>
                                <br>
                                <div class="text-center"><h5 class="heading">No Messages Yet</h5></div>
                                <%
                                    }
                                %>
                                <ul class="list-group list-group-flush" style="border:0px solid white; padding: 5px;">
                                    <%
                                        List ids = new ArrayList();
                                        query = "SELECT * FROM MESSAGES WHERE OWNER = " + realid + " OR MESSAGER = " + realid + " ORDER BY ID DESC";
                                        ResultSet rs = obj.select(query);
                                        while (rs.next()) {
                                            int other = rs.getInt("MESSAGER");
                                            if (other == realid) {
                                                other = rs.getInt("OWNER");
                                            }
                                            if (ids.contains(other)) {
                                                continue;
                                            } else {
                                                ids.add(other);
                                            }
                                            List arr = obj.getUser("*", "ID", String.valueOf(other));

                                            query = "SELECT * FROM MESSAGES WHERE OWNER = " + realid + " AND MESSAGER = " + other + " "
                                                    + "OR MESSAGER = " + realid + " AND OWNER = " + other + " ORDER BY ID DESC";
                                            ResultSet res = obj.select(query);
                                            String message = "", date = "", time = "";
                                            int status = 0;
                                            while(res.next()){
                                                if(res.getInt("STATUS") == 0){
                                                    status = 0;
                                                    break;
                                                }
                                            }
                                            res = obj.select(query);
                                            if (res.next()) {
                                                message = res.getString("MESSAGE");
                                                date = res.getString("DATE");
                                                time = res.getString("time");
                                            }
                                    %>
                                    <li class="list-group-item" style="
                                        
                                        <%
                                            if(realid != res.getInt("MESSAGER")){
                                                if(res.getInt("STATUS") == 0){
                                                    %>
                                                     background-color: beige; 
                                                     <%
                                                }
                                            }
                                        %>
                                        
                                        margin-top: 10px; margin-bottom: 10px;">
                                        <b><a href="chat?id=<%=other%>" class="nolink"><%=arr.get(1)%></a> <%if (Integer.parseInt(arr.get(7).toString()) == 1) {%> &nbsp;<i class="fa fa-signal" style="color: green"></i> <% }%></b><br>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-8">
                                                [<%=message%>]
                                            </div>
                                            <div class="col-md-3 text-right">
                                                <%=time%>
                                            </div>
                                        </div>
                                    </li>
                                    <%
                                        }
                                    %>


                                </ul>
                            </div><br>
                        </div>
                    </div>
                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
