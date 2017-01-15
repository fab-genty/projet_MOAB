
#PROJET MOAB: Prediction de structure secondaire
#A Realiser par les eleves
#InputFile : mat [fragment0/1 - ss]

#Author : AKE Franz-Arnold - FABIEN GENTY
inputfile="frag_ss.txt" #[]

#"Go!"

db=read.table(inputfile,sep="\t",header=T,colClasses = "character")
#db est considéré comme un data_frame de "charactere", en tenir compte
#opérations numeriques non possible sans conversion
db[,2]=as.factor(as.numeric(db[,2]))

#Realisation Echantillon APP/TEST
echtApp=sample(1:nrow(db),2/3*nrow(db),replace=F)
echtTest=(1:nrow(db))[-echtApp]
dbApp=db[echtApp,]
dbTest=db[echtTest,]

#Realisation du nnet
nnet(db[,1],db[,2],size=4)