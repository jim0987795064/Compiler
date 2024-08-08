/*	Definition section */
%{
    #include "common.h" //Extern variables that communicate with lex
    // #define YYDEBUG 1
    // int yydebug = 1;

    extern int yylineno;
    extern int yylex();
    extern FILE *yyin;

    void yyerror (char const *s)
    {
        printf("error:%d: %s\n", yylineno, s);
    }

    int scope = 0;

    struct symbol* table[10];
    struct symbol* current[10];

    struct symbol{
        
        int index;
        char* name;
        char* type;
        int address;
        int lineno;
        char* element_type;
        int scope;
        struct symbol* next;
        
    };


    /* Symbol table function - you can add new function if needed. */
    static void create_symbol(int);
    static void insert_symbol(char *, char *, char *, int);
    static void lookup_symbol(char* );
    static void dump_symbol(int);
%}

%error-verbose

/* Use variable or self-defined structure to represent
 * nonterminal and token type
 */
%union {
    int i_val;
    float f_val;
    char *s_val;
    struct {
        char* id_name;
        /* 其他成员 */
    } ctr;
    /* ... */
}

/* Token without return */
%token INT FLOAT BOOL STRING SUB MUL QUO REM INC DEC 
%token SEMICOLON 
%token <s_val>IDENT   
%token <s_val>ADD 
%token <s_val>PRINT LPAREN RPAREN
%token <s_val> POS
%token <s_val> NEG
%token <s_val> GTR
%token <s_val> AND
%token <s_val> OR
%token <s_val> NOT
%token <s_val> TRUE
%token <s_val> FALSE

/* Token with return, which need to sepcify type */
%token <i_val> INT_LIT
%token <f_val> FLOAT_LIT
%token <s_val> STRING_LIT

/* Nonterminal with return, which need to sepcify type */
%type <s_val> Type  
%type <s_val> operation 
%type <i_val> IntArithStmt


/* Yacc will start at this nonterminal */
%start Program

/* Grammar section */
%%

Program
    : StatementList
;

Type
    : INT
    | FLOAT
    | STRING
    | BOOL
;

operation
    : ADD operation
    | POS operation
    | NEG operation
    | SUB operation
    | MUL operation
    | QUO operation
    | REM operation
    | INC operation
    | DEC operation
    | LPAREN operation
    | RPAREN operation
    | GTR operation
    | OR operation
    | NOT operation
    | TRUE operation
    | FALSE operation
    | AND operation
    | IntArithStmt
    | SEMICOLON
    |
;

Literal
    : INT_LIT 
    | FLOAT_LIT
;

StatementList
    : StatementList DeclarationStmt
    | Block
    | IfStmt
    | LoopStmt
    | StatementList PrintStmt
    | StatementList IntArithStmt
    | StatementList DoubleSymbolStmt
    | StatementList
    |
;

DeclarationStmt 
    : Type IDENT SEMICOLON {insert_symbol($2, $1, "-", scope);}
;

IntArithStmt
    : IDENT operation IDENT SEMICOLON {lookup_symbol($1);
                                       lookup_symbol($3);
                                       printf("%s\n", $2);}
    | Literal operation IntArithStmt SEMICOLON
;

DoubleSymbolStmt
    : IDENT operation SEMICOLON {lookup_symbol($1);
                                printf("%s\n", $2);}
;

Block
    : "{" StatementList "}" {scope++;}
;

IfStmt
    :
;

LoopStmt
    :
;

PrintStmt
    : PRINT LPAREN StatementList RPAREN SEMICOLON {printf("%s\n", $1);}
;

%%

/* C code section */

int scopeIndex[100];
int address = 0;



int main(int argc, char *argv[])
{
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }

    for(int i = 0; i < 100;i++)
        scopeIndex[i] = 0;

    for(int i = 0; i < 10;i++)
        table[i] = NULL;

    yyparse();
    dump_symbol(0);
	printf("Total lines: %d\n", yylineno);
    fclose(yyin);
    return 0;
}

void insert_symbol(char* name, char* type, char* element_type, int scope){

    struct symbol* node = (struct symbol *)malloc(sizeof(struct symbol));
    
    node->index = scopeIndex[scope]++;
    node->name = name;
    node->type = type;
    node->address = address;
    node->lineno = yylineno;
    node->element_type = element_type;
    node->scope = scope;

    address++;

    if(node->index == 0){

        current[scope] = node;
        table[scope] = node;

        node->next = NULL;
        
    }
    else{

        if(current[scope])
            current[scope]->next = node;
        current[scope] = node;

        node->next = NULL;
    }

    printf("> Insert {%s} into symbol table (scope level: %d)\n", name, scope);

    return;
}


void create_symbol(int scope){

    return;
}

void lookup_symbol(char* name){

    struct symbol* first = table[scope];

    int check = 0;

    do{

    check = strcmp(first->name, name);

    if(!check)
        break;

    first = first->next;

    }while(first);

    printf("IDENT (name=%s, address=%d)\n", first->name, first->address);

    return;
}

void dump_symbol(int scope){

    scopeIndex[scope] = 0;

    struct symbol* first = table[scope];

    printf("> Dump symbol table (scope level: %d)\n",
           scope);

    printf("%-9s %-9s %-9s %-9s %-9s %-9s\n",
           "Index",
           "Name",
           "Type",
           "Address",
            "Lineno",
            "Element type");

    while(first){

        printf("%-9d %-9s %-9s %-9d %-9d %-s\n",
                first->index,
                first->name,
                first->type,
                first->address,
                first->lineno,
                first->element_type
                );

        first = first->next;

    }


    return;
}



