grep export inventaire.txt | sort -k3 > inventaire.export.txt
grep import inventaire.txt | sort -k3 > inventaire.import.txt

join -13 -23 inventaire.import.txt inventaire.export.txt > inventaire.join.txt