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
summary(cars)
head(cars, n=10)
tail(cars)

rownames(cars)
colnames(cars)

cars$model = rownames(cars) # rownames(cars) = index
rownames(cars) = NULL       # index 제거
