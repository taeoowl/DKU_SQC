library(qcc)

setwd('C:/Users/taeoo/Desktop/태민우/학교/3학년 2학기(2020)/통계적품질관리(이성임-1)')
st <-  read.csv('[통계적품질관리]32154878 태민우 데이터.csv', header = T)
st

### X
# 약 한달간의 데이터(phase1)를 통해 시그마의 추정값으로 사용
# 단점 : phase1에 해당되는 기간에 많이 사용하면 한동안 경고없이 원하는만큼 사용하게됨


X <- st[,2]
qcc(X, type = 'xbar.one') 
xchart <- qcc(X[71:100], newdata = X[1:168], type = 'xbar.one',
    data.name = '산포가 안정적인 기간', newdata.name = '일일 사용시간', center = 6540,
    nsigma = 2) # CL : 7665, 2시간 7분 / std = 36분 / 대한민국 일평균 1시간 49분, 6540초

# 해당 데이터의 한계 : 초반 한달간의 사용량의 산포가 크기 때문에, phase1의 기간을 늘려야함
# 따라서 평균변화를 통해 관리한계를 정할 경우
# 3시그마를 2시그마로 줄이거나, 산포가 일정한 부분을 기준으로 관리한계를 정해야할 듯 
# 특정앱에 대한 사용량만을 이용하여 추정하는 것이 필요해보임

### CUSUM

cus <- cusum(X[71:100], center = 6540, se.shift = 1, decision.interval = 5, newdata = X)
cus2 <- cusum(X[71:100], center = 6540, se.shift = 2, decision.interval = 5 , newdata = X)

#### EWMA

ewm <- ewma(X[71:100], center = 6540, lambda = 0.3, newdata = X)

