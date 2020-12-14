<%-- 
    Document   : styles.jsp
    Created on : Jun 2, 2020, 1:33:45 PM
    Author     : Tommy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" integrity="sha384-1CmrxMRARb6aLqgBO7yyAxTOQE2AKb9GfXnEo760AUcUmFx3ibVJJAzGytlQcNXd" crossorigin="anonymous"></script>

        <style>
            body{
                font-family: 'Nanum Pen Script', cursive;
                font-size: 40px;
                #background-image: radial-gradient(circle, purple, red, purple, white);
            }
            nav{
                font-size: 23px;
                font-weight: bold;
                margin: 0px;
                color: black;
            }
            nav .navbar-brand{
                font-size: 30px;
                text-align: left;
            }
            .heading{
                font-weight: bold;
                font-size: 60px;
                text-decoration: underline;
            }
            .form{
                text-decoration: none;
                margin: 50px;
                font-size: 20px;
            }
            .form .form-control{
                border-radius: 0px;
                border: 2px solid black;
                font-family: 'Nanum Pen Script', cursive;
                font-size: 20px;
                font-weight: bold;
            }
            .form-control:focus, .form-control:active{
                outline: none !important;
                box-shadow: none;
            }

            select{
                border-radius: 0px;
                border: 2px solid black;
                font-family: 'Nanum Pen Script', cursive;
                font-size: 20px;
                font-weight: bold;
            }

            .form label{
                font-family: 'Nanum Pen Script', cursive;
                font-size: 30px;
                font-weight: bold;
            }
            .form .submit{
                font-size: 30px;
            }
            .posts{
                font-size: 20px;
                margin-top: 30px;
            }
            .card{
                margin-bottom: 15px;
            }
            .poster, .poster:hover, .poster:active, .poster:visited{
                font-weight: bold;
                text-decoration: none;
                color: inherit
            }
            .poster:hover{
                text-decoration: underline;
            }
            .comments{
                text-align: right;
                font-size: 16px;
                line-height: 30px;
            }
            .chat{
                margin: 20px;
                line-height: 23px;
            }
            .chate{
                margin-bottom: 30px;
            }
            .nolink{
                color: black;
                text-decoration: none;
            }
        </style>


    </head>
</html>
