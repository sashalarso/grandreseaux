gawk '
BEGIN {
    block;
}
{
    if ($1 == "crypto" && $2 == "map")
        block = $3;
    else if ($1 == "interface")
        block = $2;
    else if ($1 == "set" && $2 == "peer" || $1 == "ip" && $2 == "address")
        print $3, block;
} 
END {
}
' $*