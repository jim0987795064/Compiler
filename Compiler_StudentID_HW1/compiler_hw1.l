/* Definition section */
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define YY_NO_UNPUT
    #define YY_NO_INPUT

    int line_num = 0;
    int comment_num = 0;
%}

/* Define regular expression label */
letter [a-zA-Z_]
digit [0-9]
id {letter}+({letter}|{digit})*
inumber {digit}+
fnumber ({digit}*\.{digit}+)
string \"([^\"]|\\.)*\"
CPPcomment "//"([^\n])*
Ccomment ("/*"([^*]|\n|"*"+[^/])*"*"+"/")



/* Rules section */
%%

"+"         { printf("%-8s \t %s\n", yytext, "ADD");}
"-"         { printf("%-8s \t %s\n", yytext, "SUB");}
"="        { printf("%-8s \t %s\n", yytext, "ASSIGN");}
"+="        { printf("%-8s \t %s\n", yytext, "ADD_ASSIGN");}
"-="        { printf("%-8s \t %s\n", yytext, "SUB_ASSIGN");}
"*="        { printf("%-8s \t %s\n", yytext, "MUL_ASSIGN");}
"/="        { printf("%-8s \t %s\n", yytext, "QUO_ASSIGN");}
"%="        { printf("%-8s \t %s\n", yytext, "REM_ASSIGN");}
";"        { printf("%-8s \t %s\n", yytext, "SEMICOLON");}
"*"        { printf("%-8s \t %s\n", yytext, "MUL");}
"/"        { printf("%-8s \t %s\n", yytext, "QUO");}
"%"        { printf("%-8s \t %s\n", yytext, "REM");}
"++"        { printf("%-8s \t %s\n", yytext, "INC");}
"--"        { printf("%-8s \t %s\n", yytext, "DEC");}
"&&"        { printf("%-8s \t %s\n", yytext, "AND");}
"||"        { printf("%-8s \t %s\n", yytext, "OR");}
"!"        { printf("%-8s \t %s\n", yytext, "NOT");}
","        { printf("%-8s \t %s\n", yytext, "COMMA");}
"<"        { printf("%-8s \t %s\n", yytext, "LSS");}
">"        { printf("%-8s \t %s\n", yytext, "GTR");}
"<="        { printf("%-8s \t %s\n", yytext, "LEQ");}
">="        { printf("%-8s \t %s\n", yytext, "GEQ");}
"=="        { printf("%-8s \t %s\n", yytext, "EQL");}
"!="        { printf("%-8s \t %s\n", yytext, "NEQ");}
{inumber}        { printf("%-8s \t %s\n", yytext, "INT_LIT");}
"int"        { printf("%-8s \t %s\n", yytext, "INT");}
"float"        { printf("%-8s \t %s\n", yytext, "FLOAT");}
{fnumber}        { printf("%-8s \t %s\n", yytext, "FLOAT_LIT");}
"bool"        { printf("%-8s \t %s\n", yytext, "BOOL");}
"true"        { printf("%-8s \t %s\n", yytext, "TRUE");}
"false"        { printf("%-8s \t %s\n", yytext, "FALSE");}
"break"        { printf("%-8s \t %s\n", yytext, "BREAK");}
"string"        { printf("%-8s \t %s\n", yytext, "STRING");}
"print"        { printf("%-8s \t %s\n", yytext, "PRINT");}
"if"        { printf("%-8s \t %s\n", yytext, "IF");}
"else"        { printf("%-8s \t %s\n", yytext, "ELSE");}
"for"        { printf("%-8s \t %s\n", yytext, "FOR");}
"while"        { printf("%-8s \t %s\n", yytext, "WHILE");}
"return"        { printf("%-8s \t %s\n", yytext, "RETURN");}
"void"        { printf("%-8s \t %s\n", yytext, "VOID");}
"continue"        { printf("%-8s \t %s\n", yytext, "CONTINUE");}
"("        { printf("%-8s \t %s\n", yytext, "LPAREN");}
")"        { printf("%-8s \t %s\n", yytext, "RPAREN");}
"{"        { printf("%-8s \t %s\n", yytext, "LBRACE");}
"}"        { printf("%-8s \t %s\n", yytext, "RBRACE");}
"\n"        {line_num++; }
"\""        { printf("%-8s \t %s\n", yytext, "QUOTA");}
{string}    { int length = strlen(yytext);
                if(length >= 2){
                    char *string_content = yytext + 1;
                    string_content[length - 2] = '\0';

                    printf("%-8s \t %s\n%-8s \t %s\n%-8s \t %s\n"
                        , "\"", "QUOTA"
                        , string_content, "STRING_LIT"
                        , "\"", "QUOTA");
                } 
                
                }

{id}        { printf("%-8s \t %s\n", yytext, "IDENT");}
{CPPcomment}   {
                char *Comment_content = yytext;
                
                printf("%-8s \t %-8s\n"
                        , Comment_content
                        , "C++ Comment");
                comment_num++;
                }
                
{Ccomment}   {  
                    char buffer[1024] = {0};
                    char *bufferPtr = buffer;
                    char *p =  malloc(strlen(yytext) + 1);
                    char *Comment_content = malloc(strlen(yytext) + 1);
                    strcpy(p, yytext);
                    strcpy(Comment_content, yytext);
                    char *toInsert = " \t C Comment";
                    
                    int number_newline = 0;

                    while (*p) {
                    if (*p == '\n') {
            
                        strcpy(bufferPtr, toInsert);
                        bufferPtr += strlen(toInsert);
                        number_newline++;
                    }

                    *bufferPtr++ = *p++;
                    }
    
                     *bufferPtr = '\0';
    
                    strcpy(Comment_content, buffer);
    
                int length = strlen(yytext);
                char *newline = strstr(yytext, "\n");

                if(length >= 2 && newline){

                    comment_num += (number_newline + 1);
                    line_num += (number_newline);

                    printf("%s \t %-8s\n", Comment_content, "C Comment");
                }
                
                else{
                    printf("%-8s \t %s\n"
                        , yytext
                        , "C Comment");
                    comment_num++;
                    
                }
          }


<<EOF>>     { line_num++; yyterminate(); }
.           {;}

%%

/*  C Code section */
int yywrap(void)
{
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }
    yylex();
    printf("\nFinish scanning,\n");
    printf("total line: %d\n", line_num);
    printf("comment line: %d\n", comment_num);
    fclose(yyin);
    return 0;
}
