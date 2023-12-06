awk '
BEGIN {
    
}
{
    if($1=="ip" && $2=="access-group"){
        acl_ref[$3]=FNR
    }
    if($1=="access-class"){
        acl_ref[$2]=FNR
    }
    if($1=="ip" && $3 == "extended"){
        acl_def[$4]=FNR
    }
    if($1=="access-list"){
        acl_def[$2]=FNR
    }
    if($1=="snmp-server" && $2=="community"){
        acl_ref[$3]=FNR
    }
} 
END {
    for (id in acl_ref){
        if(!(id in acl_def)){
            print id,"ACL applied not defined, line : " acl_ref[id] ;
        }
        
    }
    for (id in acl_def){
        if(!(id in acl_ref)){
            print id,"ACL defined not applied, line : " acl_def[id];
        }
        
    }
    
}
' $1