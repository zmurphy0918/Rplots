setwd('D:/0R/Rprograms/20210208')
# part1-基本数据结构

# 1.1-向量(同一数据类型的集合)
v1 <- 1:10
v2 <- seq(from=1,tp=20,by=2,length.out=5)
# along.with与另一个向量长度相同
v3 <- rep(c(2,5,6),c(1,2,3))
v3 <- rep(c(2,5,6),each=2)
# 第二个向量可以为常数,以上几种重复顺序不同

w <- vector(length=8)#可以事先定义向量的长度
w[1] <- 59
w[2] <- 53.5
w[3] <- 55
w[4] <- 53.5
w[5] <- 52.5
w[6] <- 57.5
w[7] <- 53
w[8] <- 55
# 所有元素都被定义后才能获取w的值，否则报错

# 1.2-矩阵为2维的，数据类型必须相同）
m1 <- matrix(data=c(1:12), nrow=3, ncol=4, byrow=TRUE,
             dimnames=list(c('one','two','three'), c('A','B','C','D')))
# dimnames(m1) <- list(c('one','two','three'), c('A','B','C','D'))
# rownames(), colnames()分别制定行名和列名
m1['two','C']
m1[c('two','three'), c('B','C')]
m1[-c(2,3),-c(2,3)] #只能按索引来查询


# 1.3-数组（多维的，数据类型必须相同）
a <- array(data=1:24, dim=c(2,4,3))
dimnames(a)[[1]] <- c('m','n')
dimnames(a)[[2]] <- c('A','B','C','D')
dimnames(a)[[3]] <- c('dim1','dim2','dim3')
# 维度互换
new_a <- aperm(a, c(3,1,2))
# 第二个参数表示把原来的维度调整为第几个维,
# 例如原来维度为2*4*3,现在的维度改为4*3*2
# 2-变为第3个维,4-改为第1个维,3-改为第2个维

# 1.4-列表(可以存放不同类型的数据结构)，类似python的字典
l1 <- list(c('red','green'),c(1:3),'blue')
l2 <- list(name='alice',age=c(2,3,6))
names(l1) <- c('color1','nums2','color3')
l1$nums2[3]
l2[[2]];l2[['age']]
# 增加删除新元素
l1[4] <- 'new_factor'
l1[4] <- NULL

l2 <- list(1:2, c('a','b','c'), 10)
names(l1) <- c('col1', 'col2', 'col3')
mergelist <- c(l1, l2)

# 1.5-数据框(可以存放不同类型的数据结构)
name <- c('alice','bobo','celin')
age <- c(20,50,35)
country <- c('china','england','america')
df <- data.frame(name, age, country)
df[3]  #返回数据框
df[[3]] #返回向量
df[['country']]; df$name
# 1.6-因子
f1 <- factor(x=rep(c(1,2,3,4,2,3),2),
             exclude=4,#排除掉其中某几个水平
             labels=c('A','B','C'), 
             ordered=TRUE)
f1
class(f1)
nlevels(f1) #查看有几个水平

# attach()用于连接数据框、列表

c <- c(0/1, 0/0, 1/0, NA)
# 特殊类型
# NA: 缺失值
is.na() #位置上的值为空
# NULL: 空值，没有内容那个
is.null() #没有位置，变量为空
# Nan: 非数值
is.nan() #不符合计算规则