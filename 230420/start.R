# 백터 데이터를 생성
a = c(1,2,3,4,5)
a
1:5 ->b
b
a= c(1,"test")
a #같은 타입으로 저장이되기 때문에 1도 문자열로 저장됨

# 행렬
d= array(1:20, dim = c(4,5))
d
e= matrix(1:20, nrow=2) # row 인덱스의 수를 지정
e

# 리스트 형태(python에서는 dict 형태와 흡사)
f = list(name ='test',age =20, phone ='010239287423')
f
f['name']
f['age']
f['phone']

# 데이터프레임
df = data.frame(name = c('test','test2'),
                age = c(20,30),
                phone =c('0101234123','010119874123'))
df

# 조 건 문(if문)
a =15
if (a>15){
  print('a는 15보다 크다')
}else if(a==15){
  print('a는 15와같다')
}else{
  print('a는 15보다 작다')
}

# which문 (python에서 find()와 흡사)
name = c('test','test2','test3')
which(name=='test2')
which(name!='test2')
which(name =='test5')

# 패키지 설치
install.packages('dplyr')

# 패키지 로드
library(dplyr)

# 연산자
'%s%' =function(x,y){
  result= %>% 