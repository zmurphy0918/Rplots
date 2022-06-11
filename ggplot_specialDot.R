# 2021-12-30
# 非常规的点图
library(ggplot2)


# Cleveland点图-代替条形图减少视觉混乱，保证可读性
library(gcookbook)
tophit <- tophitters2001[1:25, ]
p <- ggplot(tophit, aes(x=avg, y=name)) 
p + geom_point()
# 不按y轴排序，按照x轴排序
p <- ggplot(tophit, aes(x=avg, y=reorder(name, avg)))
p + geom_point(size=3) + 
   theme(panel.grid.major.x=element_blank(),
	   panel.grid.minor.x=element_blank(),
	   panel.grid.major.y=element_line(colour='grey60', linetype='dashed')
)
# 分组排序
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]
tophit$name <- factor(tophit$name, levels=nameorder)
tp <- ggplot(tophit, aes(x=avg, y=name))
tp + geom_segment(aes(yend=name), xend=0, colour='grey50') +
  geom_point(size=3, aes(colour=lg)) +
  theme(panel.grid.major.y=element_blank(),
	  legend.position=c(1,0.55),
	  legend.justification=c(1,0.5)	  
)
# 或者用分面实现分组
tp + geom_segment(aes(yend=name), xend=0, colour='grey50') +
  geom_point(size=3, aes(colour=lg)) +
  theme(panel.grid.major.y=element_blank()) +
  facet_grid(lg~., scale='free_y', space='free_y')



?geom_dotplot

# Wilkinson点图-和别的点图有什么不一样呢,没理解
library(gcookbook)
countries2009 <- subset(countries, Year==2009&healthexp>2000)
head(countries2009)
p <- ggplot(countries2009, aes(x=infmortality))
p + geom_dotplot()
# 按x轴对数据进行分组，在y轴进行堆积，y轴没有明确含义,只是把数据堆积起来了
# 一个点代表一个观测值
p + geom_dotplot(binwidth=0.25, method='dotdensity') + 
  # method用histdot更符合认识, rug标识数据点的位置
  geom_rug()+
  # 移除刻度线
  scale_y_continuous(breaks=NULL)+
  # 移除y轴标签
  theme(axis.title.y=element_blank())
# 中心堆叠，y轴堆成分布
p + geom_dotplot(binwidth=0.25, stackdir='center')
p + geom_dotplot(binwidth=0.25, stackdir='centerwhole')

# 基于分组数据绘制分组点图
library(gcookbook)
p <- ggplot(heightweight, aes(x=sex, y=heightIn))
p +  geom_dotplot(binaxis='y', binwidth=0.5, stackdir='center')
p +  geom_dotplot(binaxis='y', binpositions='all', binwidth=0.5, stackdir='center')
# 点图和箱线图叠加
sp <- ggplot(heightweight, aes(x=sex, y=heightIn))
sp + geom_boxplot(outlier.colour=NA, width=0.4)+
     geom_dotplot(binaxis='y', binwidth=0.5, stackdir='center', fill=NA)
# x轴是数值型变量时
sp + geom_boxplot(aes(x=as.numeric(sex)+0.2, group=sex), width=0.25) +
  geom_dotplot(aes(x=as.numeric(sex)-0.2, group=sex), 
               binaxis='y', binwidth=0.5, stackdir='center')+
  scale_x_continuous(breaks=1:nlevels(heightweight$sex), 
		 labels=levels(heightweight$sex))







