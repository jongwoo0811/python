import pandas as pd
import numpy as np
from datetime import datetime


# class 선언
class Invest:

    #생성자 함수 생성
    def __init__(self, _df, _col):
        # self 변수는 클래스 각각의 독립적인 변수
        self.df = _df
        self.col=_col
    # 1번 함수 생성
    def boll(self, start, end):
        #인덱스를 시계열로 변경
        self.df.index = pd.to_datetime(self.df.index)
        # start, end를 시계열로 변경
        start = datetime.strptime(start, '%Y%m%d').isoformat()
        end = datetime.strptime(end, '%Y%m%d').isoformat()

        #결측치 제거
        self.df = self.df.loc[~self.df.isin((np.nan, np.inf, -np.inf)).any(1),['Adj Close']]
        # price_self.df = self.df[['Adj Close']] 위에 문장이랑 합침 위에는 인덱스 명령어만 잇었기 때문 
        self.df['center'] = self.df.rolling(20).mean() # ['Adj Close'] 생략략
        self.df['lb'] = self.df['center']-(2*self.df[self.col].rolling(20).std())
        self.df['ub'] = self.df['center']+(2*self.df[self.col].rolling(20).std())
        #데이터를 시작시간부터 종료시간까지 필터
        self.df =self.df.loc[start:end]
        return self.df

    def boll2(self):
        self.df['trade']=""
        for i in self.df.index:
            # 상단밴드보다 종가가 높은 경우
            if self.df.loc[i,self.col]> self.df.loc[i,'ub']:
            # 현재 구매상태이면
                if self.df.shift(1).loc[i,'trade'] == 'buy':
                # 매도
                    self.df.loc[i,'trade']= ''
                else:
                #구매상태가아니면
                    self.df.loc[i,'trade']= ''
            # 하단밴드보다 종가가 낮은경우
            elif self.df.loc[i,self.col]< self.df.loc[i,'lb']:
            # 현재 구매 상태이면
                if self.df.shift(1).loc[i, 'trade'] == 'buy':
                #구매상태 유지
                    self.df.loc[i,'trade'] ='buy'
                else:
                    self.df.loc[i,'trade'] ='buy'
            else:
            #현재 구매상태이면
                if self.df.shift(1).loc[i,'trade'] =='buy':
                #구매 상태유지
                    self.df.loc[i,'trade']= 'buy'
                else:
                    self.df.loc[i,'trade'] =''
        return self.df

    def boll_rtn(self):
        self.df['return'] =1
        rtn=1.0
        buy=0.0
        sell=0.0

        for i in self.df.index:
        # 구매가를 출력
            if (self.df.shift(1).loc[i,'trade']=='')and(self.df.loc[i,'trade']=='buy'):
                buy = self.df.loc[i,self.col]
                print('진입일:',i,'구매가격:', buy)
        #판매가 출력
            elif(self.df.shift(1).loc[i,'trade']=='buy')and(self.df.loc[i,'trade']==''):
                sell= self.df.loc[i,self.col]
                rtn = (sell-buy)/buy+1
                self.df.loc[i,'return'] =rtn
                print('판매일:',i,'판매가격:', sell, '수익률:' , rtn)

        #구매가, 판매가를 초기화
            if self.df.loc[i,'trade']=='':
                buy=0.0
                sell=0.0

        acc_rtn = 1.0
        for i in self.df.index:
            rtn=self.df.loc[i,'return']
            acc_rtn*=rtn
            self.df.loc[i,'acc_rtn']=acc_rtn

        print('누적수익률:', acc_rtn)
        
        return self.df
        
