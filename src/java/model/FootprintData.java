package model;

public class FootprintData {

    private int id;
    private int userId;
    private String name;
    private int biomass;
    private double carbonFootprint;
    private int coal;
    private double cost;
    private int electricity;
    private int heatingOil;
    private int lpg;
    private int naturalGas;
    private int renewablesElectricity;
    private int renewablesNaturalGas;

    // Default constructor
    public FootprintData() {
    }

    // Parameterized constructor
    public FootprintData(int id, int userId, String name, int biomass, double carbonFootprint, int coal, double cost,
            int electricity, int heatingOil, int lpg, int naturalGas, int renewablesElectricity, int renewablesNaturalGas) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.biomass = biomass;
        this.carbonFootprint = carbonFootprint;
        this.coal = coal;
        this.cost = cost;
        this.electricity = electricity;
        this.heatingOil = heatingOil;
        this.lpg = lpg;
        this.naturalGas = naturalGas;
        this.renewablesElectricity = renewablesElectricity;
        this.renewablesNaturalGas = renewablesNaturalGas;
    }

    public FootprintData(int id, int userId, int biomass, double carbonFootprint, int coal, double cost,
            int electricity, int heatingOil, int lpg, int naturalGas, int renewablesElectricity, int renewablesNaturalGas) {
        this.id = id;
        this.userId = userId;
        this.biomass = biomass;
        this.carbonFootprint = carbonFootprint;
        this.coal = coal;
        this.cost = cost;
        this.electricity = electricity;
        this.heatingOil = heatingOil;
        this.lpg = lpg;
        this.naturalGas = naturalGas;
        this.renewablesElectricity = renewablesElectricity;
        this.renewablesNaturalGas = renewablesNaturalGas;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getBiomass() {
        return biomass;
    }

    public void setBiomass(int biomass) {
        this.biomass = biomass;
    }

    public double getCarbonFootprint() {
        return carbonFootprint;
    }

    public void setCarbonFootprint(double carbonFootprint) {
        this.carbonFootprint = carbonFootprint;
    }

    public int getCoal() {
        return coal;
    }

    public void setCoal(int coal) {
        this.coal = coal;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getElectricity() {
        return electricity;
    }

    public void setElectricity(int electricity) {
        this.electricity = electricity;
    }

    public int getHeatingOil() {
        return heatingOil;
    }

    public void setHeatingOil(int heatingOil) {
        this.heatingOil = heatingOil;
    }

    public int getLpg() {
        return lpg;
    }

    public void setLpg(int lpg) {
        this.lpg = lpg;
    }

    public int getNaturalGas() {
        return naturalGas;
    }

    public void setNaturalGas(int naturalGas) {
        this.naturalGas = naturalGas;
    }

    public int getRenewablesElectricity() {
        return renewablesElectricity;
    }

    public void setRenewablesElectricity(int renewablesElectricity) {
        this.renewablesElectricity = renewablesElectricity;
    }

    public int getRenewablesNaturalGas() {
        return renewablesNaturalGas;
    }

    public void setRenewablesNaturalGas(int renewablesNaturalGas) {
        this.renewablesNaturalGas = renewablesNaturalGas;
    }
}
