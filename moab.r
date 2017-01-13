
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
G1=list()
for(i in 1:(length(index)-1)){
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

#Fragmentation 9/9 pour toutes les proteines du jeu de donnée

vAA=c("A","C","D","E","F","G","H","I","K","L","M","N","P","Q","R","S","T","W","Y","Z")

struct_second=list()
res_coded=list()

#Etape1 : Recuperer chaque proteine dans la liste de matrice G1
for(i in 1:length(G1)){
  P=as.data.frame(G1[i])
  
#Etape2: Recuperer tous les fragments(residus/ss) pour la proteine courante
  fragments=list()
  ss_fragL=list()
  for(i in 1:(length(P[,1])-9+1)){
    debut=i
    fin=i+8
    residus_frag=P[debut:fin,1]
    ss_frag=c(P[i+4,2])
    fragments=unlist(list(fragments,list(residus_frag)), recursive=F)
    ss_fragL=unlist(list(ss_fragL,list(ss_frag)), recursive=F)
  }
  ss_fragL=unlist(ss_fragL)         #vecteurs des structures secondaires des fragments/Proteine
  
#Etape3: Associer chaque residus du fragment un vecteur 0/1
  #Liste des stockage fragments codés
  vecfragL_Tot=list()
  
  #Parcours de la liste des fragments/Prot
  for(k in 1:length(fragments)){
    seq_frag=unlist(fragments[k])
    vec_fragL=list()
    
    for(l in 1:length(seq_frag)){
      residu=seq_frag[l]
      
      vec_frag=c(rep(0,20))
      for(n in 1:length(vAA)){
        if(residu==vAA[n]){
          vec_frag[n]=1       #liste des vecteurs/residu
          break
        }
      }
      vec_fragL=unlist(list(vec_fragL,list(vec_frag)), recursive = F) #liste des vecteurs/fragments
      vec_fragL=unlist(vec_fragL)#si on take l'information du fragment! hyp : OUI sinon !unlist
    }
    vecfragL_Tot=unlist(list(vecfragL_Tot,list(vec_fragL)), recursive = F) #liste des vecteurs/Proteine
  }

#Etape 4: On stocke les données généres pour chaque proteine dans une liste (1 itération)
  #données générées
  
  #1/ Vecteur des structures secondaires associés aux fragments (dans l'ordre)
  #de la prot ~= nbre de fragments / R[ss1,ss2,ss3,...] 
  ss_fragL
  
  #2/ Liste des vecteurs résidus codés de la protéine (organisés en fragments) 
  #R[frag1,frag2,...]
  vecfragL_Tot
  
  #Rajout
  struct_second=unlist(list(struct_second,list(ss_fragL)), recursive=F)
  res_coded=unlist(list(res_coded,list(vecfragL_Tot)), recursive=F)
  
}

    













