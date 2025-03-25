import torch
from torch.utils.data import Dataset
import numpy as np
import cv2
from pathlib import Path

class CustomDataset(Dataset):
    def __init__(self, dataset_dir):
        self.images = []
        self.labels = []

        # Load images from 'unchoice' folder
        for img_path in Path(dataset_dir + 'unchoice/').glob("*.png"):
            img = cv2.imread(str(img_path), cv2.IMREAD_GRAYSCALE)
            img = cv2.resize(img, (28, 28))  # Resize to 28x28
            img = img / 255.0  # Normalize
            self.images.append(img)
            self.labels.append(0)  # Label 0 for 'unchoice'

        # Load images from 'choice' folder
        for img_path in Path(dataset_dir + 'choice/').glob("*.png"):
            img = cv2.imread(str(img_path), cv2.IMREAD_GRAYSCALE)
            img = cv2.resize(img, (28, 28))  # Resize to 28x28
            img = img / 255.0  # Normalize
            self.images.append(img)
            self.labels.append(1)  # Label 1 for 'choice'

        self.images = np.array(self.images, dtype=np.float32).reshape(-1, 1, 28, 28)  # Reshape for PyTorch
        self.labels = np.array(self.labels, dtype=np.int64)

    def __len__(self):
        return len(self.images)

    def __getitem__(self, idx):
        return torch.tensor(self.images[idx]), torch.tensor(self.labels[idx])
    
import torch.nn as nn

class SimpleCNN(nn.Module):
    def __init__(self, weight_file=None):
        super(SimpleCNN, self).__init__()
        self.conv1 = nn.Conv2d(1, 16, kernel_size=3, stride=1, padding=1)  
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2)
        self.fc1 = nn.Linear(16 * 14 * 14, 64)  
        self.fc2 = nn.Linear(64, 2)  
        
        # Nếu cần load trọng số từ tệp
        if weight_file is not None:
            self.load_weights(weight_file)

    def load_weights(self, weight_file):
        # Hàm để tải trọng số
        try:
            self.load_state_dict(torch.load(weight_file, weights_only=True))
            print(f"Weights loaded from {weight_file}")
        except Exception as e:
            print(f"Error loading weights: {e}")

    def forward(self, x):
        x = self.pool(nn.functional.relu(self.conv1(x)))  # Conv -> ReLU -> Pool
        x = x.reshape(x.size(0), -1)  # Flatten
        x = nn.functional.relu(self.fc1(x))  # Fully connected -> ReLU
        x = self.fc2(x)  # Output layer
        return x
    
import torch.optim as optim

def train(model, train_loader, epochs, weight_file='model_weight.pth'):
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)

    model.train()
    for epoch in range(epochs):
        running_loss = 0.0
        for images, labels in train_loader:
            optimizer.zero_grad()
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            running_loss += loss.item()

        print(f"Epoch {epoch + 1}, Loss: {running_loss / len(train_loader)}")
    
    # Lưu trọng số sau khi huấn luyện
    torch.save(model.state_dict(), weight_file)
    print(f"Weights saved to {weight_file}")

if __name__ == "__main__":
    dataset_dir = './process/datasets/'
    dataset = CustomDataset(dataset_dir)
    train_loader = torch.utils.data.DataLoader(dataset, batch_size=32, shuffle=True)

    model = SimpleCNN()
    train(model, train_loader, epochs=10, weight_file='model_weight.pth')  