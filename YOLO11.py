from ultralytics import YOLO

# Load a COCO-pretrained YOLO11n model
model = YOLO("yolo11n.pt")

# Train the model and store results in a new folder
results = model.train(
    data="C:/Users/gopic/OneDrive/Desktop/yolo/dataset/data.yaml",  # Path to dataset config
    epochs=100,
    imgsz=640,
    batch=16,
    save=True,
    project="C:/Users/gopic/OneDrive/Desktop/yolo/results",  # Store all results here
    name="train_run_1",  # Unique run folder
)

# Evaluate the model on the test dataset and save results
metrics = model.val(
    data="C:/Users/gopic/OneDrive/Desktop/yolo/dataset/data.yaml",
    split="test",
    project="C:/Users/gopic/OneDrive/Desktop/yolo/results",
    name="val_results"
)
print("Evaluation Metrics on Test Data:", metrics)

# Run inference on test images and save outputs
results = model(
    "C:/Users/gopic/OneDrive/Desktop/yolo/dataset/images/test/*.jpg",
    save=True,
    show=True,
    project="C:/Users/gopic/OneDrive/Desktop/yolo/results",
    name="inference_results"
)

# Print results summary
for result in results:
    print(result)
