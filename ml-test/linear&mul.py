import matplotlib.pyplot as plt
from sklearn.datasets import load_diabetes
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score

data = load_diabetes()
y = data.target

# Single Regression
X = data.data[:, [2]]

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

print("Single Regression R2 Score:", r2_score(y_test, y_pred))

plt.scatter(X_test[:, 0], y_test)
plt.plot(X_test[:, 0], y_pred, color="red")
plt.title("Single Regression")
plt.show()


# Multiple Regression
X = data.data

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

model = LinearRegression()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

print("Multiple Regression R2 Score:", r2_score(y_test, y_pred))

plt.plot(y_test, label="Actual")
plt.plot(y_pred, label="Predicted")
plt.title("Multiple Regression")
plt.legend()
plt.show()