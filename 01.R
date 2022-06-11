# 基本操作，打印hello world
print('hello world')

# R的设置文件
# 当前R版本
sessionInfo()
# R的设置文件
# 当前工作路径在哪儿
getwd()
# 如何更改工作路径
setwd(dir="D:/0R/Rprograms/20210208")
# 清除当前空间对象-展示当前空间中对象
rm()
# 展示可用选项
help(options)
# 如何更改可用选项
options(digits=4,encoding='utf8')

# 2-当前目录下所有文件
dir()
# 指定目录下所有文件
list.files("D:/0R")

# 4-
.libPaths() #下载好的包安装路径
# 4.1-网络安装
install.packages('heatmaply') #其他参数可以指定安装到哪个地址
# 4.2-本地安装
download.file(url='',destfile='D:/0R/R-4.0.2/mypackages/')#安装到地址
install.packages('D:/0R/R-4.0.2/mypackages/')#本地安装
update.packages("ggplot2") #更新包
# 引入的所有包
(.packages())
# 所有可用的包
(.packages(all.available = TRUE))


# 5-全局设置
options(digits=2)
options(CRAN='')
install.packages('')
options(warn=-1) #显示警告信息设置

# 6-帮助文件
help(options)
?options
help(package="base")

# 7-RMarkdown依赖包
install.packages('rmarkdown')
install.packages('tinytex') #支持PDF
install.packages('knitr') #支持PDF HTML WORD
install.packages('rticles')#支持中文PDF

# 8-RNotebook使用呢？
install.packages('rnotebook')

# 9-显示历史记录
history()

# 10-查询函数来自哪个包
# 使用sos中‘???’+plot_grid来查询

# R大数据集下的使用
# R针对大数据集使用biglm进行线性拟合，是对lm的拓展
# 对大数据平台也有订制的RHadoop,RHive,RHipe工具进行使用

# 11-清除变量
rm()
rm(list=ls())
# 清屏
# CTRL+L

# 12-判断数据类型
class(df$age)

# 13-
data() #查看R自带的数据集
data(AirPassengers)

# 14-安装必备包
pkgs <- c(
  "assertthat", 
  "backports", "base64enc", "BH", "bindr", "bindrcpp", "bookdown", "broom", 
  "callr", "car", "cellranger", "cli", "clipr", "colorspace", 
  "cowplot", "crayon", "curl", 
  "DBI", "dbplyr", "dichromat", "digest", "dplyr", 
  "evaluate", 
  "forcats", 
  "ggplot2", "ggrepel", "glue", "gtable", 
  "haven", "highr", "hms", "htmltools", "httr", 
  "jsonlite", 
  "knitr", 
  "labeling", "lazyeval", "lubridate", 
  "magrittr", "markdown", "microbenchmark", "mime", "mnormt", "modelr", "munsell", 
  "NHANES",
  "openssl", 
  "pillar", "pkgconfig", "plogr", "plyr", "psych", "purrr", 
  "R6", "RColorBrewer", "Rcpp", "readr", "readxl", 
  "rematch", "reprex", "reshape2", "rlang", "rmarkdown", 
  "rprojroot", "rstudioapi", "rvest", 
  "scales", "selectr", "socviz", "stringi", "stringr", 
  "tibble", "tidyr", "tidyselect", "tidyverse", 
  "utf8", 
  "viridisLite", 
  "whisker", 
  "xml2", "xtable",
  "yaml"
)
install.packages(unique(pkgs))
# 14.2-从GitHub安装扩展包
if (!require(devtools)) install.packages(devtools)
devtools::install_github('kjhealy/socviz')
# 14.3-更新本地所有逇CRAN安装包
options(repos=CRAN('http://mirror.tuna.tsinghua.edu.cn/CRAN/'))
update.packages(checkBuilt=TRUE, ask=FALSE)
# R软件每次更新后需要把全部的依赖包再次下载，可以用以下方法批量安装
# 在更新前，在旧版本的R中运行
packages <- .packages(TRUE)
dump("packages", file="packages-20210629.R")
# 更新R软件后，运行如下程序
options(repos = c(CRAN="http://mirror.tuna.tsinghua.edu.cn/CRAN/"))
source("packages-20210629.R")
install.packages(packages)

# 15-扩展私有的安装包目录
# 最好用renv扩展包实现每个项目保存私有的安装包目录









