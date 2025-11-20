package com.gestion.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.gestion.config.DatabaseConnection;

public class TestDBConnection {
    public static void main(String[] args) {
        try {
            Connection conn = DatabaseConnection.getInstance().getConnection();
            System.out.println("Connexion réussie !");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT table_name FROM information_schema.tables WHERE table_schema='gestion_produits'");
            System.out.println("Tables dans la base :");
            while(rs.next()) {
                System.out.println(rs.getString("table_name"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}