# Input:
# [FileNameIn] [lower quantile] [upper quantile] 
# [OutputName] 

library(gplots)
options=commandArgs(trailingOnly = TRUE)
print(options)
File=options[1] # file name
Low=as.numeric(options[2]) #lower quantile
High=as.numeric(options[3]) #upper quantile
Out=options[4] # output


PushOL<- function (Data, qt1 = 0.05, qt2 = 0.95, PushHigh = T, PushLow = T) 
{
	  Q5 = apply(Data, 1, function(i) quantile(i, qt1))
    Q95 = apply(Data, 1, function(i) quantile(i, qt2))
		DataSc2 = Data
		    for (i in 1:nrow(Data)) {
					        if (PushLow) 
									            DataSc2[i, which(DataSc2[i, ] < Q5[i])] = Q5[i]
				        if (PushHigh) 
									            DataSc2[i, which(DataSc2[i, ] > Q95[i])] = Q95[i]
								    }
				    DataSc2
}



# csv or txt
tmp=strsplit(File, split="\\.")[[1]]
FileType=tmp[length(tmp)]

if(FileType=="csv"){
	cat("\n Read in csv file \n")
	prefix=strsplit(File,split="\\.csv")[[1]][1]
	In=read.csv(File,stringsAsFactors=F,row.names=1)
}
if(FileType!="csv"){
	cat("\n Read in tab delimited file \n")
	prefix=strsplit(File,split=paste0("\\.",FileType))[[1]][1]
	In=read.table(File,stringsAsFactors=F, sep="\t",header=T,row.names=1)
}



Mat=data.matrix(In)


cat("\n ==== Performing outlier adjustment ==== \n")
cat(paste("quantiles", Low, High))
cat("\n")
Mat=PushOL(Mat,qt1=Low, qt2=High)

tmp=cbind(rownames(Mat),Mat)
colnames(tmp)[1]=" "
write.table(tmp,Out,sep="\t",row.names=F,quote=F)

