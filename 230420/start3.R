# 결측치에 대한 계산
# 결측치는 연산이 되지 않는다
# 필터를 걸게되면 무조건 출력
c1 =c(1,2,NA,NA,5)
c2 =c(1,2,3,4,5)
c3 =c(NA,2,3,4,5)
df =data.frame(c1,c2,c3)
df

# 결측치를 확인하는 방법
is.na(df)
table(is.na(df))
is.na(df$c1)

# dplyr 패키지를 이용하여 결측치를 제거한 데이터를 확인하는 방법
df %>% filter (!is.na(c1))    # 결측치를 제거한 데이터

na.omit(df)   # NA가 존재하는 인덱스를 전부 삭제(결측치를 완벽하게 제거)

# 결측치를 제외하고 연산하는 방법
mean(df$c1)   # 결측치가 하나라도 있으면 NA가 출력
mean(df$c1, na.rm = T)  # True의 T / 결측치를 제거(제외)하겠다

exam =read.csv("./csv/csv_exam.csv")

exam[c(5,7),3] =NA    # 3번째 컬럼에 5,7 번째 데이타에 NA 삽입
exam

# 수학 점수의 평균 값을 출력
# 결측치인 값을 수학 점수의 평균을 대체
# ifelse()함수를 이용하여 결측치에 수학점수의 평균값을 대입

mean(exam$math, na.rm =T) -> mean_math
ifelse(is.na(exam$math), mean_math, exam$math) #-> exam$math
exam
mean_math
# 이상치
 outliner =data.frame(gender = c(1,2,1,2,3),
                      score =c(80,90,70,80,50))
 outliner

# gender가 3인 데이터는 이상치로 체크
# gender가 1아니면 2인 경우에만 데이터를 출력
# base함수를 이용하는 경우
outliner[outliner$gender ==1 |outliner$gender ==2,]
# dplry 패키지를 사용하는 경우
outliner %>% filter(gender ==1| gender ==2) # 동일 방법

# gender가 1과 2가 아니면 결측치로 변경
ifelse(outliner$gender !=1 & outliner$gender !=2, NA, outliner$gender)
ifelse(outliner$gender %in% c(1,2), outliner$gender, NA)
outliner$gender[outliner$gender!=1 & outliner$gender!=2] <-NA
outliner
# 결측치를 제거
na.omit(outliner)
outliner %>% filter(!is.na(gender))









