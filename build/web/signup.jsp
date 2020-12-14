<%-- 
    Document   : Signup
    Created on : Jun 2, 2020, 1:23:44 PM
    Author     : Tommy
--%>

<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="styles"></jsp:include>
            <title>Signup</title>
        </head>
        <body>
            <div style="margin-top: 10%">
                <div class="container" >
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <h1 class="text-center heading">Signup &nbsp;<i class="fa fa-user-o"></i></h1>
                            <div class="container">
                                <div class="form">
                                    <form method="post" action="signup_controller">
                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Full Name:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" autocomplete="on" placeholder="First Middle Last" name="name" required="">
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Email:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="email" class="form-control" autocomplete="on" placeholder="abc@xyz.123" name="email" required="">
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Username:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" autocomplete="on" placeholder="John Doe" name="username" required="">
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>About:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" autocomplete="on" placeholder="I am John Doe" name="about" required="">
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Password:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="password" class="form-control" autocomplete="on" name="password" required="">
                                            </div>
                                        </div>
                                        <!--
                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Birth Date:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="date" class="form-control" autocomplete="on" name="dob" required="" max="2007-01-01">
                                            </div>
                                        </div>
                                        -->

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Gender:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <select class="form-control" name="gender" required="">
                                                    <option value="1">Male</option>
                                                    <option value="2">Female</option>
                                                </select>
                                            </div>
                                        </div>

                                    <%
                                        if (session.getAttribute("logged") != null) {
                                            getStuff obj = new getStuff();
                                            String error = session.getAttribute("logged").toString();
                                            //out.print(error);
                                            boolean check = obj.checkInt(error);
                                            if (check == false) {
                                                if (error == "error1") {
                                    %>
                                    <div class="text-center" style="color:red; font-weight: bold; text-decoration: underline">
                                        Could not create account Please try again later😞😥
                                    </div>
                                    <%
                                    } else if (error == "error2") {
                                    %>
                                    <div class="text-center" style="color:red; font-weight: bold; text-decoration: underline">
                                        The email has been used before
                                    </div>
                                    <%
                                                }
                                                session.setAttribute("logged", "");
                                            }
                                        }
                                    %>



                                    <div class="" style="margin-bottom: 30px;">
                                        <div class="text-center">
                                            <br>
                                            <input type="submit" class="btn btn-secondary form-control submit" value="Sign Up...">
                                            <br><br>
                                            <h4>Already have an account? <a href="login">Login</a></h4>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"></div>

                </div>
            </div>
    </body>
</html>
