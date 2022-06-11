# 2021-12-29
# 描述数据分布

library(ggplot2)
?geom_histogram
?geom_boxplot

# 简单直方图
binsize <- diff(range(faithful$waiting))/15 # 设定组距
p <- ggplot(faithful, aes(x=waiting))
p + geom_histogram(binwidth=binsize, fill='lightblue', colour='black', origin=31)
# 设置组距、起点


# 分组直方图
library(MASS)
head(birthwt)
p1 <- ggplot(birthwt, aes(x=bwt))
p1 + geom_histogram(fill='white', colour='black')+
  facet_wrap(vars(smoke))
p1 + geom_histogram(fill='white', colour='black')+
  facet_grid(smoke~., scale='free')
# 修改分组标签
birthwt1 <- birthwt
birthwt1$smoke <-factor(birthwt1$smoke)
library(plyr)
birthwt1$smoke <- revalue(birthwt1$smoke, c('0'='no smoke', '1'='smoke'))
p2 <- ggplot(birthwt1, aes(x=bwt))
p2 + geom_histogram(fill='white', colour='black')+
  facet_grid(smoke~., scale='free')

# 频数多边形-与直方图信息一样，只是用line代替bar
p<-ggplot(faithful, aes(x=waiting))
p+geom_freqpoly()



# 密度图
# 一条密度曲线
w1 <- ggplot(faithful, aes(x=waiting))
w1 + geom_density(fill='pink')
# 多条密度曲线
w2 <- ggplot(faithful, aes(x=waiting))
w2 + geom_line(stat="density", adjust=0.25, colour='red')+
  geom_line(stat="density")+
  geom_line(stat="density", adjust=2, colour='blue')
# 分组密度曲线
birthwt1 <- birthwt
birthwt1$smoke <- factor(birthwt1$smoke)
bw1 <- ggplot(birthwt1, aes(x=bwt, colour=smoke)) 
bw1 + geom_density()
bw2 <- ggplot(birthwt1, aes(x=bwt, y=..density..))
bw2 + geom_histogram(binwidth=200, fill='cornsilk', colour='grey60', size=0.2)+
   geom_density()+
   facet_grid(smoke~.)



# 箱线图
?geom_boxplot
# 注意一下ggplot2的boxplot和base中的boxplot有区别
library(MASS)
ps<-ggplot(birthwt, aes(x=factor(race), y=bwt))
ps + geom_boxplot(outlier.size=1.5, outlier.shape=21, width=0.5)
# 加槽口
ps + geom_boxplot(notch=TRUE)

# 小提琴图-反应密度曲线分布
library(gcookbook)
p <- ggplot(heightweight, aes(x=sex, y=heightIn))
p + geom_violin()+
    geom_boxplot(width=0.1, fill='black', outlier.colour=NA)+
    stat_summary(fun=median, geom='point', fill='white', shape=21, size=2.5)
# 密度曲线平滑程度设置
p + geom_violin(adjust=2)  # 更平滑
p + geom_violin(adjust=0.5)# 欠平滑


geom_bin


# 二维数据的密度图-反应的信息只有两列
?stat_density2d
# 用等高线
p <- ggplot(faithful, aes(x=eruptions, y=waiting))
p + geom_point() + stat_density2d(aes(colour=..level..))  # 这个用法没见过
# 用瓦片图
p + stat_density2d(aes(fill=..density..), 
	geom='raster', contour=FALSE)  # 栅格图，密度映射给填充色
p + stat_density2d(aes(fill=..density..), 
	geom='raster', contour=FALSE, h=c(0.5, 5))  # 栅格图，密度映射给填充色，减小x轴y轴带宽
p + geom_point() + stat_density2d(aes(alpha=..density..), 
	geom='tile', contour=FALSE)    # 瓦片图，密度映射给alpha






