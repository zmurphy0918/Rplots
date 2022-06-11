setwd('D:/0R/Rprograms/20210208')
# options()

# part1-数值型
# 数学运算
x <- c(-1, 0, 2)
y <- c(3, 8, 2)
x+y
x*y
5%%3 #取余数
5%/%3 #整除
exp(x)
sqrt(y)

# 描述性统计
fivenum(x)
max(y)
mean(y) 
sum(x)
range(y) #求范围
sd(y)
median(y)
quantile(y, probs=seq(0,1,0.2))
g1 <- n/((n-1)*(n-2))*sum((x-mean(x))^3)/(sd(x))^3 #偏度系数
g2 <- (n*(n+1))/((n-1)*(n-2)*(n-3))*sum((x-mean(x))^4)/((st(x))^4) #峰度系数
       
# 其他有用的函数
which.max(y) #最大值的坐标
length(y)
sort(y) #改变向量本身


# part2-字符型
s <- c('this', 'is', 'a', 'string')

paste(s, 1:3, sep='-') # 两个向量拼接
paste(s, collapse='+') # 向量自身拼接

# part3-因子型
sex <- c("M","F","M","M", "F")
sexf <- factor(sex)
height <- c(174, 165, 180, 171, 160)
sex.tab <- table(sexf, exclude='M') #分组求频数
tapply(height, INDEX=sex, FUN=mean) #分组统计

# part4-矩阵
A<-matrix(1:6,nrow=2)
t(A) #转置
det(matrix(c(1:4), ncol=2))#行列式
a <- 1:5; b <- 2*1:5
crossprod(a,b) #内积，a%*%b
tcrossprod(a,b) #外积，a%o%b
outer(a,b) #外积

A <- array(c(1:8, 10),dim=c(3,3))
b <- c(1,1,1)
x <- solve(A,b) #矩阵求解
B <- solve(A) #逆矩阵

sm <- crossprod(A,A)
ev <- eigen(sm) #求解特征值和特征向量

svdA <- svd(A) #奇异值分解

# 矩阵拉直
as.vector(A)
# 对于多维度进行操作
apply(A, MARGIN=2, sum)


# part3-对象属性
# mode类型属性
mode(s)
is.numeric(y)
as.character(x)
# length长度属性
x[5] <- 9 
length(y)<-5

z <- c(apple=2.5, orange=2.1);
# attributes除了mode,length之外其他的属性
attributes(z)





