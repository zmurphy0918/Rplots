setwd('D:/0R/Rprograms/20210208')

# part2-从文件中导入数据
# txt
t <- read.table(file='D:/0R/Rprograms/20210208/test.txt', fileEncoding='utf-8',
           header=TRUE, row.names=1,
           sep=',')#默认分隔符为空格
# csv
t <- read.csv(file='D:/0R/Rprograms/20210208/test.csv', 
              header=TRUE, row.names=1,
              sep=',')#默认分隔符为空格
# 读取固定宽度的文件read.fwf()
# excel,需要xlsx包
# json,需要rjson包，jsonlite包
library(rjson)
library(jsonlite)
t <- fromJSON(txt='D:/0R/Rprograms/20210208/test.json')
tt <- as.data.frame(t)
# pickle
# 数据库
library(RODBC)
# 连接之前,需要先配置数据源
channel <- odbcConnect(dsn='mydsn', uid='root', pwd='root')
data <- odbcQuery(channel, 'select * from ods_test.yuantong')
  
library(RMySQL)
con <- dbConnect(RMySQL::MySQL(), host='127.8.888', port=3309,
                 user='root', password='root')
res <- dbSendQuery(con, 'select * from ods_test.yuantong')
data <- dbFetch(res, n=2) #获取前两条数据
# packagename::function用法
# 一是可以在需要用某个函数时临时直接加载包，不用事先library；
# 另一点更重要的是尽可能减少library带来的附带作用，这点在开发R包时影响较大


# 元素类型相同时，scan函数非常高效
# 灵活的读取指令,但只能读取为vector, list形式
v <- scan(file='D:/0R/Rprograms/20210208/test.txt', what='', sep=',',
     skip=1, fileEncoding='utf8') #读为向量
lst <- scan(file='D:/0R/Rprograms/20210208/test.txt', 
            what=list(姓名='', 性别='',年龄=0,工龄=0,类别=''), 
            sep=',', skip=1, fileEncoding='utf8') # 读为列表
# 结合matrix函数，可以快速读取矩阵

# 其他读取,UTF-8必须这么写
ll <- readLines(con='D:/0R/Rprograms/20210208/test.txt',encoding='UTF-8')


# part3-超大量数据导入,支持csv格式
library(data.table)
test <- fread('test.txt',sep=',',header=TRUE,na.strings='NA')
# 查看前几行
head(test)

