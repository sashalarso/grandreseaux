gawk '
BEGIN {
    found = 0;
    line;
    number;
}
{
    if($1 == "snmp-server" && $4 == "RO"  ) 
    {
        found = 1;
        #verification de la présence du 5ème élément
        if (NF<5){
            found=0;
            line=$0;
            number=NR;
        }
        
    }
    else if($1 == "snmp-server" && $4 != "RO")
    {        
        
        line=$0;
        number=NR;          
                
    }
} 
END {
    if(found==0){
        print "snmp-server badly configured on  " FILENAME " line " NR
        print line
    }
}
' $1