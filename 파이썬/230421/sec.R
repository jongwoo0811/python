library(dplyr)
library(ggplot2)

# 극단치 
View(mpg)

# 극단치를 확인(시각화)
boxplot(mpg$cty)
# 극단치 수치로 표현
boxplot(mpg$cty)$stats

mpg =ggplot2:mpg    # ggpplot2 안에 있는 mpg를 가져오겠다.

# 이상치는 26초과 이거나 9 미만인 경우가 이상치
# 이상치를 결측치로 변환
ifelse(mpg$cty <9 | mpg$cty > 26, NA , mpg$cty)-> mpg$cty     #ifelse(조건 , 변경값, 적용위치) -> 저장
table(is.na(mpg$cty))     # True값이 결측치의 개수

# dplyr 패키지를 이용하여 결측치를 제거하고 제조사별(manufacturer)로 그룹화 
# 이후 도심연비(cty)의 평균의 값을 구하기 
# 도심연비가 좋은 상위5개의 제조사를 확인
mpg %>% # 결측치 아닌값들만 뽑아보고 / 제조사별 그룹으로 묶고 / 도심연비 값 평균 컬럼추가/ 내림차순으로 정렬 후 상위 5개 출력
  filter(!is.na(mpg$cty)) %>% group_by(manufacturer) %>% 
  summarise(mean_data =mean(cty)) %>% 
  arrange(-mean_data) %>% head(5)

mpg = ggplot2::mpg

# total 파생변수생성
# total은 (cty + hwy) /2
# test 파생변수 생성
# total이 30이상이면 'A', 20이상이고 30미만이면 'B', 20미만이면 'C'

total =( mpg$cty +mpg$hwy)/2
total
cbind(mpg, total)->mpg# or mpg %>% mutate(total =(cty+hwy)/2)
mpg
# ifelse(조건식, 참인 경우, ifelse(조건식2, 참인경우, 거짓인 경우))
ifelse(mpg$total >=30,'A',ifelse(mpg$total >= 20 ,'B','C')) -> mpg$test # 조건을 정하고 test 컬럼에 추가
mpg

qplot(mpg$test)

# midwest 데이터
midwest =ggplot2::midwest
View(midwest)

# 컬럼의 이름을 변경
# rename(데이터프레임명, 새 컬럼의 이름 = 변경이 될 컬럼의 이름)
# popasian 컬럼을 asian으로 변경, poptotal 컬럼을 total로 변경
# ratio 파생변수 생성 -> 전체 인구수 대비 아시아의 인구 수를 백분율로 표시
# group 파생변수 생성-> ratio 평균보다 ratio 값이 크면 'large' 아니면 'small'
rename(midwest, asian = popasian, total = poptotal) -> midwest
midwest %>% mutate(ratio = asian / total *100) -> midwest
ifelse(midwest$ratio > mean(midwest$ratio),'large','small') -> midwest$group
qplot(midwest$group)
table(midwest$group)
