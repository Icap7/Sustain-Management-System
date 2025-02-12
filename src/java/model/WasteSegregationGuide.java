package model;

public class WasteSegregationGuide {
    private int id;
    private int userId;
    private String wasteType;
    private String category;
    private String disposalMethod;
    private String recyclingInstructions;
    private String imagePath;

    // Constructor
    public WasteSegregationGuide(int id, int userId, String wasteType, String category, String disposalMethod, String recyclingInstructions, String imagePath) {
        this.id = id;
        this.userId = userId;
        this.wasteType = wasteType;
        this.category = category;
        this.disposalMethod = disposalMethod;
        this.recyclingInstructions = recyclingInstructions;
        this.imagePath = imagePath;
    }
    
    public WasteSegregationGuide(){}
    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUserId() {
        return userId;
    }
    

    public String getWasteType() {
        return wasteType;
    }

    public void setWasteType(String wasteType) {
        this.wasteType = wasteType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDisposalMethod() {
        return disposalMethod;
    }

    public void setDisposalMethod(String disposalMethod) {
        this.disposalMethod = disposalMethod;
    }

    public String getRecyclingInstructions() {
        return recyclingInstructions;
    }

    public void setRecyclingInstructions(String recyclingInstructions) {
        this.recyclingInstructions = recyclingInstructions;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
