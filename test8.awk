awk '
BEGIN {
    found=0;
}
{
    if($1 == "access-list" && $2 == "110" && $5 == "192.0.0.0" && $6 == "0.0.0.255" && (($7 == "192.0.0.0" && $8 == "0.0.0.255") )){
        found=1;
    }
     if($1 == "end" && found != 1)
        print "Access-list 110 badly configured: (" FILENAME ")";
} 
END{

}

' $*