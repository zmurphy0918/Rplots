setwd('D:/0R/Rprograms/20210208')
# part1-�������ݽṹ

# 1.1-����(ͬһ�������͵ļ���)
v1 <- 1:10
v2 <- seq(from=1,tp=20,by=2,length.out=5)
# along.with����һ������������ͬ
v3 <- rep(c(2,5,6),c(1,2,3))
v3 <- rep(c(2,5,6),each=2)
# �ڶ�����������Ϊ����,���ϼ����ظ�˳��ͬ

w <- vector(length=8)#�������ȶ��������ĳ���
w[1] <- 59
w[2] <- 53.5
w[3] <- 55
w[4] <- 53.5
w[5] <- 52.5
w[6] <- 57.5
w[7] <- 53
w[8] <- 55
# ����Ԫ�ض����������ܻ�ȡw��ֵ�����򱨴�

# 1.2-����Ϊ2ά�ģ��������ͱ�����ͬ��
m1 <- matrix(data=c(1:12), nrow=3, ncol=4, byrow=TRUE,
             dimnames=list(c('one','two','three'), c('A','B','C','D')))
# dimnames(m1) <- list(c('one','two','three'), c('A','B','C','D'))
# rownames(), colnames()�ֱ��ƶ�����������
m1['two','C']
m1[c('two','three'), c('B','C')]
m1[-c(2,3),-c(2,3)] #ֻ�ܰ���������ѯ


# 1.3-���飨��ά�ģ��������ͱ�����ͬ��
a <- array(data=1:24, dim=c(2,4,3))
dimnames(a)[[1]] <- c('m','n')
dimnames(a)[[2]] <- c('A','B','C','D')
dimnames(a)[[3]] <- c('dim1','dim2','dim3')
# ά�Ȼ���
new_a <- aperm(a, c(3,1,2))
# �ڶ���������ʾ��ԭ����ά�ȵ���Ϊ�ڼ���ά,
# ����ԭ��ά��Ϊ2*4*3,���ڵ�ά�ȸ�Ϊ4*3*2
# 2-��Ϊ��3��ά,4-��Ϊ��1��ά,3-��Ϊ��2��ά

# 1.4-�б�(���Դ�Ų�ͬ���͵����ݽṹ)������python���ֵ�
l1 <- list(c('red','green'),c(1:3),'blue')
l2 <- list(name='alice',age=c(2,3,6))
names(l1) <- c('color1','nums2','color3')
l1$nums2[3]
l2[[2]];l2[['age']]
# ����ɾ����Ԫ��
l1[4] <- 'new_factor'
l1[4] <- NULL

l2 <- list(1:2, c('a','b','c'), 10)
names(l1) <- c('col1', 'col2', 'col3')
mergelist <- c(l1, l2)

# 1.5-���ݿ�(���Դ�Ų�ͬ���͵����ݽṹ)
name <- c('alice','bobo','celin')
age <- c(20,50,35)
country <- c('china','england','america')
df <- data.frame(name, age, country)
df[3]  #�������ݿ�
df[[3]] #��������
df[['country']]; df$name
# 1.6-����
f1 <- factor(x=rep(c(1,2,3,4,2,3),2),
             exclude=4,#�ų�������ĳ����ˮƽ
             labels=c('A','B','C'), 
             ordered=TRUE)
f1
class(f1)
nlevels(f1) #�鿴�м���ˮƽ

# attach()�����������ݿ��б�

c <- c(0/1, 0/0, 1/0, NA)
# ��������
# NA: ȱʧֵ
is.na() #λ���ϵ�ֵΪ��
# NULL: ��ֵ��û�������Ǹ�
is.null() #û��λ�ã�����Ϊ��
# Nan: ����ֵ
is.nan() #�����ϼ������