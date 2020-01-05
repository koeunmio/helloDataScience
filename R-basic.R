# 패키지 설치
install.packages(c("stringr", "ggplot2", "dplyr", "knitr", "reshape2"))
library("stringr")
library("ggplot2")
library("dplyr")
library("reshape2")
library("knitr")

# 수치/ 문자열/ 배열 / 데이터프레임
v1 = 1
v2 = "abc"
v3 = c(1,2,3)
df1 = data.frame (
  Name = c("Tom", "Smith"),
  Math=c(50, 100)
)

class(df1[1]  ) # data.frame 
df1[1]          # 1열 
class(df1[[1]]) # factor
df1[[1]]        # 1열

df1[1, ]        # 1행 , data.frame
df1[1,1]        # 1행1열, df1[[1]][1] = df1[[1]][[1]], factor
df1[2,1]        # 2행1열, factor
df1[[1]][[2]]   # 2행1열, factor

"
▶ 데이터 수집 : 읽기, 쓰기
"
# txt 읽어서 dataFrame 형태로 저장
pew.raw <- read.delim("pew.txt", check.names = FALSE, stringsAsFactors = FALSE)

# 원본 데이터 복제 후 수정
write.table(mtcars, "mtcars_new.txt")
cars = read.table("mtcars_new.txt", header=T)
write.table(cars, "clipboard")

"
▶ 데이터 가공 : 표준 테이블 변환, 정규식, apply
"
# 표준 테이블로 변환 : 행 - 관찰 항목, 열 - 개별 속성 테이블
pew.tidy <- melt(pew.raw, "religion") # religion열 제외한 다른 속성을 측정값(measure)으로 변환
names(pew.tidy) <- c("religion", "income", "count")
# 형변환 정규식 함수 : 범위 문자열 -> 숫자 문자열 추출 
range.to.number <- function(v) {
  range.values = str_extract_all(v, "\\d+")   # '+' : 1개이상
  if(length(range.values[[1]]) > 0)
    mean(sapply(range.values, as.integer))
  else NA
}
# 형변환 정규식 함수 적용 :
# sapply(v, func) : 벡터 v에 func 적용
pew.tidy$income.usd = sapply(pew.tidy$income, range.to.number) * 1000

"
▶ R의 기본 기능 및 데이터 집계
"
summary(cars)               # cars.info()
head(cars, n=10)            # cars.head(10)
tail(cars)                  # cars.tail()
str(pew.tidy)               # pew.tidy.describe()

rownames(cars)              # cars.rownames
colnames(cars)              # cars.colnames

cars$model = rownames(cars) # rownames(cars) = index
rownames(cars) = NULL       # index 제거

cars$maker = word(cars$model, 1) # cars.split(" ", 1)

# 필요한 행/열 추출 : 
# Python) cars[cars['cyl'] == 4, ["maker", "model", "mpg", "cyl"]]
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
pew.agg = 
  pew.tidy %>%
  group_by(religion) %>%
  filter(income.usd != "NA") %>%
  summarize(total.count = sum(count),
            avg.income.usd = mean(income.usd*count) / sum(count))

# pd.merge(cars, makers, on='maker', how='left')
cars.makers = merge(cars, makers, by = "maker")


"
▶ R의 분석 기능
"
# 요약 통계
table(cars$cyl) # cars['cyl'].describe()
table(cars$gear, cars$cyl)

# 통계값 막대그래프
# coord_flip() : 세로 바 그래프를 가로로 회전
ggplot(pew.agg, aes(religion, total.count)) + geom_bar(stat="identity", width=0.5) + coord_flip()
ggplot(pew.agg, aes(religion, avg.income.usd)) + geom_bar(stat="identity", width=0.5) + coord_flip()
multiplot(q1, q2, cols=2)

# import matplotlib.pyplot as plt
# plt.hist(cars['mpg'])
# plt.show()
hist(cars$mpg)
# plt.scatter(cars['wt'], cars['mpg'])
plot(cars$wt, cars$mpg)
# 고급 시각화 : ggplot2
qplot(wt, mpg, data=cars, shape=factor(cyl))






