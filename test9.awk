gawk '
BEGIN {
    incryptomap=0;
    inpeer=0;
    intransform=0;
    inmatch=0;
    ininterface=0;
    interface="";
    file="";
    cryptodefined=0;
    cryptomap[0][0]="";
    acl[0]="";
    i=-1;
    j=0;
}
{
    file=FILENAME;
    if($1=="interface" && $2 ~/^(.)*FastEthernet(.)*$/){
        ininterface=1;
        interface=$2;
        
    }
    if ($1=="crypto" && $2=="map" && ininterface){
        cryptodefined=1;
    }
    if ($1=="crypto" && $2=="map"){
        incryptomap=1;
        cryptomap[i][j]=$0;
        j=j+1
    }
    if(incryptomap && $1=="set" && $2=="peer"){
        inpeer=1;
        cryptomap[i][j]=$0;
        j=j+1;
    }
    if(incryptomap && $1=="set" && $2=="transform-set" ){
        intransform=1;
        cryptomap[i][j]=$0;
        j=j+1;
    }
    if(incryptomap && $1=="match" && $2=="address" ){
        inmatch=1;
        cryptomap[i][j]=$0;
        acl[$3]=$0;
        j=j+1
    }
    if ($1=="!"){
        if(incryptomap && (!inpeer || !intransform || !inmatch) && !ininterface ){
        print "crypto map in "FILENAME " badly configured : " cryptomap[i][0];
    }
        if(ininterface && !cryptodefined){
            print "crypto map not applied on interface " interface " in file " file;
        }
        incryptomap=0;
        inpeer=0;
        intransform=0;
        inmatch=0;
        ininterface=0;
        cryptodefined=0;
        i=i+1;
        j=0;
    }
    
} 
END {
    
}
' $*