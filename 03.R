setwd('D:/0R/Rprograms/20210208')

# part2-���ļ��е�������
# txt
t <- read.table(file='D:/0R/Rprograms/20210208/test.txt', fileEncoding='utf-8',
           header=TRUE, row.names=1,
           sep=',')#Ĭ�Ϸָ���Ϊ�ո�
# csv
t <- read.csv(file='D:/0R/Rprograms/20210208/test.csv', 
              header=TRUE, row.names=1,
              sep=',')#Ĭ�Ϸָ���Ϊ�ո�
# ��ȡ�̶����ȵ��ļ�read.fwf()
# excel,��Ҫxlsx��
# json,��Ҫrjson����jsonlite��
library(rjson)
library(jsonlite)
t <- fromJSON(txt='D:/0R/Rprograms/20210208/test.json')
tt <- as.data.frame(t)
# pickle
# ���ݿ�
library(RODBC)
# ����֮ǰ,��Ҫ����������Դ
channel <- odbcConnect(dsn='mydsn', uid='root', pwd='root')
data <- odbcQuery(channel, 'select * from ods_test.yuantong')
  
library(RMySQL)
con <- dbConnect(RMySQL::MySQL(), host='127.8.888', port=3309,
                 user='root', password='root')
res <- dbSendQuery(con, 'select * from ods_test.yuantong')
data <- dbFetch(res, n=2) #��ȡǰ��������
# packagename::function�÷�
# һ�ǿ�������Ҫ��ĳ������ʱ��ʱֱ�Ӽ��ذ�����������library��
# ��һ�����Ҫ���Ǿ����ܼ���library�����ĸ������ã�����ڿ���R��ʱӰ��ϴ�


# Ԫ��������ͬʱ��scan�����ǳ���Ч
# ���Ķ�ȡָ��,��ֻ�ܶ�ȡΪvector, list��ʽ
v <- scan(file='D:/0R/Rprograms/20210208/test.txt', what='', sep=',',
     skip=1, fileEncoding='utf8') #��Ϊ����
lst <- scan(file='D:/0R/Rprograms/20210208/test.txt', 
            what=list(����='', �Ա�='',����=0,����=0,���=''), 
            sep=',', skip=1, fileEncoding='utf8') # ��Ϊ�б�
# ���matrix���������Կ��ٶ�ȡ����

# ������ȡ,UTF-8������ôд
ll <- readLines(con='D:/0R/Rprograms/20210208/test.txt',encoding='UTF-8')


# part3-���������ݵ���,֧��csv��ʽ
library(data.table)
test <- fread('test.txt',sep=',',header=TRUE,na.strings='NA')
# �鿴ǰ����
head(test)
