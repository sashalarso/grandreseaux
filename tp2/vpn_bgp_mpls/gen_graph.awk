gawk '
BEGIN {
    print "from sage.all import *";
    print "import graphviz\n";
    print "f = graphviz.Digraph(\"G\", filename=\"vpn-bgp-mpls.gv\")"
    print "g=DiGraph()";
    print "f.attr(\"node\", shape=\"circle\")";
}
{
    if($2 != $4)
    {
        print "g.add_edges([(\""$2"\", \"" $4"\")])";
        print "f.edge(\""$2"\", \"" $4"\", label=\""$1"\")";
    }
    else
    {
        print "g.add_vertex(\""$2"\")";
        print "f.node(\""$2"\")";
    }
}
END {
    print "g.show()";
    print "f.view()";
    print "g.connected_components()";
    
}
' $1