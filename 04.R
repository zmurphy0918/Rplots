setwd('D:/0R/Rprograms/20210208')

# part-3 保存文件
# 保存为文本文件-对矩阵和数据框
name <- c('alice','bobo','celin')
age <- c(20,50,35)
country <- c('china','england','america')
df <- data.frame(name, age, country)
write.csv(df, file='D:/0R/Rprograms/20210208/df.txt', sep=',', row.names=FALSE)

# cat函数
cat(1,2,3,4,5,6, file='D:/0R/Rprograms/20210208/df.txt',sep=',', append=TRUE)

# R格式文件
save(df, file='D:/0R/Rprograms/20210208/df.Rdata')

# 控制流
# 分支语句-if..else if..else, switch
# 循环-for,while,repeat

