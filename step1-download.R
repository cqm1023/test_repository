rm(list = ls())  ## 魔幻操作，一键清空~
options(stringsAsFactors = F)

## step0：修改自己的GSE ID
###############################################
GSEID="GSE44076"##############################
##############################################
# 文件名
f=paste0(GSEID,"_eSet.Rdata")

## step1：下载matrix表达数据
library(GEOquery)
# 这个包需要注意两个配置，一般来说自动化的配置是足够的,如下。
# Setting options('download.file.method.GEOquery'='auto')
# Setting options('GEOquery.inmemory.gpl'=FALSE)
# GSEID如果已经下载好，GSEID位置传入下载的文本就好~
# 如果没有下载，就输入GSEID,getGEO会帮你下载然后导入
# 注意查看下载文件的大小是否和网上显示一样，检查数据
# geoGEO有时候考察网速
if(!file.exists(f)){
  gset <- getGEO(GSEID, destdir=".",
                 AnnotGPL = F,     ## 注释文件
                 getGPL = F)       ## 平台文件
  save(gset,file=f)                ## 保存到本地
}
load(f)
## 载入数据
class(gset)
# 如果这个GEO数据集只有一个GPL平台
# 那么下载到的是一个含有一个元素的list
length(gset)
class(gset[[1]])

## step2：用GEOquery包的函数取出数据
a=gset[[1]]
dat=exprs(a)
pd=pData(a)
dim(dat)
dat[1:4,1:4]


## step3：找到文件具体哪一列是分组信息！！
##需要手动更改
group_list = trimws(stringr::str_split(pd$characteristics_ch1,':',simplify = T)[,2])
table(group_list)

## step4：分组有三组，只要tumor，normal
tdat <- t(dat)[group_list=="Tumor" | group_list=="Normal",]
group_list <- group_list[group_list=="Tumor" | group_list=="Normal"]

exprSet_part_raw=t(tdat)
save(exprSet_part_raw,group_list,file = 'step1-output.Rdata')
