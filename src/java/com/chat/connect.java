package com.chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class connect {
    
    public Connection conn(){
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection cons = DriverManager.getConnection("jdbc:derby://localhost:1527/chat", "root", "root");
            cons.commit();
            return cons;
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(connect.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
}
