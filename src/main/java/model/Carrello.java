package model;

public class Carrello {
    private String email;
    private Prodotto products;
    private int quantity;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Prodotto getProducts() {
        return products;
    }

    public void setProducts(Prodotto products) {
        this.products = products;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}