package model;

public class Prodotto {

    private int id;
    private String name;
    private double price;
    private String description;
    private String image;
    private String nameCategory;
    private int quantity;

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setNameCategory(String nameCategory) {
        this.nameCategory = nameCategory;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public String getDescription() {
        return description;
    }

    public String getNameCategory() {
        return nameCategory;
    }

    public String getImage() {
        return image;
    }

    public int getQuantity() {
        return quantity;
    }

}
