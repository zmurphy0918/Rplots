# 2021-12-29 
# 散点图

library(ggplot2)

?geom_point

# 简单散点图,分组变量必须是因子型或字符串型
library(gcookbook)
# 颜色分类
p1<-ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex, shape=sex))
p1 + geom_point()
# 连续变量用于颜色
p2<-ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb))
p2 + geom_point()
# 连续变量用于大小
p3<-ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb))
p3 + geom_point()
# 连续变量超过两个时，需要把他们映射到其它图形属性上，如大小和颜色
p4<-ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb, colour=sex))
p4 + geom_point(alpha=0.5)+
   scale_size_area() # 数据点面积正比于变量值


# 数据重叠
# 可以用透明度
# 也可以数据点分箱并以矩形来表示，同时将数据点的密度映射为颜色,新知识
sp<-ggplot(diamonds, aes(x=carat, y=price))
sp + geom_bin2d()
sp + geom_bin2d(bins=50) + 
  scale_fill_gradient(low="green", high='red', limits=c(0, 6000))
# 数据点分箱并以六边形表示，新知识
# 但是六边形还是矩阵有啥区别呢?没有啊，就只是好看一点啊
# install.packages('hexbin')
library(hexbin)
sp + stat_binhex() +
    scale_fill_gradient(low="lightblue", high='red', limits=c(0, 6000))

# 数据抖动-有数据轴对应离散型数据时
sp1<-ggplot(ChickWeight, aes(x=Time, y=weight))
sp1 + geom_point()
sp1 + geom_point(position='jitter')
sp1 + geom_point(position=position_jitter(width=0.5, height=0))


# 箱线图-一个离散轴一个连续轴时
sp1 + geom_boxplot(aes(group=Time))


?stat_smooth
?geom_smooth区别在哪里？

# 添加回归模型拟合线
library(gcookbok)
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + stat_smooth(method=lm, se=FALSE) #不带置信域
sp + geom_point() + stat_smooth(method=lm, level=0.99) # 99%置信域
# stat_smooth中的拟合参数还有loess等
# 逻辑回归Logistic拟合
library(MASS)
b<-biopsy
b$classn[b$class == 'benign'] <- 0
b$classn[b$class == 'malignant'] <- 1
bp <- ggplot(b, aes(x=V1, y=classn))
bp + geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4,
    shape=21, size=1.5)+
    stat_smooth(method=glm, method.args=list(family=binomial))

# 针对不同的group绘制拟合线:
# 方法一,模型用smooth
sps <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) 
sps + geom_point() + geom_smooth()
# 默认情况下不外推，需要外推的话，需要设置fullrange参数
sps + geom_point() + geom_smooth(method=lm, fullrange=TRUE)
# 方法二：切分数据，对各个部分执行函数，对结果进行重组,模型用line
library(gcookbook)
library(plyr)
make_model <- function(data){
	lm(heightIn~ageYear, data)
}
models <- dlply(heightweight, 'sex', .fun=make_model)
models
predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100){
	if (is.null(xrange)){
         if (any(class(model) %in% c('lm', 'glm')))
		xrange <- range(model$model[[xvar]])
         else if (any(class(model) %in% 'loess'))
		xrange <- range(model$x)	
	}
	newdata <- data.frame(x=seq(xrange[1], xrange[2], length.out=samples))
	names(newdata) <- xvar
	newdata[[yvar]] <- predict(model, newdata=newdata)
	newdata
}
predvals <- ldply(models, .fun=predictvals, xvar='ageYear', yvar='heightIn')
sps + geom_point() +
  geom_line(data=predvals)


# 向散点图添加拟合线
library(gcookbook)
model <- lm(heightIn~ageYear+I(ageYear^2), heightweight)
model
# 创建包含ageYear的列，并进行插值
xmin <- min(heightweight$ageYear)
xmax <- max(heightweight$ageYear)
predicted <- data.frame(ageYear=seq(xmin, xmax, length.out=100))
predicted$heightIn <- predict(model, predicted)
predicted
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + geom_line(data=predicted, size=1)
# 两种预测方式对比
modlinear <- lm(heightIn~ageYear, heightweight)
modloess <- loess(heightIn~ageYear, heightweight)
predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100){
	if (is.null(xrange)){
         if (any(class(model) %in% c('lm', 'glm')))
		xrange <- range(model$model[[xvar]])
         else if (any(class(model) %in% 'loess'))
		xrange <- range(model$x)	
	}
	newdata <- data.frame(x=seq(xrange[1], xrange[2], length.out=samples))
	names(newdata) <- xvar
	newdata[[yvar]] <- predict(model, newdata=newdata)
	newdata
}
lm_predicted <- predictvals(modlinear, 'ageYear', 'heightIn')
loess_predicted <- predictvals(modloess, 'ageYear', 'heightIn')
sp + geom_point()+
   geom_line(data=lm_predicted, colour='red', size=0.8)+
   geom_line(data=loess_predicted, colour='blue', size=0.8)


# 散点图矩阵
library(gcookbook)
c2009 <- subset(countries, Year==2009, select=c(Name, GDP, laborrate, healthexp, infmortality))
pairs(c2009[,2:5])
# 输出相关系数
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...){
	usr <- par('usr')
	on.exit(par(usr))
	par(usr=c(0,1,0,1))
	r<-abs(cor(x,y,use='complete.ob'))
	txt<-format(c(r,0.1234567), digits=digits)[1]
	txt<-paste(prefix, txt, sep="")
	if(missing(cex.cor)) cex.cor<-0.8/strwidth(txt)
	text(0.5, 0.5, txt, cex=cex.cor*(1+r)/2)
}
panel.hist <- function(x, ...){
	usr <- par('usr')
	on.exit(par(usr))
	par(usr=c(usr[1:2], 0, 1.5))
	h<-hist(x, plot=FALSE)
	breaks<-h$breaks
	nB<-length(breaks)
	y<-h$counts
	y<-y/max(y)
	rect(breaks[-nB],0,breaks[-1], y,col='white',...)
}
pairs(c2009[,2:5], upper.panel=panel.cor, diag.panel=panel.hist, lower.panel=panel.smooth)
# GGally包中的ggpairs也可以绘制散点图矩阵


# 气泡图
library(gcookbook)
cdat <- subset(countries, Year==2009& Name %in% c('Canada', 'Ireland', 'United Kingdom', 'United States',
    'New Zealand', 'Iceland', 'Japan', 'Switzerland'))
p<-ggplot(cdat, aes(x=healthexp, y=infmortality, size=GDP))
p + geom_point(shape=21, fill='cornsilk')
p + geom_point(shape=21, fill='cornsilk') + scale_size_area(max_size=15) # GDP数值和面积成正比
# 有趣用法
hec <- HairEyeColor[,,'Male']+HairEyeColor[,,'Female']
library(reshape2)
hec <- melt(hec, value.name='count')
p <- ggplot(hec, aes(x=Eye, y=Hair)) 
p + geom_point(aes(size=count), shape=21, fill='lightblue')+
    scale_size_area(max_size=20)+
    geom_text(aes(y=as.numeric(Hair)-sqrt(count)/22, label=count), vjust=1, size=4)



# 添加属性
# 添加模型系数
library(gcokbook)
model <- lm(heightIn~ageYear, heightweight)
summary(model)
pred <- predictvals(model, 'ageYear', 'heightIn')
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + geom_line(data=pred)+
   annotate('text', label='R^2=0.42', x=16.5, y=52)
sp + geom_point() + geom_line(data=pred)+
   annotate('text', label='R^2==0.42', parse=TRUE, x=16.5, y=52)
# 数学表达式美学改善用parse实现
expression(r^2==0.42)
expression(r^2=0.42)

# 添加标签
# 手动设置
library(gcookbook)
head(countries)
sp<-ggplot(subset(countries, Year==2009&healthexp>2000), 
           aes(x=healthexp, y=infmortality))
sp + geom_point() + annotate("text", x=4350, y=5.4, label='Canada')+
   annotate("text", x=7400, y=6.8, label='USA')
# 自动设置-全部标签
sp + geom_point() +  geom_text(aes(label=Name), size=4)
sp + geom_point() +  geom_text(aes(y=infmortality+0.1, label=Name), size=4, vjust=0)
sp + geom_point() +  geom_text(aes(x=healthexp+100, label=Name), size=4, hjust=0)
# 自动设置-部分标签
cdat<-subset(countries, Year==2009&healthexp>2000)
cdat$Name1 <- cdat$Name
idx<- cdat$Name1 %in% c('Canada', 'Ireland', 'United Kingdom', 'United States',
    'New Zealand', 'Iceland', 'Japan', 'Switzerland')
cdat$Name1[!idx] <- NA 
sp2 <-ggplot(subset(cdat, Year==2009&healthexp>2000), 
           aes(x=healthexp, y=infmortality))
sp2 + geom_point() +  geom_text(aes(x=healthexp+100, label=Name1), size=4, hjust=0)















