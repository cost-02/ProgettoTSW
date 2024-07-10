package model;

import java.sql.*;
import java.util.ArrayList;

public class PagamentoDAO {
    public ArrayList<Pagamento> doRetriveByEmail(String email) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT p.* FROM MetodoDiPagamento p, associato a WHERE p.id=a.idMetodo AND a.emailUtente=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            ArrayList<Pagamento> creditCards = new ArrayList<>();

            while (rs.next()){
                Pagamento p = new Pagamento();
                p.setId(rs.getInt(1));
                p.setNumber(rs.getLong(2));
                p.setCvv(Integer.parseInt(rs.getString(3)));
                p.setExpMonth(Integer.parseInt(rs.getString(4)));
                p.setExpYear(Integer.parseInt(rs.getString(5)));
                p.setHolder(rs.getString(6));

                creditCards.add(p);
            }
            return creditCards;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public Pagamento doRetriveById(int id) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM MetodoDiPagamento WHERE id=?");
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            Pagamento p = new Pagamento();

            while (rs.next()){
                p.setId(rs.getInt(1));
                p.setNumber(rs.getLong(2));
                p.setCvv(Integer.parseInt(rs.getString(3)));
                p.setExpMonth(Integer.parseInt(rs.getString(4)));
                p.setExpYear(Integer.parseInt(rs.getString(5)));
                p.setHolder(rs.getString(6));
            }
            return p;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public int doInsert(Pagamento p){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO MetodoDiPagamento (numero, cvv, meseScadenza, annoScadenza, titolare) VALUES (?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setLong(1, p.getNumber());
            ps.setInt(2, p.getCvv());
            ps.setInt(3, p.getExpMonth());
            ps.setInt(4, p.getExpYear());
            ps.setString(5, p.getHolder());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            return rs.getInt(1);
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
