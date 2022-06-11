setwd('D:/0R/Rprograms/20210208')

# part1-���ݷֲ�
# �����������
dnorm(0.25, mean=0, st=1, log=FALSE) #������̬�ֲ��ĸ����ܶȺ�����ֵ
pnorm(0.75, mean=0, st=1, lower.tail=TRUE) #������̬�ֲ����ۼ��ܶȵ�ֵ
qnorm(0.5, mean=0, st=1, lower.tail=TRUE) #���ظ������ʵ��·�λ��
rnorm(n, mean=0, st=1) #������n����̬�ֲ�����������ɵ�����
# ���ڲ��ɷֲ���ָ���ֲ��������ֲ�Ҳһ��

# part2-��ͼ
# ֱ��ͼ
hist(data, breaks=c(), frequency=F)
# ���ܶ�ͼ
density(data)
# ����ֲ�����
ecdf(x)
# QQͼ
qqnorm()
qqline()
# ��Ҷͼ
stem(x)
# ����ͼ
boxplot(A,B,names=c('A','B'))

#��ˮƽ��ͼ����
plot()
pairs()
coplot(Weight~Height|Age)
dotchart(t(VADeaths), main='Death Rates')
contour()

dfMRural<-data.frame(rownames(VADeaths),VADeaths[,1],rep('male',each=5))
colnames(dfMRural) <- c('age','deathrate','gender')
dfFRural<-data.frame(rownames(VADeaths),VADeaths[,2],rep('female',each=5))
colnames(dfFRural) <- c('age','deathrate','gender')
Rural <- rbind(dfMRural, dfFRural)
rownames(Rural)<-NULL
# dotchartֻ����Ծ������������
dotchart(as.vector(Rural$deathrate), 
         groups=as.factor(Rural$age), 
         labels=unique(Rural$age),
         color=c("red",'blue'), #����ֻ�ı�����ɫ
         main='Death Rate of Virginia')
# ��ˮƽ��ͼ����
points()
lines()
text()
abline()
title()
axis()


# part3-��̬�Լ���
# Wͳ��������
shapiro.test(x)
# KSͳ��������
ks.test(x, 'pf', 2, 5)
# ����Լ���
cor.test(x, y, method='kendall')
# T����-������飬�ɶ���������
t.test()
# ��������ȵ��������
var.test(A, B)
# ����ֲ�����
binom.test()
# �ǲ�������
# pearson��������Ŷȼ��飬W��̬�Լ��飬KS����
chisq.test(c(335, 125, 160), p=c(9,3,4)/16) #�Ƿ�������۷ֲ�
chisq.test(matrix(c(60, 3, 32, 11),nrow=2),correct = FALSE) #�����������Լ���
# fisher��ȷ�������飬ÿ��ԪС��4
fisher.test(matrix(c(60, 3, 32, 11),nrow=2))
# ���ż���
binom.test()
# �ȼ���
cor.test(x, y, method='spearman') #spearman����ؼ���
cor.test(x, y, method='kendall') #kendall����ؼ���
# �ȼ���-wilkson
# ������ͬһ���������������,�ǳɶ���������
wilcox.test(x, mu=40, paired=TRUE)


