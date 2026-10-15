import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB

data = load_iris()
X = data.data
y = data.target

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)


knn = KNeighborsClassifier()
knn.fit(X_train, y_train)
y_pred1 = knn.predict(X_test)
acc1 = accuracy_score(y_test, y_pred1)

print("KNN Accuracy:", acc1)

plt.bar(["KNN Accuracy"], [acc1])
plt.ylim(0, 1)
plt.title("KNN Algorithm")
plt.show()


nb = GaussianNB()
nb.fit(X_train, y_train)
y_pred2 = nb.predict(X_test)
acc2 = accuracy_score(y_test, y_pred2)

print("Naive Bayes Accuracy:", acc2)

plt.bar(["Naive Bayes Accuracy"], [acc2])
plt.ylim(0, 1)
plt.title("Naive Bayes Algorithm")
plt.show()
