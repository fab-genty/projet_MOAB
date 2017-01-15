
#PROJET MOAB: Prediction de structure secondaire
#A Realiser par les eleves
#InputFile : mat [fragment0/1 - ss]

#Author : AKE Franz-Arnold - FABIEN GENTY
inputfile="frag_ss.txt" #[]

#"Go!"

db=read.table(inputfile,sep="\t",header=T,colClasses = "character")
#db est considéré comme un data_frame de "charactere", en tenir compte

#Realisation Echantillon APP/TEST
