package model;

import java.io.Serializable;

public class Waste implements Serializable {
    private int id;
    private String type;
    private int quantity;
    private String disposalMethod;

    public Waste() {}

    public Waste(int id, String type, int quantity, String disposalMethod) {
        this.id = id;
        this.type = type;
        this.quantity = quantity;
        this.disposalMethod = disposalMethod;
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
}
