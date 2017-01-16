
#Projet : MOAB 
#Prediction de la structure secondaire et Analyse

#Author : AKE Franz-Arnold 
#Python

#Recuperation et Ouverture du fichier
filin=open("dbase.txt","r")

#Liste de dico des acides amines1 // occurences
#Helix alfa
Ldico_aa0={}
#Boucle
Ldico_aa1={}
#Chaine Beta
Ldico_aa2={}

#chargement de la liste de dictionnaire n(AAi)p
for ligne in filin:
	if(ligne[0]!=">"):
		if(ligne[0]=="X"):
			continue
		if(Ldico_aa0.has_key(ligne[0]) or Ldico_aa1.has_key(ligne[0]) or Ldico_aa2.has_key(ligne[1])):
			if(int(ligne[4])==0):
				Ldico_aa0[ligne[0]]+=1
			elif(int(ligne[4])==1):
				Ldico_aa1[ligne[0]]+=1
			elif(int(ligne[4])==2):
				Ldico_aa2[ligne[0]]+=1
		else:
			Ldico_aa0[ligne[0]]=0
			Ldico_aa1[ligne[0]]=0
			Ldico_aa2[ligne[0]]=0
filin.close()


#dico des frequences d'acides amines f(AAi)p
#freq helix alfa
dicofreq_helix={}
for aa in Ldico_aa0.keys():
	dicofreq_helix[aa]=round(float(Ldico_aa0[aa])/sum(Ldico_aa0.values()),3)

#freq Coil
dicofreq_coil={}
for aa in Ldico_aa1.keys():
	dicofreq_coil[aa]=round(float(Ldico_aa1[aa])/sum(Ldico_aa1.values()),3)

#freq B-strand
dicofreq_strand={}
for aa in Ldico_aa2.keys():
	dicofreq_strand[aa]=round(float(Ldico_aa2[aa])/sum(Ldico_aa2.values()),3)


#print dicofreq_helix

#Calcul des frequences relatives
#dico des freq_aa dans la dbase f(AAi)db
dicofreq_dbase={}
for aa in Ldico_aa0.keys():
	dicofreq_dbase[aa]=round(float((Ldico_aa0[aa]+Ldico_aa1[aa]+Ldico_aa2[aa]))/(sum(Ldico_aa0.values())+sum(Ldico_aa1.values())+sum(Ldico_aa2.values())),3)

#dico des freq_aa associe a chaque structure secondaire f(AAi)p
dicofreq_helix
dicofreq_coil
dicofreq_strand

#D'ou

dicofreq_relatH={}
for aa in dicofreq_helix.keys():
	dicofreq_relatH[aa]=dicofreq_helix[aa]/dicofreq_dbase[aa]

dicofreq_relatC={}
for aa in dicofreq_helix.keys():
	dicofreq_relatC[aa]=dicofreq_coil[aa]/dicofreq_dbase[aa]

dicofreq_relatB={}
for aa in dicofreq_helix.keys():
	dicofreq_relatB[aa]=dicofreq_strand[aa]/dicofreq_dbase[aa]

#print dicofreq_relatH


# Generer fichier a utiliser avec R
#formatage fichier
#Acide amine - Struct Second
#A - 0 or 1

filin=open("dbase.txt","r")
filout=open("dbaseR.txt","w")
for ligne in filin:
	if(ligne[0]==">"):
		filout.write("PROT")
		filout.write("\t")
		filout.write(ligne[1:len(ligne)-1])
		filout.write("\n")

	elif(ligne[0]=="X"):
		continue

	elif(ligne[4]=="0" or ligne[4]=="1" or ligne[4]=="2"):
		filout.write(ligne[0])
		filout.write("\t")
		filout.write(ligne[4])
		filout.write("\n")
		proteine=""

filin.close()

