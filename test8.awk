awk '
BEGIN {
    interface[0]="";
    content[0][0]="";
    i=-1;
    j=0;
}
{
    if($1=="access-list" && $2 =="110" )
} 
END{

}

' $*