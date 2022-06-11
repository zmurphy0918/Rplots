# 2021-12-26
# scale标尺设置
# 这里的标尺并不是指大小，而是每种设置的大类即父类
scalex<-ls('package:ggplot2', pattern="^scale.+")
length(scalex)
scalex<-scalex[grep("([^_]+_){2}.+", scalex)]
unique(gsub("(([^_]+_){2}).+", "\\1***", scalex))
# 可以看到标尺设置由颜色、线形、形状、大小、x\y轴
# 看颜色,其他的类型也可以同样地看到
scalexx<-scalex[grepl("scale_fill.+", scalex)]
unique(gsub("(([^_]+_){2})(.+)", "\\3", scalexx))

# 颜色标尺设置
# 连续型
ls("package:ggplot2", pattern="^scale_fill.+")
df<-expand.grid(1:30, 1:30)
colnames(df) <- c("x", 'y')
df$z <- rnorm(900)
p<-ggplot(data=df, aes(x=x, y=y, fill=z))
p+geom_raster()
p+geom_raster()+
  scale_fill_continuous(low='darkgreen', high='orangered', space='rgb')
# 离散型
set.seed(100)
dms <- diamonds[sample(nrow(diamonds),500),]
p <- ggplot(data=dms, aes(x=carat, y=price, color=cut))
p + geom_point() + scale_color_discrete()
# 这种设置用色调范围（h）、饱和度（c）和亮度（l）获取颜色，不容易懂
p + geom_point() + scale_color_discrete(h=c(150,350), c=80, l=60)
# 用manual比较方便
p + geom_point() + scale_color_manual(values=rainbow(5))
p + geom_point() + scale_color_manual(values=c('blue','cyan','yellow','orange','red'))
# brewer可以使用预定义的调色板，但名字需要记，没有manual方便
x <- sample(LETTERS,13); y <- 1:13
qplot(x=x, y=y, fill= x, geom='bar') + scale_fill_brewer(palette="YlOrRd")

# 坐标轴标尺设置
ls("package:ggplot2", pattern="^scale_x.+")
p <- ggplot(data=dms, aes(x=carat, y=price))
p + geom_point()
# 设置刻度位置breaks
bks <- pretty(range(dms$price), 10)
p + geom_point() + scale_y_continuous(breaks=bks)
# 设置刻度标签labels
bks <- c(0, 2000, 10000, 15500, 18000)
p + geom_point() + 
  scale_y_continuous("Price (*1000)", breaks=bks, labels=bks/1000)
# 设置范围limits，对连续性和因子型都有效
p + geom_point() + 
  scale_x_continuous(limits=c(0.5,1.5))
x <- sample(LETTERS,13); y <- 1:13
qplot(x=x, y=y, fill=x, geom='bar') + scale_x_discrete(limits=c('M', 'T', 'Y'))
# 连续数据的坐标轴可以设置trans参数，数据不变而呈现的数据经过log转换
p+geom_point()+
  scale_y_continuous(trans='log10')+
  ggtitle('scale_y_continuous(trans="log10")')
p+geom_point()+
  scale_y_log10()+
  ggtitle("scale_y_log10()")

# 坐标尺转换
# 不仅改变坐标轴的外观，它还影响到用于建立映射的数据
lmx <- glm(price~carat, data=dms)
gs1 <- geom_line(aes(y=lmx$fitted.values), size=3, color='red')
gs2 <- geom_smooth(aes(group=1), method="lm", se=FALSE, size=1.5)
p + geom_point() + gs1 + gs2
p + geom_point() + gs1 + gs2  + scale_x_log10()

# 标尺的通用参数
# 除了breaks\labels还有names,用于改变设置的scale的名称
qplot(x=carat, y=price, color=cut, data=dms) + scale_color_hue('Diamond Cut')
qplot(x=carat, y=price, color=cut, data=dms) + scale_y_continuous('Diamond Cut')
