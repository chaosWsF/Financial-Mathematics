import pandas as pd

df = pd.read_csv('./returns_matrix.csv')
corrMat = df.corr()
# print(corrMat)
# print(type(corrMat))
corrMat.to_csv('./corr_matrix.csv')
