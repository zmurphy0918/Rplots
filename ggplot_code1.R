# 2021-12-16 ggplot
# 2021-12-22 ggplot
library(ggplot2)

# ggplot数据层面的工作包括映射和分面
# 映射是把数据框变量和美学属性对应
# 映射类型包括：颜色映射、形状映射、位置映射、特殊类型（指定分组和顺序、字符串映射）
# 主要通过aes函数实现
df<-iris
p<-ggplot(data=df, aes(x=Sepal.Length, y=Petal.Length))
p+geom_point()
p+geom_point()+aes(color=Species, size=Petal.Length)

# 映射的标尺指什么颜色表示哪种数据，展示尺寸等，包括颜色标尺、形状标尺、线型标尺等
# 颜色和坐标轴标尺的设定比较多
cls <- terrain.colors(length(levels(df$Species)))
p+geom_point()+aes(color=Species)+scale_color_manual(values=cls)
# 图例自动映射
p+geom_boxplot(aes(x=Species, y=Petal.Length))
p+geom_boxplot(aes(x=Species, y=Petal.Length, fill=Species))
p+geom_boxplot(aes(x=Species, y=Petal.Length, fill=Species))+
  scale_fill_manual(values=rep('cyan', length(levels(df$Species))))
# qplot中容易犯错的地方
qplot(x=Species, y=Petal.Length, data=df, geom="boxplot", fill="cyan")
qplot(x=Species, y=Petal.Length, data=df, geom="boxplot", fill=I("cyan"))
# I表示设为固定值，如果不在qplot中用可以不设

# 位置类型映射
# 画带误差线的图
pre<-lm(Petal.Length~Species, data=df)
df2 <- as.data.frame(predict(pre, data.frame(Species=unique(df$Species)), se=TRUE)[c(1,2)])
df2$Species <- unique(df$Species)
df2$se.fit<-2*df2$se.fit
# 自定义画法
se<-ggplot(data=df2,aes(x=Species, y=fit, ymin=fit-se.fit, ymax=fit+se.fit, color=Species))
se+geom_pointrange()
# 默认画法
se+geom_point()+geom_errorbar(width=0.2)
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)
# 限制坐标轴范围
se+geom_point()+ylim(-2,6)
se+geom_point()+scale_y_continuous(limits=c(-2,6))
# 柱形图限制坐标轴范围用法,为什么呢？
se+geom_bar(stat='identity', aes(fill=Species))+coord_cartesian(ylim=c(-2,6))
# 位置
px<-ggplot(data=df, aes(x=Sepal.Length, y=Petal.Length))
px+geom_point()+
  annotate('text',x=6, y=4,label='pp', color='red')
px+geom_point()+
  annotate('pointrange',x=6, y=4, ymin=3, ymax=5, color='red')
px+geom_point()+
  annotate('segment',x=6.5, xend=5, y=5, yend=4, color='red')

# 特殊类型映射
tx<-ggplot(data=df, aes(x=Sepal.Width, y=Sepal.Length, color=Species))
# 可以看出拟合曲线是根据分组后的数据预测得到
tx+geom_point()+
  geom_smooth(method='lm', se=FALSE)
# 需要对全部数据拟合时，应设定为一个组
tx+geom_point()+
  geom_smooth(aes(group=1),method='lm', se=FALSE)
# 也可制定别的列作为分组依据,同时更改linetype即可
tx+geom_point()+
  geom_smooth(aes(group=Petal.Length,line), method='lm', se=FALSE)

# 特殊作用可以将需要不同数据类型的图组合在一起
# 直接用会报错
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)+
  geom_line()
# 这样不会
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)+
  geom_line(aes(group=1), color='black')

# 也可以改变数据图层叠加的顺序,order关键字
# aes_string比较另类



# facet分面
# facet画出的一页多图是分组后的，且这些图形都是完全相同的图形
# 不是真正意义上一个页面多个图形，真正的一页多图通过par()实现
set.seed(100)
d.sub<-diamonds[sample(nrow(diamonds), 500),]
head(d.sub)
p<-ggplot(data=d.sub, aes(x=carat,y=price))
# facet_wrap缠绕分面,对数据分类只能用一个标准
# 不同组的数据从左到右从上到下的缠绕顺序进行排列
levels(d.sub$cut)
# 可以看到图表排列顺序和levels保持一致
p+geom_point()+
  facet_wrap(~cut, nrow=3, scales='free')+
  ggtitle('scale="free and pic row changed"')

# facet_grid,网格分面,可以有多个分类标准
p+geom_point(alpha=0.2)+
  facet_grid(color~cut, scales='free')
p+geom_point(alpha=0.2)+
  facet_grid(color~cut, margins=TRUE, 
             scales='free', space='free')
# 波浪号前为分行标准，波浪号后为分列标准，
# margins用于汇总某个维度
# space用于坐标轴free,free_x,free_y时,各小图坐标轴刻度保持一致
# 两个以上分组的图
p+geom_point(alpha=0.2)+
  facet_grid(color+clarity~cut,scales='free')



# 图层设置
# 图层的几何与统计设置
# ggplot2中几何每种几何类型都有对应的统计类型，两者不分家
# 几何设置方式为geom_，统计设置方式为stat_
ls("package:ggplot2", pattern="^geom_.+")
ls("package:ggplot2", pattern="^stat_.+")
help(geom_point)
# mapping和data在ggplot中是先有data,才有mapping
# 而在几何/统计设置时，因为已经有数据，一般只需要指定映射
p+geom_point()
p+stat_identity()
(p+geom_point())$layers
(p+stat_identity())$layers

# 图层的位置参数
# stack堆积，identity原地不动，fill填充，先对数据归一化再绘制到图层顶部
# jitter随机抖一抖，让重叠的冒头，dodge避让,往旁边一点
p<-ggplot(d.sub, aes(x=cut, y=price, fill=color))
p+geom_bar(stat='summary', fun='mean', position='stack')
p+geom_bar(stat='summary', fun='mean', position='fill')
p+geom_bar(stat='summary', fun='mean', position='dodge')
p+geom_bar(stat='summary', fun='mean', position='jitter') # 混乱
p+geom_point(position='identity')
p+geom_point(position='jitter')
p<-ggplot(d.sub, aes(x=price, color=cut, fill=cut))
p+stat_density(position='stack')
p+stat_density(position='fill')
p+stat_density(position='identity')
p+stat_density(position='identity',fill='transparent')

# 图层组合
# 不同图层使用同样数据，但几何类型或统计类型有差别
datax<-data.frame(x=1:10, y=rnorm(10)+1:10)
p<-ggplot(datax, aes(x=x, y=y))
# 这两种图完全不同
p+geom_point()+geom_line()
p+geom_point()+geom_smooth(method='lm')
# 2021-12-26
# 不同图层需要使用不同类型的数据时，图层的叠加顺序就需要注意了
p<-ggplot(datax, aes(x=factor(x), y=y)) + xlab('x')
# 应该先做需要因子型的图，因为映射为因子型然后调整为做散点图，相对简单
p+geom_bar(stat='identity', fill='gray')+
  geom_line(aes(group=1), size=2)+
  geom_point(color='red')
p+geom_bar(stat='identity', fill='gray')+
  geom_smooth(aes(group=1), method='lm', size=2)