package model;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    public List<Prodotto> doRetrieveAll() {

        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("select id, nome, prezzo, immagine, nomeCategoria from prodotto");
            ResultSet rs = ps.executeQuery();
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            while (rs.next()){
                Prodotto p = new Prodotto();
                p.setId(rs.getInt(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setImage(rs.getString(4));
                p.setNameCategory(rs.getString(5));

                prodotti.add(p);
            }
            return prodotti;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doInsert(Prodotto p) throws IOException {

        int result;
            try (Connection con = ConPool.getConnection()) {

                PreparedStatement ps = con.prepareStatement("INSERT INTO prodotto (nome, prezzo, immagine, descrizione, nomeCategoria) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, p.getName());
                ps.setDouble(2, p.getPrice());
//                ps.setBlob(3, p.getImage());
                ps.setString(3,p.getImage());
                ps.setString(4, p.getDescription());
                ps.setString(5, p.getNameCategory());

                return result = ps.executeUpdate();
            } catch (SQLException s) {
                throw new RuntimeException(s);
            }
    }

    public ArrayList<String> getCategories() {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT nome FROM Categoria");

            ResultSet rs = ps.executeQuery();
            ArrayList<String> categories = new ArrayList<>();
            while (rs.next()) {
               categories.add(rs.getString(1));
            }
            return categories;
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public Prodotto doRetrieveById(int id) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT id, nome, prezzo, immagine, descrizione, nomeCategoria FROM Prodotto WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            Prodotto p = new Prodotto();
            while (rs.next()) {
                p.setId(rs.getInt(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setImage(rs.getString(4));
                p.setDescription(rs.getString(5));
                p.setNameCategory(rs.getString(6));
            }
            return p;
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doUpdate(Prodotto p) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotto SET nome = ?, prezzo = ?, descrizione = ?, nomeCategoria = ? WHERE id = ?");
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getNameCategory());
            ps.setInt(5, p.getId());

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doDelete(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE id = ?");
            ps.setInt(1, id);

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public void doDeleteByCategory(String nameCat) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE nomeCategoria = ?");
            ps.setString(1, nameCat);

            ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }
}
