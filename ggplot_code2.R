# 2021-12-26
# scale�������
# ����ı�߲�����ָ��С������ÿ�����õĴ��༴����
scalex<-ls('package:ggplot2', pattern="^scale.+")
length(scalex)
scalex<-scalex[grep("([^_]+_){2}.+", scalex)]
unique(gsub("(([^_]+_){2}).+", "\\1***", scalex))
# ���Կ��������������ɫ�����Ρ���״����С��x\y��
# ����ɫ,����������Ҳ����ͬ���ؿ���
scalexx<-scalex[grepl("scale_fill.+", scalex)]
unique(gsub("(([^_]+_){2})(.+)", "\\3", scalexx))

# ��ɫ�������
# ������
ls("package:ggplot2", pattern="^scale_fill.+")
df<-expand.grid(1:30, 1:30)
colnames(df) <- c("x", 'y')
df$z <- rnorm(900)
p<-ggplot(data=df, aes(x=x, y=y, fill=z))
p+geom_raster()
p+geom_raster()+
  scale_fill_continuous(low='darkgreen', high='orangered', space='rgb')
# ��ɢ��
set.seed(100)
dms <- diamonds[sample(nrow(diamonds),500),]
p <- ggplot(data=dms, aes(x=carat, y=price, color=cut))
p + geom_point() + scale_color_discrete()
# ����������ɫ����Χ��h�������Ͷȣ�c�������ȣ�l����ȡ��ɫ�������׶�
p + geom_point() + scale_color_discrete(h=c(150,350), c=80, l=60)
# ��manual�ȽϷ���
p + geom_point() + scale_color_manual(values=rainbow(5))
p + geom_point() + scale_color_manual(values=c('blue','cyan','yellow','orange','red'))
# brewer����ʹ��Ԥ����ĵ�ɫ�壬��������Ҫ�ǣ�û��manual����
x <- sample(LETTERS,13); y <- 1:13
qplot(x=x, y=y, fill= x, geom='bar') + scale_fill_brewer(palette="YlOrRd")

# ������������
ls("package:ggplot2", pattern="^scale_x.+")
p <- ggplot(data=dms, aes(x=carat, y=price))
p + geom_point()
# ���ÿ̶�λ��breaks
bks <- pretty(range(dms$price), 10)
p + geom_point() + scale_y_continuous(breaks=bks)
# ���ÿ̶ȱ�ǩlabels
bks <- c(0, 2000, 10000, 15500, 18000)
p + geom_point() + 
  scale_y_continuous("Price (*1000)", breaks=bks, labels=bks/1000)
# ���÷�Χlimits���������Ժ������Ͷ���Ч
p + geom_point() + 
  scale_x_continuous(limits=c(0.5,1.5))
x <- sample(LETTERS,13); y <- 1:13
qplot(x=x, y=y, fill=x, geom='bar') + scale_x_discrete(limits=c('M', 'T', 'Y'))
# �������ݵ��������������trans���������ݲ�������ֵ����ݾ���logת��
p+geom_point()+
  scale_y_continuous(trans='log10')+
  ggtitle('scale_y_continuous(trans="log10")')
p+geom_point()+
  scale_y_log10()+
  ggtitle("scale_y_log10()")

# �����ת��
# �����ı����������ۣ�����Ӱ�쵽���ڽ���ӳ�������
lmx <- glm(price~carat, data=dms)
gs1 <- geom_line(aes(y=lmx$fitted.values), size=3, color='red')
gs2 <- geom_smooth(aes(group=1), method="lm", se=FALSE, size=1.5)
p + geom_point() + gs1 + gs2
p + geom_point() + gs1 + gs2  + scale_x_log10()

# ��ߵ�ͨ�ò���
# ����breaks\labels����names,���ڸı����õ�scale������
qplot(x=carat, y=price, color=cut, data=dms) + scale_color_hue('Diamond Cut')
qplot(x=carat, y=price, color=cut, data=dms) + scale_y_continuous('Diamond Cut')