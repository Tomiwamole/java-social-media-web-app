/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chat;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tommy
 */
public class getStuff {

    public ResultSet select(String value) throws SQLException {
        String query = value;
        System.out.println(query);
        connect con = new connect();
        Statement stmt = con.conn().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        return rs;
    }

    public int getTotalRows(ResultSet rs) throws SQLException {
        int id = 0;
        while (rs.next()) {
            id++;
        }
        return id;
    }

    public int getLastId(String value) throws SQLException {
        connect con = new connect();
        String query = "SELECT * FROM " + value;
        Statement stmt = con.conn().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = stmt.executeQuery(query);
        if (rs.last()) {
            return rs.getInt("ID") + 1;
        } else {
            return 1;
        }
    }

    public boolean checkInt(String value) {
        boolean valid;
        try {
            Integer.parseInt(value);
            valid = true;
        } catch (NumberFormatException ex) {
            valid = false;
        }
        return valid;
    }

    public List getUser(String first, String second, String third) throws SQLException {
        connect con = new connect();
        String query = "SELECT " + first + " FROM USERS WHERE " + second + " = " + third;
        System.out.println(query);
        Statement stmt = con.conn().createStatement();
        ResultSet rs = stmt.executeQuery(query);
        ArrayList arr = new ArrayList();
        if (rs.next()) {
            arr.add(rs.getInt("ID"));
            arr.add(rs.getString("NAME"));
            arr.add(rs.getString("EMAIL"));
            arr.add(rs.getString("USERNAME"));
            arr.add(rs.getString("ABOUT"));
            arr.add(rs.getString("PASSWORD"));
            arr.add(rs.getInt("GENDER"));
            arr.add(rs.getInt("ACTIVE"));
        }
        return arr;
    }

    public String formatDate(Date dt, Time t) {
        
        java.util.Date utilDate = new java.util.Date();
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
        
        int minute1, minute2;
        
        SimpleDateFormat formatter = new SimpleDateFormat("mm");
        String strDate = formatter.format(t);
        minute1 = Integer.parseInt(strDate);
        
        formatter = new SimpleDateFormat("mm");
        strDate = formatter.format(sqlTime);
        minute2 = Integer.parseInt(strDate);
        
        System.out.println(minute2);
        

        return null;
    }

    public static void main(String[] args) throws SQLException, ParseException {

        getStuff obj = new getStuff();
        String dt = "31/12/1998";
        Date date = (java.sql.Date) new SimpleDateFormat("dd/MM/yyyy").parse(dt);
        
        String td = "09:09:09";
        java.sql.Time time = (java.sql.Time) new SimpleDateFormat("dd/MM/yyyy").parse(td);
        
        System.out.println(date);

        obj.formatDate(date, time);

    }

}
