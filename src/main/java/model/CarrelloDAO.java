package model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CarrelloDAO {

    public ArrayList<Carrello> doRetrieveAll(){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT * FROM Carrello");
            ResultSet rs = ps.executeQuery();
            ArrayList<Carrello> carts = new ArrayList<>();

            while (rs.next()){
                Carrello c = new Carrello();
                c.setEmail(rs.getString(1));
                c.setProducts(this.doRetrieveProductsCart(rs.getInt(2)));
                c.setQuantity(rs.getInt(3));

                carts.add(c);
            }
            return carts;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public ArrayList<Carrello> doRetrieveByEmail(String email){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT * FROM Carrello WHERE emailUtente=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            ArrayList<Carrello> carts = new ArrayList<>();

            while (rs.next()){
                Carrello c = new Carrello();
                c.setEmail(rs.getString(1));
                c.setProducts(this.doRetrieveProductsCart(rs.getInt(2)));
                c.setQuantity(rs.getInt(3));

                carts.add(c);
            }
            return carts;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    private Prodotto doRetrieveProductsCart(int id){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT idProdotto p, nome p, prezzo p, immagine p, nomeCategoria p FROM carrello c, prodotto p WHERE c.idProdotto = p.id AND p.id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            Prodotto p = new Prodotto();

            while (rs.next()) {
                p.setId(rs.getInt(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setImage(rs.getString(4));
                p.setNameCategory(rs.getString(5));
            }
            return p;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doInsert(String email, int id, int quantity) throws IOException {
        try (Connection con = ConPool.getConnection()) {

            if(this.checkCart(email, id)){
                int total =  this.getQuantity(email, id) + quantity;
                PreparedStatement ps = con.prepareStatement("UPDATE Carrello SET quantita=? WHERE emailUtente=? AND idProdotto=?");
                ps.setInt(1, total);
                ps.setString(2, email);
                ps.setInt(3, id);

                return ps.executeUpdate();
            }else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO Carrello (emailUtente, idProdotto, quantita) VALUES (?, ?, ?)");
                ps.setString(1, email);
                ps.setInt(2, id);
                ps.setInt(3, quantity);

                return ps.executeUpdate();
            }
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int getQuantity(String email, int id){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT quantita FROM Carrello WHERE emailUtente=? AND idProdotto=?");
            ps.setString(1, email);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();

            int quantity = 0;
            while(rs.next())
                quantity = rs.getInt(1);
            
            return quantity;
        } catch (SQLException s) {
           throw new RuntimeException(s);
        }
    }

    private boolean checkCart(String email, int id){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT idProdotto FROM Carrello WHERE emailUtente=? AND idProdotto=?");
            ps.setString(1, email);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();

            return rs.next();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doDelete(int id, String email) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM Carrello WHERE idProdotto = ? AND emailUtente = ?");
            ps.setInt(1, id);
            ps.setString(2, email);

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int changeQuantity(int id, String email, int quantity){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("UPDATE Carrello SET quantita=? WHERE emailUtente=? AND idProdotto=?");
            ps.setInt(1, quantity);
            ps.setString(2, email);
            ps.setInt(3, id);

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doDeleteByEmail(String email) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM Carrello WHERE emailUtente=?");
            ps.setString(1, email);

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }
}