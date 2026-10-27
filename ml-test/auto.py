import matplotlib.pyplot as plt
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Flatten, Dense, Reshape

(X_train, _), (X_test, _) = mnist.load_data()

X_train = X_train / 255.0
X_test = X_test / 255.0

model = Sequential([
    Flatten(input_shape=(28, 28)),
    Dense(32, activation='relu'),
    Dense(784, activation='sigmoid'),
    Reshape((28, 28))
])
model.compile(optimizer='adam', loss='binary_crossentropy')

model.fit(X_train, X_train, epochs=3, batch_size=128)

output = model.predict(X_test[:5])

plt.figure(figsize=(10, 4))

for i in range(5):
    plt.subplot(2, 5, i+1)
    plt.imshow(X_test[i], cmap='gray')
    plt.axis('off')
    
    plt.subplot(2, 5, i+6)
    plt.imshow(output[i], cmap='gray')
    plt.axis('off')

plt.show()