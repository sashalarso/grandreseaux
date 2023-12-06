gawk '
BEGIN {
    nl;
    line="";
    block=0;
    ipfound=0;
    interface="";
    aclfound=0;
}
{
    if($1 == "!" )
    {
        if(block){
            if (ipfound && !aclfound){
                print "interface non valid " interface
            }
        }
        block=0;
    }

    if($1 == "interface")
    {
        block=1;
        ipfound=0;
        interface=$0;
        aclfound=0;
    }
    if (block && $1=="ip" && $2=="address" && $3 ~/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ && $4 ~/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/){
        ipfound=1;
        
    }
    if (block && $1=="ip" && $2=="access-group" ){
        aclfound=1;
        
    }

    
        
} 
END {}
' $1