# AdjOL
outlier adjustment for RNAseq data


Perform outlier adjustment on RNAseq data

Example to run the code (from command line):

Rscript AdjOL.R SCexample.csv 0.05 0.95 out.txt

The inputs for the code are:

-  [FileNameIn] can take .csv, .txt or .tab. Rows are genes and columns are samples.

-  [lower/upper quantile] thresholds for outlier adjustment. For each gene/isoform, values <= qt1 th quantile (>= qt2 th quantile) will be pushed to qt1 th quantile (qt2 th quantile) prior to the scaling.

-  [OutputName] will output a tab delimited file
