import numpy as np
from datetime import datetime
import pandas as pd

def bnh(df,col = 'Close', start ='200001010', end='202001010'):
    #인덱스 시계열로 변경
    df.index=pd.to_datetime(df.index)
    start = datetime.strptime(start, '%Y%m%d')
    end = datetime.strptime(end, '%Y%m%d')
    df = df.loc[start:end]
    df = df.loc[~df.isin([np.nan, np.inf, -np.inf]).any(1)]
    
    df = df[[col]]

    df['daily_rtn'] = df[col].pct_change()

    df['st_rtn'] = (1 + df['daily_rtn']).cumprod()

    return df
