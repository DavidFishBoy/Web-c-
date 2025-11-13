/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author toite
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DBConnect; 

public class LienHeDAO {

    Connection con = null;
    PreparedStatement ps = null;

    public boolean themLienHe(String ten, String email, String noiDung) {
        String query = "INSERT INTO LienHe (TenNguoiGui, Email, NoiDung) VALUES (?, ?, ?)";
        
        try {
            con = DBConnect.getConnection(); 
            ps = con.prepareStatement(query);
            ps.setString(1, ten);
            ps.setString(2, email);
            ps.setString(3, noiDung);
            
            int result = ps.executeUpdate();
            
            ps.close();
            con.close();
            
            return result > 0;             
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
