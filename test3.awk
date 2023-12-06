gawk '
BEGIN {
    nl;
    foundline = 0;
    block;
    lin = 0;
    lout = 0;
}
{
    if($1 == "!" && foundline)
    {
        if(!lin || !lout)
            print "line badly configured: " block " (line: " nl ")"; 
        foundline = 0;
    }

    if ($1 == "line" && foundline == 1)
    {
        if(!lin || !lout)
            print "line badly configured: " block " (line: " nl ")"; 
        
        foundline = 1;
        nl = NR;
        block = $0
        lin = 0;
        lout = 0;
    }

    if($1 == "line" && foundline == 0)
    {
        foundline = 1;
        nl = NR;
        block = $0
        lin = 0;
        lout = 0;
    }

    if(foundline && ($3 == "in" || $3 == "out"))
    {
        if($3 == "in")
            lin = 1;
        if($3 == "out")
            lout = 1;
    }
} 
END {}
' $1