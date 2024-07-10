package model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class CategoriaDAO {

    public ArrayList<Categoria> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Categoria");
            ResultSet rs = ps.executeQuery();
            ArrayList<Categoria> categories = new ArrayList<>();
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setName(rs.getString(1));
                c.setDescription(rs.getString(2));

                categories.add(c);
            }
            return categories;
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public Categoria doRetrieveByName(String name) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Categoria WHERE nome = ?");
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            Categoria c = new Categoria();
            while (rs.next()) {
                c.setName(rs.getString(1));
                c.setDescription(rs.getString(2));
            }
            return c;
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public ArrayList<String> getCategoryName() {
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

    public int doInsert(Categoria c) throws IOException {
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("INSERT INTO Categoria (nome, descrizione) VALUES (?, ?)");
            ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doUpdate(Categoria c) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE Categoria SET descrizione = ? WHERE nome = ?");
            ps.setString(1, c.getDescription());
            ps.setString(2, c.getName());

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doDelete(String name) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM Categoria WHERE nome = ?");
            ps.setString(1, name);

            return ps.executeUpdate();
        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }
}
