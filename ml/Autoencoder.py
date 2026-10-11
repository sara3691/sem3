
import tensorflow as tf
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Flatten, Dense, Reshape
import matplotlib.pyplot as plt

(X_train, _), (X_test, _) = mnist.load_data()

X_train = X_train / 255.0
X_test = X_test / 255.0

model = Sequential([
    Flatten(input_shape=(28, 28)),
    Dense(64, activation="relu"),
    Dense(784, activation="sigmoid"),
    Reshape((28, 28))
])

model.compile(optimizer="adam", loss="mse")

history = model.fit(
    X_train, X_train, epochs=3, validation_split=0.1
)

output = model.predict(X_test[:1])
print("Original Shape:", X_test[:1].shape)
print("Reconstructed Shape:", output.shape)

plt.plot(history.history["loss"], label="Training Loss")
plt.plot(history.history["val_loss"], label="Validation Loss")
plt.title("Autoencoder Loss")
plt.xlabel("Epoch")
plt.ylabel("Loss")
plt.legend()
plt.grid()
plt.show()
