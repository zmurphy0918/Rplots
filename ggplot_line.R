# 2021-12-28
# 折线图,
# x轴和y轴都是数值型，最好
# x轴为因子型，需要使用aes(group=1)所有数据属于一个分组
library(ggplot2)
?geom_line

# 简单折线图
BOD
p1 <- ggplot(BOD, aes(x=Time, y=demand))
p1 + geom_line()
BOD1<-BOD
BOD1$Time <- factor(BOD1$Time)
p2 <- ggplot(BOD1, aes(x=Time, y=demand, group=1)) # 注意x轴没有6的取值
p2 + geom_line()


# 多个折线图
library(plyr)
tg <- ddply(ToothGrowth, c("supp","dose"), summarise, length=mean(len))
t1 <- ggplot(tg, aes(x=dose, y=length, colour=supp))
t1 + geom_line()
t2 <- ggplot(tg, aes(x=dose, y=length, linetype=supp))
t2 + geom_line()
t3 <- ggplot(tg, aes(x=factor(dose), y=length, colour=supp, group=supp)) # 离散型转因子型需指定group
t3 + geom_line()
# dplyr类似pandas, dplyr-dataframe plier
# plyr
# ddply类似tapply
# apply,输入矩阵或数组，对行/列/行和列进行计算，输出矢量、数组、矩阵
# lapply,list apply输入对象,返回同样长度的对象，对每个元素进行操作
# sapply,输入列表、向量、数据帧，返回同样长度的列表、向量、矩阵
# tapply,输入？,计算每个因子水平的函数，返回？
# vapply
# mapply
m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
a_m1 <- apply(m1, MARGIN=2, sum)
lmn_cars <- lapply(mtcars, min) # 返回列表
smn_cars <- sapply(mtcars, min) # 返回向量
t_iris <- tapply(iris$Sepal.Width, iris$Species, median)

# x轴和y轴反转
e1 <- ggplot(economics, aes(x=date, y=unemploy))
e1 + geom_line()
e2 <- ggplot(economics, aes(x=unemploy, y=date))
e2 + geom_line()  # 错误示范
e2 + geom_line(orientation='y')  # 正确示范

# 折线图变形-阶梯图
# geom_path 带顺序的折线图
# geom_step 普通的折线图变阶梯折线图
recent <- subset(economics, date>=as.Date("2013-01-01"))
e3 <- ggplot(recent, aes(x=date, y=unemploy))
e3 + geom_step()


# 以上都为连接线，
# ggplot2还有参考线水平线(geom_hline)、竖直线(geom_vline)、斜线(geom_abline）
# 线段和曲线: geom_segment、geom_spoke、geom_curve
?geom_hline
library(gcookbook)
h1 <- ggplot(heightweight,aes(x = ageYear, y = heightIn, colour = sex))
h1 + geom_point() +
  geom_hline(aes(yintercept = 60), colour='blue')+
  geom_vline(aes(xintercept = 14), colour='red') +
  geom_abline(aes(intercept = 37.4, slope = 1.75))  # 设置斜率和截距


?geom_area，是geom_ribbon的特殊情况
?geom_ribbon,区间图，ymax,ymin覆盖的范围

# 面积图
sunspotyear <- data.frame(
	Year=as.numeric(time(sunspot.year)),
	Sunspot=as.numeric(sunspot.year)
)
s <- ggplot(sunspotyear, aes(x=Year, y=Sunspot))
s + geom_area(fill='purple', alpha=0.2)+
 geom_line()

# 堆积面积图
# 堆积面积图需要的是宽格式wide format，ggplot2要求数据必须是长格式long format
# 可以用tidyr、reshape2包
library(gcookbook)
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) # fill?
s + geom_area(alpha=0.7) # 默认了position为stack
s + geom_area(position='fill')
# 反转图例堆积顺序，没有用,没有反转
library(plyr)
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) 
s + geom_area(alpha=0.6)

# 百分比堆积面积图
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup))
s + geom_area(position='fill')

# 区间图
library(plyr)
n <-ddply(uspopage, 'Year', summarize, max_val=max(Thousands), min_val=min(Thousands))
ss <- ggplot(n, aes(x=Year, y=(min_val+max_val)/2))
ss + geom_ribbon(aes(ymin=min_val, ymax=max_val), colour='gray', alpha=0.3)
# 加置信域,必须先画区域，后画折线，否则会覆盖
ss + geom_ribbon(aes(ymin=min_val, ymax=max_val), colour='gray', alpha=0.3)+
  geom_line()


# 美化
# 添加数据标记
# library(gcookbook)
g <- ggplot(worldpop, aes(x=Year, y=Population))
g + geom_line() + geom_point()

# 修改线型
p <- ggplot(BOD, aes(x=Time, y=demand))
p + geom_line(linetype='dashed', size=1, colour='blue')

# 修改数据标记样式
p + geom_line(linetype='dashed', size=1, colour='blue')+
 geom_point(size=3, shape=22, colour='darkred', fill='pink')



