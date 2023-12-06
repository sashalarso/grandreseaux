awk '
BEGIN {
    interface[0]="";
    content[0][0]="";
    i=-1;
    j=0;
}
{
    if($1=="!"){
        i=i+1;
        j=0;
    }

    if($1=="interface"){
        interface[i]=$2;
        
    }
    if($1=="switchport"){
        content[i][j]=$0;
        j=j+1;
    }
} 
END {
    trunkEncapsulation = 0;
    trunkMode = 0;
    trunkAllowedVlan = 0;
    trunkNativeVlan = 0;
    portSecurity = 0;
    modeAccess = 0;
    for(i = 0; i < length(interface); ++i){
        for(j = 0; j < length(content[i]); ++j){
           
            if(content[i][j] ~/^(.)*mode trunk(.)*$/)
                trunkMode = 1;

            
            if(content[i][j] ~/^(.)*encapsulation(.)*$/)
                trunkEncapsulation = 1;
            
            
            if(content[i][j] ~/^(.)*native vlan(.)*$/)
                trunkNativeVlan = 1;

            
            if(content[i][j] ~/^(.)*allowed vlan(.)*$/)
                trunkAllowedVlan = 1;
            
            
            if(content[i][j] ~/^(.)*port-security(.)*$/)
                portSecurity = 1;
            
            
            if(content[i][j] ~/^(.)*mode access(.)*$/)
                modeAccess = 1;
        }
        # print trunkMode "  " trunkEncapsulation " " trunkNativeVlan " " trunkAllowedVlan " " portSecurity " " modeAccess " "
    if(trunkMode == 1)
        {
            if(!(trunkEncapsulation && trunkAllowedVlan && trunkNativeVlan && !portSecurity && !modeAccess))
                print "Trunk mode badly configured: " interface[i] " " FILENAME ;
        }

        trunkMode = 0;
        trunkNativeVlan = 0;
        trunkAllowedVlan = 0;
        trunkEncapsulation = 0;
        portSecurity = 0;
        modeAccess = 0;

    }
    #print length(interface)
}
' $*