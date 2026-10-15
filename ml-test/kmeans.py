import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans

data = load_iris()
X = data.data

model = KMeans(n_clusters=3, random_state=42, n_init=10)
model.fit(X)

y_pred = model.labels_

print("Cluster Labels:", y_pred)

plt.scatter(X[:, 0], X[:, 1], c=y_pred)
plt.xlabel("Sepal Length")
plt.ylabel("Sepal Width")
plt.title("K-Means Clustering")
plt.show()