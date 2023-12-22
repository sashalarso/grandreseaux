%{
#include <stdio.h>
char filename[200];
char interface[100];
short ip_valide;
short access_group;
%}

%x INTERFACE

%%

^interface[ ].*$    { 
    snprintf(interface,100,"%s",yytext);
    ip_valide =0;
    access_group = 0;
    BEGIN INTERFACE;
    }
(.|\n)           ;

<INTERFACE>^[ ]ip[ ]address[ ]((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.)){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)[ ].*$ { 
    ip_valide=1;
    }
<INTERFACE>^[ ]ip[ ]access-group[ ].*$   { 
    access_group =1;
    }
<INTERFACE>(.|\n)   ;
<INTERFACE>^!$  {
    if(ip_valide && access_group ==0){
        printf("%s : %s\n",filename, interface);
    }
    BEGIN INITIAL;
    }


%%

int main(int argc, char **argv ) {
    int i;

    for(i=1;i<argc;i++) {

     strncpy(filename,argv[i],strlen(argv[i]));

    filename[strlen(argv[i])] = '\0';

    yyin = fopen( argv[i], "r" );

    if (yyin != NULL) {
           yylex();
         fclose(yyin);
     } else {
           perror("FILE OPEN ERROR");
           exit(1);
     }
   }
}