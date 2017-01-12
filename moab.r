
#Projet MOAB : 
#Author : AKE FRANZ-ARNOLD

#inputfile ("entrez l'input file")
nameinput="dbaseR.txt"

#Ouverture fichier input
db=read.table(nameinput,sep="\t")
db$V1=as.character(db$V1)
db$V2=as.character.factor(db$V2)

#dimension_fichier
dim(db)

#index des positions "PROT"
index=which(c(db[,1]=="PROT"))
index[length(index)+1]=length(db[,1])+1

#Matrice de Proteine
#initialisation
debut=index[1]+1
fin=index[2]-1
interval=debut:fin
M1=data.frame(db[interval,])
colnames(M1)=c("AAM",toString(db[index[1],2]))
G1=list(M1)

#Elargissement
for(i in 2:(length(index)-1)){
  debut=index[i]+1
  fin=index[i+1]-1
  interval=debut:fin
  M2=data.frame(db[interval,])
  colnames(M2)=c("AAM",toString(db[index[i],2]))
  G1=unlist(list(G1,list(M2)),recursive = F)
}

#Parfait!
#liste de Matrice Proteique
# G1[M1,M2,M3,....]

#Travail avec liste de matrice
#Realisation App/Test
selectApp=c(sample(1:length(G1),2/3*length(G1),replace = F))
EchtApp=G1[selectApp]
EchtTest=G1[-selectApp]


#Fragmentation en 9/9 (Test sur la Matrice 1)
#initialisation
L1=as.data.frame(G1[1])
debut=1
fin=9
interval=debut:fin
v1=c(L1[interval,1])
fragments=list(v1)
resSS=c(v1[5])


#Elargissement
for (i in 10:dim(L1)[1]){
  debut=i-8
  fin=i
  interval=debut:fin
  v2=c(L1[interval,1])
  fragments=unlist(list(fragments,list(v2)),recursive = F)
  resSS=append(resSS,v2[5])
}


#Attribution
vAA=c("A","C","D","E","F","G","H","I","K","L","M","N","P","Q","R","S","T","W","Y","Z")
#initialisation
frag1=unlist(fragments[1])
residu=frag1[1]
vvide=c(rep(0,20))
for(i in 1:length(vAA)){
  if(residu==vAA[i]){
    vvide[i]=1
  }
}
vvide_LISTE=list(vvide)

#elargissement
for(j in 2:length(frag1)){ # itére sur les res des fragments
  residu=frag1[j]
  vvide2=c(rep(0,20))
  for(k in 1:length(vAA)){ #itère et compare dans les res vAA
    if(residu==vAA[k]){
      vvide2[k]=1
    }
  }
  vvide_LISTE=unlist(list(vvide_LISTE,list(vvide2)))
}















