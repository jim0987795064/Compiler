/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INT = 258,                     /* INT  */
    FLOAT = 259,                   /* FLOAT  */
    BOOL = 260,                    /* BOOL  */
    STRING = 261,                  /* STRING  */
    SUB = 262,                     /* SUB  */
    MUL = 263,                     /* MUL  */
    QUO = 264,                     /* QUO  */
    REM = 265,                     /* REM  */
    INC = 266,                     /* INC  */
    DEC = 267,                     /* DEC  */
    SEMICOLON = 268,               /* SEMICOLON  */
    IDENT = 269,                   /* IDENT  */
    ADD = 270,                     /* ADD  */
    PRINT = 271,                   /* PRINT  */
    LPAREN = 272,                  /* LPAREN  */
    RPAREN = 273,                  /* RPAREN  */
    POS = 274,                     /* POS  */
    NEG = 275,                     /* NEG  */
    GTR = 276,                     /* GTR  */
    AND = 277,                     /* AND  */
    OR = 278,                      /* OR  */
    NOT = 279,                     /* NOT  */
    TRUE = 280,                    /* TRUE  */
    FALSE = 281,                   /* FALSE  */
    INT_LIT = 282,                 /* INT_LIT  */
    FLOAT_LIT = 283,               /* FLOAT_LIT  */
    STRING_LIT = 284               /* STRING_LIT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define INT 258
#define FLOAT 259
#define BOOL 260
#define STRING 261
#define SUB 262
#define MUL 263
#define QUO 264
#define REM 265
#define INC 266
#define DEC 267
#define SEMICOLON 268
#define IDENT 269
#define ADD 270
#define PRINT 271
#define LPAREN 272
#define RPAREN 273
#define POS 274
#define NEG 275
#define GTR 276
#define AND 277
#define OR 278
#define NOT 279
#define TRUE 280
#define FALSE 281
#define INT_LIT 282
#define FLOAT_LIT 283
#define STRING_LIT 284

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 47 "compiler_hw2.y"

    int i_val;
    float f_val;
    char *s_val;
    struct {
        char* id_name;
        /* 其他成员 */
    } ctr;
    /* ... */

#line 136 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
