# 2021-12-29
# �������ݷֲ�

library(ggplot2)
?geom_histogram
?geom_boxplot

# ��ֱ��ͼ
binsize <- diff(range(faithful$waiting))/15 # �趨���
p <- ggplot(faithful, aes(x=waiting))
p + geom_histogram(binwidth=binsize, fill='lightblue', colour='black', origin=31)
# ������ࡢ���


# ����ֱ��ͼ
library(MASS)
head(birthwt)
p1 <- ggplot(birthwt, aes(x=bwt))
p1 + geom_histogram(fill='white', colour='black')+
  facet_wrap(vars(smoke))
p1 + geom_histogram(fill='white', colour='black')+
  facet_grid(smoke~., scale='free')
# �޸ķ����ǩ
birthwt1 <- birthwt
birthwt1$smoke <-factor(birthwt1$smoke)
library(plyr)
birthwt1$smoke <- revalue(birthwt1$smoke, c('0'='no smoke', '1'='smoke'))
p2 <- ggplot(birthwt1, aes(x=bwt))
p2 + geom_histogram(fill='white', colour='black')+
  facet_grid(smoke~., scale='free')

# Ƶ�������-��ֱ��ͼ��Ϣһ����ֻ����line����bar
p<-ggplot(faithful, aes(x=waiting))
p+geom_freqpoly()



# �ܶ�ͼ
# һ���ܶ�����
w1 <- ggplot(faithful, aes(x=waiting))
w1 + geom_density(fill='pink')
# �����ܶ�����
w2 <- ggplot(faithful, aes(x=waiting))
w2 + geom_line(stat="density", adjust=0.25, colour='red')+
  geom_line(stat="density")+
  geom_line(stat="density", adjust=2, colour='blue')
# �����ܶ�����
birthwt1 <- birthwt
birthwt1$smoke <- factor(birthwt1$smoke)
bw1 <- ggplot(birthwt1, aes(x=bwt, colour=smoke)) 
bw1 + geom_density()
bw2 <- ggplot(birthwt1, aes(x=bwt, y=..density..))
bw2 + geom_histogram(binwidth=200, fill='cornsilk', colour='grey60', size=0.2)+
   geom_density()+
   facet_grid(smoke~.)



# ����ͼ
?geom_boxplot
# ע��һ��ggplot2��boxplot��base�е�boxplot������
library(MASS)
ps<-ggplot(birthwt, aes(x=factor(race), y=bwt))
ps + geom_boxplot(outlier.size=1.5, outlier.shape=21, width=0.5)
# �Ӳۿ�
ps + geom_boxplot(notch=TRUE)

# С����ͼ-��Ӧ�ܶ����߷ֲ�
library(gcookbook)
p <- ggplot(heightweight, aes(x=sex, y=heightIn))
p + geom_violin()+
    geom_boxplot(width=0.1, fill='black', outlier.colour=NA)+
    stat_summary(fun=median, geom='point', fill='white', shape=21, size=2.5)
# �ܶ�����ƽ���̶�����
p + geom_violin(adjust=2)  # ��ƽ��
p + geom_violin(adjust=0.5)# Ƿƽ��


geom_bin


# ��ά���ݵ��ܶ�ͼ-��Ӧ����Ϣֻ������
?stat_density2d
# �õȸ���
p <- ggplot(faithful, aes(x=eruptions, y=waiting))
p + geom_point() + stat_density2d(aes(colour=..level..))  # ����÷�û����
# ����Ƭͼ
p + stat_density2d(aes(fill=..density..), 
	geom='raster', contour=FALSE)  # դ��ͼ���ܶ�ӳ������ɫ
p + stat_density2d(aes(fill=..density..), 
	geom='raster', contour=FALSE, h=c(0.5, 5))  # դ��ͼ���ܶ�ӳ������ɫ����Сx��y�����
p + geom_point() + stat_density2d(aes(alpha=..density..), 
	geom='tile', contour=FALSE)    # ��Ƭͼ���ܶ�ӳ���alpha





