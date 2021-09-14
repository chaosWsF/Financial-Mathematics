import pandas as pd
import numpy as np


def cal_return(data_frame):
    day_return = data_frame.iloc[:, 1:]
    day_return_data = day_return.values
    total_return = (np.prod(day_return_data / 100 + 1, axis=0) - 1) * 100
    return total_return


df = pd.read_csv('./returns.csv')
df['date'] = pd.to_datetime(df['date'])
startList = ['2017-07', '2017-10', '2018-01', '2018-04', '2017-07', '2018-01', '2017-07']
endList = ['2017-10', '2018-01', '2018-04', '2018-07', '2018-01', '2018-07', '2018-07']

returnList = []
annualReturnList = []
for i in range(len(startList)):
    startDate = startList[i]
    endDate = endList[i]
    dfUsed = df[(df.date >= startDate) & (df.date < endDate)]
    dfReturn = cal_return(dfUsed)
    if i < 4:
        annualReturn = ((dfReturn / 100 + 1) ** 4 - 1) * 100
    elif 4 <= i < 6:
        annualReturn = ((dfReturn / 100 + 1) ** 2 - 1) * 100
    else:
        annualReturn = dfReturn
    
    returnList.append(dfReturn)
    annualReturnList.append(annualReturn)

col = df.iloc[:, 1:].columns
resultDf1 = pd.DataFrame(data=returnList, columns=col)
resultDf2 = pd.DataFrame(data=annualReturnList, columns=col)

resultDf1.to_csv('./return_of_7_funds.csv')
resultDf2.to_csv('./return_annualized_of_7_funds.csv')
