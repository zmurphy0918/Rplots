# 整理总结
setwd('D:/0R/Rprograms/20210208')


# Part1-R读取数据
data.table-as.data.table #内存不足
ffbase-read.table.ffdf() #写入硬盘



# Part2-缺失值处理
# 区分NULL, NA,  NaN(数学计算)
x <- c(1,2,3,3,3,3, NA)
m <- matrix(c(1:12), nrow=3)
colnames(m)<-c('A','B','C','D')
m[2,2] <- NA
m[1,3] <- NA
# 2.1-识别缺失值
# NA
sum(is.na(x))
apply(is.na(m), MARGIN=2, FUN=sum)
# NaN
is.nan(x)
is.infinite(x)
complete.cases(m) #识别矩阵或数据框中没有缺失值的行
summary(m)

# 2.2-展示有缺失值的行
m[,!complete.cases(m)]
psych::describe(m) # psych包矩阵展示确实情况
mice::md.pattern(m) # mice包矩阵形式展示缺失情况
VIM::aggr(VIM::sleep, numbers=TRUE, prop=TRUE) #图形化展示缺失值
par(mfrow=c(1,1))
VIM::marginplot(VIM::sleep[c('Gest','Dream')],pch=c(20),
                cex.numbers=0.7,
                col=c("darkgray","red","blue"))
#探索缺失值的相关性
cor(abs(is.na(m)))

# 2.3-处理有缺失值的行
# 忽略
# 行删除
na.omit(m)
# 填充-均值，中位数
m[is.na(m$B), 'B'] <- mean(m$B, na.rm=TRUE)
mm <- as.data.frame(apply(m, MARGIN=2, 
                          FUN=function(x){Hmisc::impute(x, mean)}))
mice::mice(mm, m=5) #针对数据框、矩阵

# VIM检测和展示缺失值
# Hmisc 用多种插值方法
# mice包原理？
# cat,对数线性模型中多元类别型变量的多重插补
subset()

# Part3-重复值处理
x[!duplicated(x)]


# Part4-数据转化
# 连续性-归一化
scale(x, center=TRUE, scale=TRUE)
# 分类型-独热编码、哑变量

# 离散化



# Part5-离群值处理



# Part6-维度规约



# Part7-不同数据类型
setdiff(x,y) #x和y中不同的元素
sweep()
# 数值型数据处理

# 字符型数据处理函数
s <- 'this is a string'
substr(s, 3, 8) # 按位置索引
strsplit(s, split=' ')
sub(pattern='i', replacement='y', x=s ) #只替换第一个
gsub(pattern='i', replacement='y', x=s ) # 全部替换
regexpr(pattern='is', text=s)
# 格式化提取
stringr::str_split()
strsplit(s)

# 因子型数据处理函数




# Part8-管道函数
# %in%：表示包含于
# %>%：表示向右传递
# %$%：表示向右传递列，并可以直接按列操作



