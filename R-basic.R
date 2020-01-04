# 수치/ 문자열/ 배열 / 데이터프레임
v1 = 1
v2 = "abc"
v3 = c(1,2,3)
df1 = data.frame (
  Name = c("Tom", "Smith"),
  Math=c(50, 100)
)

# 패키지 설치
install.packages(c("stringr", "ggplot2", "dplyr", "knitr"))
library("stringr")
library("ggplot2")
library("dplyr")
library("knitr")

"
▶ 데이터 수집 : 읽기, 쓰기
# 원본 데이터 복제 후 수정
"
write.table(mtcars, "mtcars_new.txt")
cars = read.table("mtcars_new.txt", header=T)
write.table(cars, "clipboard")

"
▶ R의 기본 기능
"
summary(cars)               # cars.info()
head(cars, n=10)            # cars.head(10)
tail(cars)                  # cars.tail()

rownames(cars)              # cars.rownames
colnames(cars)              # cars.colnames

cars$model = rownames(cars) # rownames(cars) = index
rownames(cars) = NULL       # index 제거

cars$maker = word(cars$model, 1) # cars.split(" ", 1)

# cars[cars['cyl'] == 4, ["maker", "model", "mpg", "cyl"]]
cars.small.narrow = 
  cars %>%
  filter(cyl == 4) %>%
  select(maker, model, mpg, cyl) 

# pd.pivot_table(cars, index=['maker'], columns=['mpg'], aggfunc=np.mean)
# pd.pivot_table(cars, index=['maker'], aggfunc={ 'mpg':np.mean })
makers = 
  cars %>%
  group_by(maker) %>%
  summarize(maker.mpg = mean(mpg)) 

# pd.merge(cars, makers, on='maker', how='left')
cars.makers = merge(cars, makers, by = "maker")


"
▶ R의 분석 기능
"
# 요약 통계
table(cars$cyl) # cars['cyl'].describe()
table(cars$gear, cars$cyl)

# import matplotlib.pyplot as plt
# plt.hist(cars['mpg'])
# plt.show()
hist(cars$mpg)

# plt.scatter(cars['wt'], cars['mpg'])
plot(cars$wt, cars$mpg)

qplot(wt, mpg, data=cars, shape=factor(cyl))









