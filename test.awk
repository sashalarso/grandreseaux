gawk '
BEGIN {
    i = -1;
    j = 0;
    interfaces[0] = "";
    interfaceContents[0][0] = "";
}
{
    if($1 == "!")
    {
        j = 0;
        i++;
    }

    if($1 == "interface")
    {
        interfaces[i] = $0
        interface[i][nl] = FNR;
    }
    
    if($1 == "switchport")
        interfaceContents[i][j++] = $0

} 
END {
    trunkEncapsulation = 0;
    trunkMode = 0;
    trunkAllowedVlan = 0;
    trunkNativeVlan = 0;
    portSecurity = 0;
    modeAccess = 0;

    for(i = 0; i < length(interfaces); ++i)
    {
        for(j = 0; j < length(interfaceContents[i]); ++j)
        {
            # mode trunk
            if(interfaceContents[i][j] ~/^(.)*mode trunk(.)*$/)
                trunkMode = 1;

            # encapsulation
            if(interfaceContents[i][j] ~/^(.)*encapsulation(.)*$/)
                trunkEncapsulation = 1;
            
            # native vlan
            if(interfaceContents[i][j] ~/^(.)*native vlan(.)*$/)
                trunkNativeVlan = 1;

            # allowed vlan
            if(interfaceContents[i][j] ~/^(.)*allowed vlan(.)*$/)
                trunkAllowedVlan = 1;
            
            # port security
            if(interfaceContents[i][j] ~/^(.)*port-security(.)*$/)
                portSecurity = 1;
            
            # mode access
            if(interfaceContents[i][j] ~/^(.)*mode access(.)*$/)
                modeAccess = 1;
        }

        if(trunkMode == 1)
        {
            if(!(trunkEncapsulation && trunkAllowedVlan && trunkNativeVlan && !portSecurity && !modeAccess))
                print "[X] Trunk mode is not properly configured: " interfaces[i] " (" FILENAME " line: " interface[i][nl] ")";
        }

        trunkMode = 0;
        trunkNativeVlan = 0;
        trunkAllowedVlan = 0;
        trunkEncapsulation = 0;
        portSecurity = 0;
        modeAccess = 0;
    }
}
' $1 $2 $3