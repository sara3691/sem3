import pandas as pd
from sklearn.datasets import load_iris

data = load_iris()
x = pd.Series(data.data[:, 0])

print("Mean:", x.mean())
print("Median:", x.median())
print("Mode:", x.mode()[0])
print("Standard Deviation:", x.std())
print("Variance:", x.var())