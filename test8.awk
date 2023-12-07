awk '
BEGIN {
    found=0;
}
{
    if($1 == "access-list" && $2 == "110" && $5 ~/^192/ && $7 ~/^192/ &&($6 ~/^0.0.0.255/ || $6 ~/^255.255.255.0/) &&($8 ~/^0.0.0.255/ || $8 ~/^255.255.255.0/) ){
        found=1;
    }
     if($1 == "end" && found != 1){
        print "Access-list 110 badly configured: (" FILENAME ")";
        
     }
     if($1 == "end" ){
        found=0;
        
     }
   
} 
END{

}

' $*