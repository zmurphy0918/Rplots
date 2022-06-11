setwd('D:/0R/Rprograms/20210208')

# part1-数据分布
# 产生随机函数
dnorm(0.25, mean=0, st=1, log=FALSE) #返回正态分布的概率密度函数的值
pnorm(0.75, mean=0, st=1, lower.tail=TRUE) #返回正态分布的累计密度得值
qnorm(0.5, mean=0, st=1, lower.tail=TRUE) #返回给定概率的下分位点
rnorm(n, mean=0, st=1) #返回由n个正态分布的随机数构成的向量
# 对于泊松分布、指数分布等其他分布也一样

# part2-作图
# 直方图
hist(data, breaks=c(), frequency=F)
# 核密度图
density(data)
# 经验分布函数
ecdf(x)
# QQ图
qqnorm()
qqline()
# 茎叶图
stem(x)
# 箱线图
boxplot(A,B,names=c('A','B'))

#高水平绘图函数
plot()
pairs()
coplot(Weight~Height|Age)
dotchart(t(VADeaths), main='Death Rates')
contour()

dfMRural<-data.frame(rownames(VADeaths),VADeaths[,1],rep('male',each=5))
colnames(dfMRural) <- c('age','deathrate','gender')
dfFRural<-data.frame(rownames(VADeaths),VADeaths[,2],rep('female',each=5))
colnames(dfFRural) <- c('age','deathrate','gender')
Rural <- rbind(dfMRural, dfFRural)
rownames(Rural)<-NULL
# dotchart只能针对矩阵和向量运算
dotchart(as.vector(Rural$deathrate), 
         groups=as.factor(Rural$age), 
         labels=unique(Rural$age),
         color=c("red",'blue'), #不能只改变点的颜色
         main='Death Rate of Virginia')
# 低水平绘图函数
points()
lines()
text()
abline()
title()
axis()


# part3-正态性检验
# W统计量检验
shapiro.test(x)
# KS统计量检验
ks.test(x, 'pf', 2, 5)
# 相关性检验
cor.test(x, y, method='kendall')
# T检验-区间检验，成对样本检验
t.test()
# 样本方差比的区间估计
var.test(A, B)
# 二项分布检验
binom.test()
# 非参数检验
# pearson卡方拟合优度检验，W正态性检验，KS检验
chisq.test(c(335, 125, 160), p=c(9,3,4)/16) #是否符合理论分布
chisq.test(matrix(c(60, 3, 32, 11),nrow=2),correct = FALSE) #列联表独立性检验
# fisher精确独立检验，每单元小于4
fisher.test(matrix(c(60, 3, 32, 11),nrow=2))
# 符号检验
binom.test()
# 秩检验
cor.test(x, y, method='spearman') #spearman秩相关检验
cor.test(x, y, method='kendall') #kendall秩相关检验
# 秩检验-wilkson
# 对来自同一个总体的样本检验,非成对样本检验
wilcox.test(x, mu=40, paired=TRUE)



