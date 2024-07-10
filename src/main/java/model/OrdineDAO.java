package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {
    public List<Ordine> doRetrieveAll(){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT id, data, totale, citta, via, num_civico, provincia, cap, emailUtente FROM ordine");
            ResultSet rs = ps.executeQuery();
            ArrayList<Ordine> orders = new ArrayList<>();

            while (rs.next()){
                Ordine o = new Ordine();
                o.setId(rs.getInt(1));
                o.setDate(rs.getDate(2));
                o.setTotal(rs.getDouble(3));
                o.setCity(rs.getString(4));
                o.setVia(rs.getString(5));
                o.setHouse_number(rs.getString(6));
                o.setProvince(rs.getString(7));
                o.setCap(rs.getString(8));
                o.setEmail_user(rs.getString(9));
                o.setProducts(this.doRetrieveProductsOrder(o.getId()));

                orders.add(o);
            }
            return orders;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public List<Ordine> doRetrieveByEmail(String email){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT id, data, totale, citta, via, num_civico, provincia, cap, emailUtente FROM ordine WHERE emailUtente=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            ArrayList<Ordine> orders = new ArrayList<>();

            while (rs.next()){
                Ordine o = new Ordine();
                o.setId(rs.getInt(1));
                o.setDate(rs.getDate(2));
                o.setTotal(rs.getDouble(3));
                o.setCity(rs.getString(4));
                o.setVia(rs.getString(5));
                o.setHouse_number(String.valueOf(rs.getInt(6)));
                o.setProvince(rs.getString(7));
                o.setCap(String.valueOf(rs.getInt(8)));
                o.setEmail_user(rs.getString(9));
                o.setProducts(this.doRetrieveProductsOrder(o.getId()));

                orders.add(o);
            }
            return orders;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    private ArrayList<Prodotto> doRetrieveProductsOrder(int id){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("SELECT a.idProdotto, p.nome, a.prezzo, p.immagine, p.nomeCategoria, p.descrizione, a.quantita FROM appartiene a, prodotto p WHERE a.idProdotto = p.id AND a.idOrdine=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            ArrayList<Prodotto> products = new ArrayList<>();

            while (rs.next()){
                Prodotto p = new Prodotto();
                p.setId(rs.getInt(1));
                p.setName(rs.getString(2));
                p.setPrice(rs.getDouble(3));
                p.setImage(rs.getString(4));
                p.setNameCategory(rs.getString(5));
                p.setDescription(rs.getString(6));
                p.setQuantity(rs.getInt(7));

                products.add(p);
            }
            return products;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doInsert(Ordine o, int cardId, ArrayList<Carrello> carts) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO ordine (data, totale, citta, via, num_civico, provincia, cap, telefono, emailUtente, idMetodo) VALUES (?,?,?,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            java.sql.Date d = new java.sql.Date( new java.util.Date().getTime() );
            ps.setDate(1, d);
            ps.setDouble(2, o.getTotal());
            ps.setString(3, o.getCity());
            ps.setString(4, o.getVia());
            ps.setString(5, o.getHouse_number());
            ps.setString(6, o.getProvince());
            ps.setString(7, o.getCap());
            ps.setString(8, o.getPhone_number());
            ps.setString(9, o.getEmail_user());
            ps.setLong(10, cardId);

            int execute = ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int auto_id = rs.getInt(1);

            this.doInsertProduct(auto_id, carts);

            return execute;
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void doInsertProduct(int id, ArrayList<Carrello> carts) {
        try (Connection con = ConPool.getConnection()) {

            for(Carrello c : carts) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO appartiene (idOrdine, idProdotto, quantita, prezzo) VALUES (?,?,?,?)",
                        Statement.RETURN_GENERATED_KEYS);

                java.sql.Date d = new java.sql.Date(new java.util.Date().getTime());
                ps.setInt(1, id);
                ps.setInt(2, c.getProducts().getId());
                ps.setInt(3, c.getQuantity());
                ps.setDouble(4, c.getProducts().getPrice());

                ps.executeUpdate();

            }
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
