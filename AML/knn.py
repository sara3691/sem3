import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import LabelEncoder
dataset = pd.read_csv("https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv")
# Features and Target
x = dataset.drop('species', axis=1)
y = dataset['species']
# Train-Test Split
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=32
)
knn = KNeighborsClassifier()
knn.fit(x_train, y_train)
result4 = knn.predict(x_test)
print("KNN Accuracy :", accuracy_score(y_test, result4))
nb = GaussianNB()
nb.fit(x_train, y_train)
result5 = nb.predict(x_test)
print("Gaussian NB Accuracy :", accuracy_score(y_test, result5))
le = LabelEncoder()
le.fit(y)
y_test_num = le.transform(y_test)
result5_num = le.transform(result5)
labels = le.classes_
plt.figure(figsize=(6,6))
plt.scatter(y_test_num, result5_num,
            color='blue',
            s=60)
plt.plot([0,2], [0,2],
         'r--',
         linewidth=2)
plt.xticks([0,1,2], labels)
plt.yticks([0,1,2], labels)
plt.xlabel("Actual Class")
plt.ylabel("Predicted Class")
plt.title("Gaussian Naive Bayes - Actual vs Predicted")
plt.grid(True)
plt.show()
