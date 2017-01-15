
#PROJET MOAB: Prediction de structure secondaire
#A Realiser par les eleves
#InputFile : mat [fragment0/1 - ss]

#Author : AKE Franz-Arnold - FABIEN GENTY
inputfile="frag_ss.txt" #[]

#"Go!"

db=read.table(inputfile,sep="\t",header=T,colClasses = "character")
#db est considéré comme un data_frame de "charactere", en tenir compte
#opérations numeriques non possible sans conversion


summary(db)
#Realisation Echantillon APP/TEST
echtApp=sample(1:nrow(db),2/3*nrow(db),replace=F)
echtTest=(1:nrow(db))[-echtApp]
dbApp=db[echtApp,]
dbTest=db[echtTest,]

#Realisation du nnet



v=as.vector(as.numeric(db[1,]$V1))
t=as.vector(as.numeric(db[2,]$V2))

library(nnet)
nnet(v,t,size=4)
