# 2021-12-30
# �ǳ���ĵ�ͼ
library(ggplot2)


# Cleveland��ͼ-��������ͼ�����Ӿ����ң���֤�ɶ���
library(gcookbook)
tophit <- tophitters2001[1:25, ]
p <- ggplot(tophit, aes(x=avg, y=name)) 
p + geom_point()
# ����y�����򣬰���x������
p <- ggplot(tophit, aes(x=avg, y=reorder(name, avg)))
p + geom_point(size=3) + 
   theme(panel.grid.major.x=element_blank(),
	   panel.grid.minor.x=element_blank(),
	   panel.grid.major.y=element_line(colour='grey60', linetype='dashed')
)
# ��������
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]
tophit$name <- factor(tophit$name, levels=nameorder)
tp <- ggplot(tophit, aes(x=avg, y=name))
tp + geom_segment(aes(yend=name), xend=0, colour='grey50') +
  geom_point(size=3, aes(colour=lg)) +
  theme(panel.grid.major.y=element_blank(),
	  legend.position=c(1,0.55),
	  legend.justification=c(1,0.5)	  
)
# �����÷���ʵ�ַ���
tp + geom_segment(aes(yend=name), xend=0, colour='grey50') +
  geom_point(size=3, aes(colour=lg)) +
  theme(panel.grid.major.y=element_blank()) +
  facet_grid(lg~., scale='free_y', space='free_y')



?geom_dotplot

# Wilkinson��ͼ-�ͱ�ĵ�ͼ��ʲô��һ����,û����
library(gcookbook)
countries2009 <- subset(countries, Year==2009&healthexp>2000)
head(countries2009)
p <- ggplot(countries2009, aes(x=infmortality))
p + geom_dotplot()
# ��x������ݽ��з��飬��y����жѻ���y��û����ȷ����,ֻ�ǰ����ݶѻ�������
# һ�������һ���۲�ֵ
p + geom_dotplot(binwidth=0.25, method='dotdensity') + 
  # method��histdot��������ʶ, rug��ʶ���ݵ��λ��
  geom_rug()+
  # �Ƴ��̶���
  scale_y_continuous(breaks=NULL)+
  # �Ƴ�y���ǩ
  theme(axis.title.y=element_blank())
# ���Ķѵ���y��ѳɷֲ�
p + geom_dotplot(binwidth=0.25, stackdir='center')
p + geom_dotplot(binwidth=0.25, stackdir='centerwhole')

# ���ڷ������ݻ��Ʒ����ͼ
library(gcookbook)
p <- ggplot(heightweight, aes(x=sex, y=heightIn))
p +  geom_dotplot(binaxis='y', binwidth=0.5, stackdir='center')
p +  geom_dotplot(binaxis='y', binpositions='all', binwidth=0.5, stackdir='center')
# ��ͼ������ͼ����
sp <- ggplot(heightweight, aes(x=sex, y=heightIn))
sp + geom_boxplot(outlier.colour=NA, width=0.4)+
     geom_dotplot(binaxis='y', binwidth=0.5, stackdir='center', fill=NA)
# x������ֵ�ͱ���ʱ
sp + geom_boxplot(aes(x=as.numeric(sex)+0.2, group=sex), width=0.25) +
  geom_dotplot(aes(x=as.numeric(sex)-0.2, group=sex), 
               binaxis='y', binwidth=0.5, stackdir='center')+
  scale_x_continuous(breaks=1:nlevels(heightweight$sex), 
		 labels=levels(heightweight$sex))






