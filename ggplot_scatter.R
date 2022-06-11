# 2021-12-29 
# ɢ��ͼ

library(ggplot2)

?geom_point

# ��ɢ��ͼ,������������������ͻ��ַ�����
library(gcookbook)
# ��ɫ����
p1<-ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex, shape=sex))
p1 + geom_point()
# ��������������ɫ
p2<-ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb))
p2 + geom_point()
# �����������ڴ�С
p3<-ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb))
p3 + geom_point()
# ����������������ʱ����Ҫ������ӳ�䵽����ͼ�������ϣ����С����ɫ
p4<-ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb, colour=sex))
p4 + geom_point(alpha=0.5)+
   scale_size_area() # ���ݵ���������ڱ���ֵ


# �����ص�
# ������͸����
# Ҳ�������ݵ���䲢�Ծ�������ʾ��ͬʱ�����ݵ���ܶ�ӳ��Ϊ��ɫ,��֪ʶ
sp<-ggplot(diamonds, aes(x=carat, y=price))
sp + geom_bin2d()
sp + geom_bin2d(bins=50) + 
  scale_fill_gradient(low="green", high='red', limits=c(0, 6000))
# ���ݵ���䲢�������α�ʾ����֪ʶ
# ���������λ��Ǿ�����ɶ������?û�а�����ֻ�Ǻÿ�һ�㰡
# install.packages('hexbin')
library(hexbin)
sp + stat_binhex() +
    scale_fill_gradient(low="lightblue", high='red', limits=c(0, 6000))

# ���ݶ���-���������Ӧ��ɢ������ʱ
sp1<-ggplot(ChickWeight, aes(x=Time, y=weight))
sp1 + geom_point()
sp1 + geom_point(position='jitter')
sp1 + geom_point(position=position_jitter(width=0.5, height=0))


# ����ͼ-һ����ɢ��һ��������ʱ
sp1 + geom_boxplot(aes(group=Time))


?stat_smooth
?geom_smooth���������

# ���ӻع�ģ�������
library(gcookbok)
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + stat_smooth(method=lm, se=FALSE) #����������
sp + geom_point() + stat_smooth(method=lm, level=0.99) # 99%������
# stat_smooth�е���ϲ�������loess��
# �߼��ع�Logistic���
library(MASS)
b<-biopsy
b$classn[b$class == 'benign'] <- 0
b$classn[b$class == 'malignant'] <- 1
bp <- ggplot(b, aes(x=V1, y=classn))
bp + geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4,
    shape=21, size=1.5)+
    stat_smooth(method=glm, method.args=list(family=binomial))

# ��Բ�ͬ��group���������:
# ����һ,ģ����smooth
sps <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) 
sps + geom_point() + geom_smooth()
# Ĭ������²����ƣ���Ҫ���ƵĻ�����Ҫ����fullrange����
sps + geom_point() + geom_smooth(method=lm, fullrange=TRUE)
# ���������з����ݣ��Ը�������ִ�к������Խ����������,ģ����line
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


# ��ɢ��ͼ���������
library(gcookbook)
model <- lm(heightIn~ageYear+I(ageYear^2), heightweight)
model
# ��������ageYear���У������в�ֵ
xmin <- min(heightweight$ageYear)
xmax <- max(heightweight$ageYear)
predicted <- data.frame(ageYear=seq(xmin, xmax, length.out=100))
predicted$heightIn <- predict(model, predicted)
predicted
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + geom_line(data=predicted, size=1)
# ����Ԥ�ⷽʽ�Ա�
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


# ɢ��ͼ����
library(gcookbook)
c2009 <- subset(countries, Year==2009, select=c(Name, GDP, laborrate, healthexp, infmortality))
pairs(c2009[,2:5])
# ������ϵ��
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
# GGally���е�ggpairsҲ���Ի���ɢ��ͼ����


# ����ͼ
library(gcookbook)
cdat <- subset(countries, Year==2009& Name %in% c('Canada', 'Ireland', 'United Kingdom', 'United States',
    'New Zealand', 'Iceland', 'Japan', 'Switzerland'))
p<-ggplot(cdat, aes(x=healthexp, y=infmortality, size=GDP))
p + geom_point(shape=21, fill='cornsilk')
p + geom_point(shape=21, fill='cornsilk') + scale_size_area(max_size=15) # GDP��ֵ�����������
# ��Ȥ�÷�
hec <- HairEyeColor[,,'Male']+HairEyeColor[,,'Female']
library(reshape2)
hec <- melt(hec, value.name='count')
p <- ggplot(hec, aes(x=Eye, y=Hair)) 
p + geom_point(aes(size=count), shape=21, fill='lightblue')+
    scale_size_area(max_size=20)+
    geom_text(aes(y=as.numeric(Hair)-sqrt(count)/22, label=count), vjust=1, size=4)



# ��������
# ����ģ��ϵ��
library(gcokbook)
model <- lm(heightIn~ageYear, heightweight)
summary(model)
pred <- predictvals(model, 'ageYear', 'heightIn')
sp <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + geom_line(data=pred)+
   annotate('text', label='R^2=0.42', x=16.5, y=52)
sp + geom_point() + geom_line(data=pred)+
   annotate('text', label='R^2==0.42', parse=TRUE, x=16.5, y=52)
# ��ѧ����ʽ��ѧ������parseʵ��
expression(r^2==0.42)
expression(r^2=0.42)

# ���ӱ�ǩ
# �ֶ�����
library(gcookbook)
head(countries)
sp<-ggplot(subset(countries, Year==2009&healthexp>2000), 
           aes(x=healthexp, y=infmortality))
sp + geom_point() + annotate("text", x=4350, y=5.4, label='Canada')+
   annotate("text", x=7400, y=6.8, label='USA')
# �Զ�����-ȫ����ǩ
sp + geom_point() +  geom_text(aes(label=Name), size=4)
sp + geom_point() +  geom_text(aes(y=infmortality+0.1, label=Name), size=4, vjust=0)
sp + geom_point() +  geom_text(aes(x=healthexp+100, label=Name), size=4, hjust=0)
# �Զ�����-���ֱ�ǩ
cdat<-subset(countries, Year==2009&healthexp>2000)
cdat$Name1 <- cdat$Name
idx<- cdat$Name1 %in% c('Canada', 'Ireland', 'United Kingdom', 'United States',
    'New Zealand', 'Iceland', 'Japan', 'Switzerland')
cdat$Name1[!idx] <- NA 
sp2 <-ggplot(subset(cdat, Year==2009&healthexp>2000), 
           aes(x=healthexp, y=infmortality))
sp2 + geom_point() +  geom_text(aes(x=healthexp+100, label=Name1), size=4, hjust=0)














