
# 镜像设置


# 装包
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
if (!requireNamespace("BiocManager", quietly = TRUE)) BiocManager::install("GEOquery")
if (!requireNamespace("hgu219.db", quietly = TRUE)) BiocManager::install("hgu219.db")


# 装完最后重新运行一遍，check一下