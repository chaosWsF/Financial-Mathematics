import pandas as pd
import numpy as np

df = pd.read_csv('./returns.csv')
df['date'] = pd.to_datetime(df['date'])
dataUsed = df.iloc[:, 1:].values
dataReturn = (np.prod(dataUsed / 100 + 1, axis=0) - 1) * 100
dataStd = dataUsed.std(axis=0)
riskFree = np.array([3.063, 3.063, 3.063, 1.75, 1.75, 3.063, 3.063])
sharpe = (dataReturn - riskFree) / dataStd

col = df.iloc[:, 1:].columns
resultDf = pd.DataFrame([dataStd, sharpe], columns=col)
resultDf.to_csv('other_index.csv')
