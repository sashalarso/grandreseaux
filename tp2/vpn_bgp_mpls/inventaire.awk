gawk '
BEGIN {
    pe="";
    vrf="";
}
{
    if($1 == "hostname")
        pe = $2;

    if($1 == "ip" && $2 == "vrf")
        vrf = $3;

    if($1 == "route-target")
        print pe "-" vrf " " $2 " " $3
} 
END {
}
' $*