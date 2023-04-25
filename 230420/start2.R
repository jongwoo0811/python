# csv 파일을 로드
df =read.csv("./csv/example.csv")
df

# 상위 6개 출력
head(df)#기본으로 6개 맥스
head(df,3)# 3개만 지정
#하위 6개 출력
tail(df)#기본 6개
tail(df,3)

#뷰어창에 데이터프레임 확인
View(df)

# 데이터프레임 크기를 출력하는 함수
dim(df)

# 데이터프레임에 기초 통계정보 출력
summary(df)

# 데이터프레임의 정보를 출력
str(df)

library(dplyr)
# 컬럼의 이름을 변경
rename(df, '이름' = Name)

df =read.csv("./csv/csv_exam.csv")
df

# 새로운 파생변수 하나 생성
# 전체 점수의 합계(total_score)
# 전체 점수의 평균(mean_score)
total_score =df$math + df[['english']] +df[[5]] # 합계 계산
total_score

cbind(df, total_score) #파생변수 기존 컬럼에 삽입
data.frame(df,total_score) # =
df$total_score =total_score# =
df

df$mean_score = df$total_score/3 # 평균값 계산 및 컬럼 추가
df

# 평균 점수가 60점 이상이면 pass, 아니면 fail
# res 컬럼을 생성
# ifelse(조건식, 참인 경우의 값, 거짓인 경우의 값)
df$res = ifelse(df$mean_score >= 60, 'pass',' fail')
df

# 1학년 중에 평균 점수가 가장 높은 사람의 정보를 출력
df2=df[df$class==1,]# df에서 1학년들만 출력
df3 =df2[order(-df$mean_score),] # 평균점수에서 내림차순 출력
df3[1,] # head(df3,1) 상위 한명 출력

# dplyr 패키지를 사용
df =read.csv("./csv/csv_exam.csv")
df    
# filter df를 필터에 집어넣어 주겠다 
#ctrl + shift +m = %>% 
df %>% filter(class ==1) # df에서 클라스가 1인 값을 필터로 분류 후 출력
df %>% arrange(math)    #수학점수를 기준으로 오름차순 정렬
df %>% arrange(-math)   #수학점수를 기준으로 내림차순 정렬 (desc(math))도 가능

# 정렬의 기준이 여러개인 경우
df %>% arrange(math, english)   # 수학점수를 기준으로 우선 정렬을 하다가 같은 점수가 있을때는 영어로 정렬을 실시

#class를 기준으로 내림차순, math를 기준으로는 오름차순
df %>%  arrange(-class, math)

# 특정 컬럼만 출력
df %>% select(math)   # 수학 성적만 보겠다 select(df, math)
# 파이프 특징 %>% 
df %>%  arrange(-class) %>% select(math, english)   # 파이프를 통해 함수를 여러개 연결이 가능하다

# 특정 컬럼만 삭제
df %>% select(-id)    # id값을 제외한 나머지 값을 출력

# 파생변수 출력
df %>% mutate(total_score = math + english + science,
              mean_score = total_score/3) ->df    # 총 점수와 평균 컬럼 추가 및 계산

df %>% filter(class ==1) %>% arrange(-mean_score) %>% head(1)

# group화 summarise
df %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            mean_english = mean(english)) %>%   # 쿨라스를 기준으로 수학 평균과 영어 평균을 계산하여 각각의 새컬럼의 추가한다
  arrange(-mean_math) %>%    # 수학 평균 컬럼을 기준으로
  head(1)   # 첫번째 인덱스만 출력하겠다

# join
df1 =data.frame(id = 1:5,
                score =c(80,70,40,60,50))
df2 =data.frame(id =1:5,
                score = c(80,65,70,55,90))
df3 = data.frame(id =1:3,
                 class =c(1,1,2))
inner_join(df1,df2, by ='id')
inner_join(df1,df3, by='id')

left_join(df1,df3,by='id')
right_join(df1,df3,by='id')

# 유니언 결합 (python = concat 단순)
rbind(df1,df2)
bind_rows(df1, df2)






