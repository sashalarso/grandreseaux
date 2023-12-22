gawk '
BEGIN {
    router_ip[0]="";
}
{
     if ($1 == "ip" && $2 == "address")
        router_ip[i] = $3;
    else if ($1 == "router" && $2 == "bgp")
        router_nb[i] = $3;
} 
END {
}
' $*