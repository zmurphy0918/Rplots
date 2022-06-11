# 2021-12-16 ggplot
# 2021-12-22 ggplot
library(ggplot2)

# ggplot���ݲ���Ĺ�������ӳ��ͷ���
# ӳ���ǰ����ݿ��������ѧ���Զ�Ӧ
# ӳ�����Ͱ�������ɫӳ�䡢��״ӳ�䡢λ��ӳ�䡢�������ͣ�ָ�������˳���ַ���ӳ�䣩
# ��Ҫͨ��aes����ʵ��
df<-iris
p<-ggplot(data=df, aes(x=Sepal.Length, y=Petal.Length))
p+geom_point()
p+geom_point()+aes(color=Species, size=Petal.Length)

# ӳ��ı��ָʲô��ɫ��ʾ�������ݣ�չʾ�ߴ�ȣ�������ɫ��ߡ���״��ߡ����ͱ�ߵ�
# ��ɫ���������ߵ��趨�Ƚ϶�
cls <- terrain.colors(length(levels(df$Species)))
p+geom_point()+aes(color=Species)+scale_color_manual(values=cls)
# ͼ���Զ�ӳ��
p+geom_boxplot(aes(x=Species, y=Petal.Length))
p+geom_boxplot(aes(x=Species, y=Petal.Length, fill=Species))
p+geom_boxplot(aes(x=Species, y=Petal.Length, fill=Species))+
  scale_fill_manual(values=rep('cyan', length(levels(df$Species))))
# qplot�����׷����ĵط�
qplot(x=Species, y=Petal.Length, data=df, geom="boxplot", fill="cyan")
qplot(x=Species, y=Petal.Length, data=df, geom="boxplot", fill=I("cyan"))
# I��ʾ��Ϊ�̶�ֵ���������qplot���ÿ��Բ���

# λ������ӳ��
# ��������ߵ�ͼ
pre<-lm(Petal.Length~Species, data=df)
df2 <- as.data.frame(predict(pre, data.frame(Species=unique(df$Species)), se=TRUE)[c(1,2)])
df2$Species <- unique(df$Species)
df2$se.fit<-2*df2$se.fit
# �Զ��廭��
se<-ggplot(data=df2,aes(x=Species, y=fit, ymin=fit-se.fit, ymax=fit+se.fit, color=Species))
se+geom_pointrange()
# Ĭ�ϻ���
se+geom_point()+geom_errorbar(width=0.2)
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)
# ���������᷶Χ
se+geom_point()+ylim(-2,6)
se+geom_point()+scale_y_continuous(limits=c(-2,6))
# ����ͼ���������᷶Χ�÷�,Ϊʲô�أ�
se+geom_bar(stat='identity', aes(fill=Species))+coord_cartesian(ylim=c(-2,6))
# λ��
px<-ggplot(data=df, aes(x=Sepal.Length, y=Petal.Length))
px+geom_point()+
  annotate('text',x=6, y=4,label='pp', color='red')
px+geom_point()+
  annotate('pointrange',x=6, y=4, ymin=3, ymax=5, color='red')
px+geom_point()+
  annotate('segment',x=6.5, xend=5, y=5, yend=4, color='red')

# ��������ӳ��
tx<-ggplot(data=df, aes(x=Sepal.Width, y=Sepal.Length, color=Species))
# ���Կ�����������Ǹ��ݷ���������Ԥ��õ�
tx+geom_point()+
  geom_smooth(method='lm', se=FALSE)
# ��Ҫ��ȫ���������ʱ��Ӧ�趨Ϊһ����
tx+geom_point()+
  geom_smooth(aes(group=1),method='lm', se=FALSE)
# Ҳ���ƶ��������Ϊ��������,ͬʱ����linetype����
tx+geom_point()+
  geom_smooth(aes(group=Petal.Length,line), method='lm', se=FALSE)

# �������ÿ��Խ���Ҫ��ͬ�������͵�ͼ�����һ��
# ֱ���ûᱨ��
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)+
  geom_line()
# ��������
se+geom_bar(stat='identity', aes(fill=Species))+geom_errorbar(width=0.2)+
  geom_line(aes(group=1), color='black')

# Ҳ���Ըı�����ͼ����ӵ�˳��,order�ؼ���
# aes_string�Ƚ�����



# facet����
# facet������һҳ��ͼ�Ƿ����ģ�����Щͼ�ζ�����ȫ��ͬ��ͼ��
# ��������������һ��ҳ����ͼ�Σ�������һҳ��ͼͨ��par()ʵ��
set.seed(100)
d.sub<-diamonds[sample(nrow(diamonds), 500),]
head(d.sub)
p<-ggplot(data=d.sub, aes(x=carat,y=price))
# facet_wrap���Ʒ���,�����ݷ���ֻ����һ����׼
# ��ͬ������ݴ����Ҵ��ϵ��µĲ���˳���������
levels(d.sub$cut)
# ���Կ���ͼ������˳���levels����һ��
p+geom_point()+
  facet_wrap(~cut, nrow=3, scales='free')+
  ggtitle('scale="free and pic row changed"')

# facet_grid,�������,�����ж�������׼
p+geom_point(alpha=0.2)+
  facet_grid(color~cut, scales='free')
p+geom_point(alpha=0.2)+
  facet_grid(color~cut, margins=TRUE, 
             scales='free', space='free')
# ���˺�ǰΪ���б�׼�����˺ź�Ϊ���б�׼��
# margins���ڻ���ĳ��ά��
# space����������free,free_x,free_yʱ,��Сͼ������̶ȱ���һ��
# �������Ϸ����ͼ
p+geom_point(alpha=0.2)+
  facet_grid(color+clarity~cut,scales='free')



# ͼ������
# ͼ��ļ�����ͳ������
# ggplot2�м���ÿ�ּ������Ͷ��ж�Ӧ��ͳ�����ͣ����߲��ּ�
# �������÷�ʽΪgeom_��ͳ�����÷�ʽΪstat_
ls("package:ggplot2", pattern="^geom_.+")
ls("package:ggplot2", pattern="^stat_.+")
help(geom_point)
# mapping��data��ggplot��������data,����mapping
# ���ڼ���/ͳ������ʱ����Ϊ�Ѿ������ݣ�һ��ֻ��Ҫָ��ӳ��
p+geom_point()
p+stat_identity()
(p+geom_point())$layers
(p+stat_identity())$layers

# ͼ���λ�ò���
# stack�ѻ���identityԭ�ز�����fill��䣬�ȶ����ݹ�һ���ٻ��Ƶ�ͼ�㶥��
# jitter�����һ�������ص���ðͷ��dodge����,���Ա�һ��
p<-ggplot(d.sub, aes(x=cut, y=price, fill=color))
p+geom_bar(stat='summary', fun='mean', position='stack')
p+geom_bar(stat='summary', fun='mean', position='fill')
p+geom_bar(stat='summary', fun='mean', position='dodge')
p+geom_bar(stat='summary', fun='mean', position='jitter') # ����
p+geom_point(position='identity')
p+geom_point(position='jitter')
p<-ggplot(d.sub, aes(x=price, color=cut, fill=cut))
p+stat_density(position='stack')
p+stat_density(position='fill')
p+stat_density(position='identity')
p+stat_density(position='identity',fill='transparent')

# ͼ�����
# ��ͬͼ��ʹ��ͬ�����ݣ����������ͻ�ͳ�������в��
datax<-data.frame(x=1:10, y=rnorm(10)+1:10)
p<-ggplot(datax, aes(x=x, y=y))
# ������ͼ��ȫ��ͬ
p+geom_point()+geom_line()
p+geom_point()+geom_smooth(method='lm')
# 2021-12-26
# ��ͬͼ����Ҫʹ�ò�ͬ���͵�����ʱ��ͼ��ĵ���˳�����Ҫע����
p<-ggplot(datax, aes(x=factor(x), y=y)) + xlab('x')
# Ӧ��������Ҫ�����͵�ͼ����Ϊӳ��Ϊ������Ȼ�����Ϊ��ɢ��ͼ����Լ�
p+geom_bar(stat='identity', fill='gray')+
  geom_line(aes(group=1), size=2)+
  geom_point(color='red')
p+geom_bar(stat='identity', fill='gray')+
  geom_smooth(aes(group=1), method='lm', size=2)