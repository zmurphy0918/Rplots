# 2021-12-28
# ����ͼ,
# x���y�ᶼ����ֵ�ͣ����
# x��Ϊ�����ͣ���Ҫʹ��aes(group=1)������������һ������
library(ggplot2)
?geom_line

# ������ͼ
BOD
p1 <- ggplot(BOD, aes(x=Time, y=demand))
p1 + geom_line()
BOD1<-BOD
BOD1$Time <- factor(BOD1$Time)
p2 <- ggplot(BOD1, aes(x=Time, y=demand, group=1)) # ע��x��û��6��ȡֵ
p2 + geom_line()


# �������ͼ
library(plyr)
tg <- ddply(ToothGrowth, c("supp","dose"), summarise, length=mean(len))
t1 <- ggplot(tg, aes(x=dose, y=length, colour=supp))
t1 + geom_line()
t2 <- ggplot(tg, aes(x=dose, y=length, linetype=supp))
t2 + geom_line()
t3 <- ggplot(tg, aes(x=factor(dose), y=length, colour=supp, group=supp)) # ��ɢ��ת��������ָ��group
t3 + geom_line()
# dplyr����pandas, dplyr-dataframe plier
# plyr
# ddply����tapply
# apply,�����������飬����/��/�к��н��м��㣬���ʸ�������顢����
# lapply,list apply�������,����ͬ�����ȵĶ��󣬶�ÿ��Ԫ�ؽ��в���
# sapply,�����б�������������֡������ͬ�����ȵ��б�������������
# tapply,���룿,����ÿ������ˮƽ�ĺ��������أ�
# vapply
# mapply
m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
a_m1 <- apply(m1, MARGIN=2, sum)
lmn_cars <- lapply(mtcars, min) # �����б�
smn_cars <- sapply(mtcars, min) # ��������
t_iris <- tapply(iris$Sepal.Width, iris$Species, median)

# x���y�ᷴת
e1 <- ggplot(economics, aes(x=date, y=unemploy))
e1 + geom_line()
e2 <- ggplot(economics, aes(x=unemploy, y=date))
e2 + geom_line()  # ����ʾ��
e2 + geom_line(orientation='y')  # ��ȷʾ��

# ����ͼ����-����ͼ
# geom_path ��˳�������ͼ
# geom_step ��ͨ������ͼ���������ͼ
recent <- subset(economics, date>=as.Date("2013-01-01"))
e3 <- ggplot(recent, aes(x=date, y=unemploy))
e3 + geom_step()


# ���϶�Ϊ�����ߣ�
# ggplot2���вο���ˮƽ��(geom_hline)����ֱ��(geom_vline)��б��(geom_abline��
# �߶κ�����: geom_segment��geom_spoke��geom_curve
?geom_hline
library(gcookbook)
h1 <- ggplot(heightweight,aes(x = ageYear, y = heightIn, colour = sex))
h1 + geom_point() +
  geom_hline(aes(yintercept = 60), colour='blue')+
  geom_vline(aes(xintercept = 14), colour='red') +
  geom_abline(aes(intercept = 37.4, slope = 1.75))  # ����б�ʺͽؾ�


?geom_area����geom_ribbon���������
?geom_ribbon,����ͼ��ymax,ymin���ǵķ�Χ

# ���ͼ
sunspotyear <- data.frame(
	Year=as.numeric(time(sunspot.year)),
	Sunspot=as.numeric(sunspot.year)
)
s <- ggplot(sunspotyear, aes(x=Year, y=Sunspot))
s + geom_area(fill='purple', alpha=0.2)+
 geom_line()

# �ѻ����ͼ
# �ѻ����ͼ��Ҫ���ǿ���ʽwide format��ggplot2Ҫ�����ݱ����ǳ���ʽlong format
# ������tidyr��reshape2��
library(gcookbook)
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) # fill?
s + geom_area(alpha=0.7) # Ĭ����positionΪstack
s + geom_area(position='fill')
# ��תͼ���ѻ�˳��û����,û�з�ת
library(plyr)
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) 
s + geom_area(alpha=0.6)

# �ٷֱȶѻ����ͼ
s <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup))
s + geom_area(position='fill')

# ����ͼ
library(plyr)
n <-ddply(uspopage, 'Year', summarize, max_val=max(Thousands), min_val=min(Thousands))
ss <- ggplot(n, aes(x=Year, y=(min_val+max_val)/2))
ss + geom_ribbon(aes(ymin=min_val, ymax=max_val), colour='gray', alpha=0.3)
# ��������,�����Ȼ����򣬺����ߣ�����Ḳ��
ss + geom_ribbon(aes(ymin=min_val, ymax=max_val), colour='gray', alpha=0.3)+
  geom_line()


# ����
# �������ݱ��
# library(gcookbook)
g <- ggplot(worldpop, aes(x=Year, y=Population))
g + geom_line() + geom_point()

# �޸�����
p <- ggplot(BOD, aes(x=Time, y=demand))
p + geom_line(linetype='dashed', size=1, colour='blue')

# �޸����ݱ����ʽ
p + geom_line(linetype='dashed', size=1, colour='blue')+
 geom_point(size=3, shape=22, colour='darkred', fill='pink')


