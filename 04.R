setwd('D:/0R/Rprograms/20210208')

# part-3 �����ļ�
# ����Ϊ�ı��ļ�-�Ծ�������ݿ�
name <- c('alice','bobo','celin')
age <- c(20,50,35)
country <- c('china','england','america')
df <- data.frame(name, age, country)
write.csv(df, file='D:/0R/Rprograms/20210208/df.txt', sep=',', row.names=FALSE)

# cat����
cat(1,2,3,4,5,6, file='D:/0R/Rprograms/20210208/df.txt',sep=',', append=TRUE)

# R��ʽ�ļ�
save(df, file='D:/0R/Rprograms/20210208/df.Rdata')

# ������
# ��֧���-if..else if..else, switch
# ѭ��-for,while,repeat
