import pandas as pd
from sklearn.datasets import load_iris

x=load_iris()
x=pd.Series(x.data[:,0])

print("mean : ",x.mean())
print("median : ",x.median())
print("mode : ",x.mode()[0])
print("standard diviation :",x.std())
print("variance : ",x.var())
