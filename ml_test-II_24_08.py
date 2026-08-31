import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score,ConfusionMatrixDisplay
import matplotlib.pyplot as plt


data=load_iris()
x=data.data
y=data.target

x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2,random_state=42)

model=GaussianNB()

model.fit(x_train,y_train)

y_pre=model.predict(x_test)

print("accuracy_score ", accuracy_score(y_test,y_pre))

ConfusionMatrixDisplay.from_predictions(y_test,y_pre)
plt.show()
