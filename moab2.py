
#genere un fichier [residu - struct second]

filin=open("dbase.txt")
filout=open("dbaseR2.txt","w")

for ligne in filin:
	if(ligne[0]==">"):
		continue

	elif(ligne[0]=="X"):
		continue

	elif(ligne[4]=="0" or ligne[4]=="1" or ligne[4]=="2"):
		filout.write(ligne[0])
		filout.write("\t")
		filout.write(ligne[4])
		filout.write("\n")
		proteine=""

filin.close()