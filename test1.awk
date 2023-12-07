gawk '
BEGIN {
    found = 0;    
}
{
    if($1 == "service" && $2 == "password-encryption") 
    {
        found = 1;
        
    }
} 
END {
    if(found==0)
        print "service password-encryption not configured in " FILENAME
}
' $1