%{
	#include <stdio.h>
	char filename[100];
%}


%x L1

%%

^interface[ ].*$	{
    BEGIN L1;
	printf("%s:%s\n", filename, yytext);
}

(.|\n)	; 

<L1>^[ ]ip[ ]address[ ].*$	{
    printf("%s:%s\n", filename, yytext);
}

<L1>(.|\n)	; 

<L1>^!$	{
    BEGIN INITIAL;
}

%%

int main(int argc, char **argv ) {

    strncpy(filename,argv[1],strlen(argv[1]));
    filename[strlen(argv[1])] = '\0';


    yyin = fopen( argv[1], "r" );
    yylex();
    fclose(yyin);
}