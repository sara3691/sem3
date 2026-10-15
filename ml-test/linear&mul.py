# Linear and Multiple Regression
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_diabetes
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score

data = load_diabetes()
X = data.data[:, [2]]       # Single Regression
# X = data.data[:, [0, 2]]  # Multiple Regression
y = data.target

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

print("Accuracy:", r2_score(y_test, y_pred))

plt.scatter(X_test[:, 0], y_test)
plt.plot(X_test[:, 0], y_pred, color="red")
plt.show()