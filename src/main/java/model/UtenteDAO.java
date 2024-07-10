package model;

import java.sql.*;
import java.util.ArrayList;

public class UtenteDAO {

    public static Utente doRetrieveByEmailPassword(String email, String password) {

        PreparedStatement statement = null;
        ResultSet rs = null;
        Utente u = null;

        if(email==null || password==null)
            return u;

        try (Connection connection = ConPool.getConnection()) {
            statement = connection.prepareStatement("SELECT * FROM utente WHERE email=? AND password=SHA1(?)");
            statement.setString(1, email);
            statement.setString(2, password);
            rs = statement.executeQuery();

            if (rs.next()) {
                u = new Utente();
                u.setEmail(rs.getString("email"));
                u.setName(rs.getString("nome"));
                u.setSurname(rs.getString("cognome"));
                u.setAdmin(rs.getBoolean("admin"));
                u.setPassword(password);
                if(!(rs.getString("telefono")==null))
                    u.setPhone_number(rs.getString(4));
                if(!(rs.getString("citta")==null))
                    u.setCity(rs.getString(5));
                if(!(rs.getString("via")==null))
                    u.setStreet(rs.getString(6));
                if(!(rs.getString("num_civico")==null))
                    u.setStreet_number(Integer.parseInt(rs.getString(7)));
                if(!(rs.getString("provincia")==null))
                    u.setProvince(rs.getString(8));
                if(!(rs.getString("cap")==null))
                    u.setCap(rs.getString(9));
            }
        }  catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        return u;
    }

    public static void doRegistration(Utente utente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO utente (email, nome, cognome, admin, password) VALUES (?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, utente.getEmail());
            ps.setString(2, utente.getName());
            ps.setString(3, utente.getSurname());
            ps.setBoolean(4, false);
            ps.setString(5, utente.getPassword());

            if (ps.executeUpdate() != 1)
                throw new RuntimeException("Errore nel definire l'utente");
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean checkEmail(String email){
        try (Connection con = ConPool.getConnection()){
            PreparedStatement ps = con.prepareStatement("SELECT email FROM utente WHERE email= ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public ArrayList<Utente> doRetrieveAll(){
        try (Connection con = ConPool.getConnection()) {

            PreparedStatement ps = con.prepareStatement("select * from utente");
            ResultSet rs = ps.executeQuery();
            ArrayList<Utente> users = new ArrayList<>();

            while (rs.next()){
                Utente u = new Utente();
                u.setEmail(rs.getString(1));
                u.setName(rs.getString(2));
                u.setSurname(rs.getString(3));
                if(!(rs.getString(4)==null))
                    u.setPhone_number(rs.getString(4));
                if(!(rs.getString(5)==null))
                    u.setCity(rs.getString(5));
                if(!(rs.getString(6)==null))
                    u.setStreet(rs.getString(6));
                if(!(rs.getString(7)==null))
                    u.setStreet_number(Integer.parseInt(rs.getString(7)));
                if(!(rs.getString(8)==null))
                    u.setProvince(rs.getString(8));
                if(!(rs.getString(9)==null))
                    u.setCap(rs.getString(9));
                u.setAdmin(rs.getBoolean(10));

                users.add(u);
            }
            return users;

        } catch (SQLException s) {
            throw new RuntimeException(s);
        }
    }

    public void makeAdministrator(String email) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE Utente SET admin = ? WHERE email = ? ",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setBoolean(1,true);
            ps.setString(2, email);
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void removeAdministrator(String email) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE Utente SET admin = ? WHERE email = ? ",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setBoolean(1,false);
            ps.setString(2, email);
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

