setwd('D:/0R/Rprograms/20210208')
# options()

# part1-��ֵ��
# ��ѧ����
x <- c(-1, 0, 2)
y <- c(3, 8, 2)
x+y
x*y
5%%3 #ȡ����
5%/%3 #����
exp(x)
sqrt(y)

# ������ͳ��
fivenum(x)
max(y)
mean(y) 
sum(x)
range(y) #��Χ
sd(y)
median(y)
quantile(y, probs=seq(0,1,0.2))
g1 <- n/((n-1)*(n-2))*sum((x-mean(x))^3)/(sd(x))^3 #ƫ��ϵ��
g2 <- (n*(n+1))/((n-1)*(n-2)*(n-3))*sum((x-mean(x))^4)/((st(x))^4) #���ϵ��
       
# �������õĺ���
which.max(y) #���ֵ������
length(y)
sort(y) #�ı���������


# part2-�ַ���
s <- c('this', 'is', 'a', 'string')

paste(s, 1:3, sep='-') # ��������ƴ��
paste(s, collapse='+') # ��������ƴ��

# part3-������
sex <- c("M","F","M","M", "F")
sexf <- factor(sex)
height <- c(174, 165, 180, 171, 160)
sex.tab <- table(sexf, exclude='M') #������Ƶ��
tapply(height, INDEX=sex, FUN=mean) #����ͳ��

# part4-����
A<-matrix(1:6,nrow=2)
t(A) #ת��
det(matrix(c(1:4), ncol=2))#����ʽ
a <- 1:5; b <- 2*1:5
crossprod(a,b) #�ڻ���a%*%b
tcrossprod(a,b) #�����a%o%b
outer(a,b) #���

A <- array(c(1:8, 10),dim=c(3,3))
b <- c(1,1,1)
x <- solve(A,b) #�������
B <- solve(A) #�����

sm <- crossprod(A,A)
ev <- eigen(sm) #�������ֵ����������

svdA <- svd(A) #����ֵ�ֽ�

# ������ֱ
as.vector(A)
# ���ڶ�ά�Ƚ��в���
apply(A, MARGIN=2, sum)


# part3-��������
# mode��������
mode(s)
is.numeric(y)
as.character(x)
# length��������
x[5] <- 9 
length(y)<-5

z <- c(apple=2.5, orange=2.1);
# attributes����mode,length֮������������
attributes(z)




