package model;

import java.io.Serializable;

public class Waste implements Serializable {

    private int id;
    private String type;
    private int quantity;
    private String disposalMethod;
    private double price;
    private int user_id;

    public Waste() {
    }

    public Waste(int id, String type, int quantity, String disposalMethod, double price, int user_id) {
        this.id = id;
        this.type = type;
        this.quantity = quantity;
        this.disposalMethod = disposalMethod;
        this.price = price;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDisposalMethod() {
        return disposalMethod;
    }

    public void setDisposalMethod(String disposalMethod) {
        this.disposalMethod = disposalMethod;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getUserID() {
        return user_id;
    }

    public void setUserID(int user_id) {
        this.user_id = user_id;
    }
}
