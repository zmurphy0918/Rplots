# ������������ӡhello world
print('hello world')

# R�������ļ�
# ��ǰR�汾
sessionInfo()
# R�������ļ�
# ��ǰ����·�����Ķ�
getwd()
# ��θ��Ĺ���·��
setwd(dir="D:/0R/Rprograms/20210208")
# �����ǰ�ռ����-չʾ��ǰ�ռ��ж���
rm()
# չʾ����ѡ��
help(options)
# ��θ��Ŀ���ѡ��
options(digits=4,encoding='utf8')

# 2-��ǰĿ¼�������ļ�
dir()
# ָ��Ŀ¼�������ļ�
list.files("D:/0R")

# 4-
.libPaths() #���غõİ���װ·��
# 4.1-���簲װ
install.packages('heatmaply') #������������ָ����װ���ĸ���ַ
# 4.2-���ذ�װ
download.file(url='',destfile='D:/0R/R-4.0.2/mypackages/')#��װ����ַ
install.packages('D:/0R/R-4.0.2/mypackages/')#���ذ�װ
update.packages("ggplot2") #���°�
# ��������а�
(.packages())
# ���п��õİ�
(.packages(all.available = TRUE))


# 5-ȫ������
options(digits=2)
options(CRAN='')
install.packages('')
options(warn=-1) #��ʾ������Ϣ����

# 6-�����ļ�
help(options)
?options
help(package="base")

# 7-RMarkdown������
install.packages('rmarkdown')
install.packages('tinytex') #֧��PDF
install.packages('knitr') #֧��PDF HTML WORD
install.packages('rticles')#֧������PDF

# 8-RNotebookʹ���أ�
install.packages('rnotebook')

# 9-��ʾ��ʷ��¼
history()

# 10-��ѯ���������ĸ���
# ʹ��sos�С�???��+plot_grid����ѯ

# R�����ݼ��µ�ʹ��
# R��Դ����ݼ�ʹ��biglm����������ϣ��Ƕ�lm����չ
# �Դ�����ƽ̨Ҳ�ж��Ƶ�RHadoop,RHive,RHipe���߽���ʹ��

# 11-�������
rm()
rm(list=ls())
# ����
# CTRL+L

# 12-�ж���������
class(df$age)

# 13-
data() #�鿴R�Դ������ݼ�
data(AirPassengers)

# 14-��װ�ر���
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
# 14.2-��GitHub��װ��չ��
if (!require(devtools)) install.packages(devtools)
devtools::install_github('kjhealy/socviz')
# 14.3-���±�������ޚCRAN��װ��
options(repos=CRAN('http://mirror.tuna.tsinghua.edu.cn/CRAN/'))
update.packages(checkBuilt=TRUE, ask=FALSE)
# R����ÿ�θ��º���Ҫ��ȫ�����������ٴ����أ����������·���������װ
# �ڸ���ǰ���ھɰ汾��R������
packages <- .packages(TRUE)
dump("packages", file="packages-20210629.R")
# ����R�������������³���
options(repos = c(CRAN="http://mirror.tuna.tsinghua.edu.cn/CRAN/"))
source("packages-20210629.R")
install.packages(packages)

# 15-��չ˽�еİ�װ��Ŀ¼
# �����renv��չ��ʵ��ÿ����Ŀ����˽�еİ�װ��Ŀ¼








