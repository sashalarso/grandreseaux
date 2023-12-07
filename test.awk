awk '
{
    # Votre logique de traitement ici
    print "Fichier courant:", FILENAME
}
' $1 $2 $3
