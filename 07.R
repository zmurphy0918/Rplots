# �����ܽ�
setwd('D:/0R/Rprograms/20210208')


# Part1-R��ȡ����
data.table-as.data.table #�ڴ治��
ffbase-read.table.ffdf() #д��Ӳ��



# Part2-ȱʧֵ����
# ����NULL, NA,  NaN(��ѧ����)
x <- c(1,2,3,3,3,3, NA)
m <- matrix(c(1:12), nrow=3)
colnames(m)<-c('A','B','C','D')
m[2,2] <- NA
m[1,3] <- NA
# 2.1-ʶ��ȱʧֵ
# NA
sum(is.na(x))
apply(is.na(m), MARGIN=2, FUN=sum)
# NaN
is.nan(x)
is.infinite(x)
complete.cases(m) #ʶ���������ݿ���û��ȱʧֵ����
summary(m)

# 2.2-չʾ��ȱʧֵ����
m[,!complete.cases(m)]
psych::describe(m) # psych������չʾȷʵ���
mice::md.pattern(m) # mice��������ʽչʾȱʧ���
VIM::aggr(VIM::sleep, numbers=TRUE, prop=TRUE) #ͼ�λ�չʾȱʧֵ
par(mfrow=c(1,1))
VIM::marginplot(VIM::sleep[c('Gest','Dream')],pch=c(20),
                cex.numbers=0.7,
                col=c("darkgray","red","blue"))
#̽��ȱʧֵ�������
cor(abs(is.na(m)))

# 2.3-������ȱʧֵ����
# ����
# ��ɾ��
na.omit(m)
# ���-��ֵ����λ��
m[is.na(m$B), 'B'] <- mean(m$B, na.rm=TRUE)
mm <- as.data.frame(apply(m, MARGIN=2, 
                          FUN=function(x){Hmisc::impute(x, mean)}))
mice::mice(mm, m=5) #������ݿ򡢾���

# VIM����չʾȱʧֵ
# Hmisc �ö��ֲ�ֵ����
# mice��ԭ����
# cat,��������ģ���ж�Ԫ����ͱ����Ķ��ز岹
subset()

# Part3-�ظ�ֵ����
x[!duplicated(x)]


# Part4-����ת��
# ������-��һ��
scale(x, center=TRUE, scale=TRUE)
# ������-���ȱ��롢�Ʊ���

# ��ɢ��



# Part5-��Ⱥֵ����



# Part6-ά�ȹ�Լ



# Part7-��ͬ��������
setdiff(x,y) #x��y�в�ͬ��Ԫ��
sweep()
# ��ֵ�����ݴ���

# �ַ������ݴ�������
s <- 'this is a string'
substr(s, 3, 8) # ��λ������
strsplit(s, split=' ')
sub(pattern='i', replacement='y', x=s ) #ֻ�滻��һ��
gsub(pattern='i', replacement='y', x=s ) # ȫ���滻
regexpr(pattern='is', text=s)
# ��ʽ����ȡ
stringr::str_split()
strsplit(s)

# ���������ݴ�������




# Part8-�ܵ�����
# %in%����ʾ������
# %>%����ʾ���Ҵ���
# %$%����ʾ���Ҵ����У�������ֱ�Ӱ��в���


