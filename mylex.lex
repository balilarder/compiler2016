%{
#include <stdio.h>
#include "y.tab.h"
/*
lex will return tokens(6 types):
    keywords: int, char, return, if, else, while, break, print, read
    arithmetic op: =, !, +, -, *, /
    comparision op: ==, !=, <, >, <=, >=, &&, ||
    special symbols: [, ], (, ), {, }, ;, , 
    id: beginning by "id"Uppercase_string
    number: 0~9 string
        
    just id and number these two token need a value, so need a type
    id is a string, and number is a int.(yacc can define by union)
*/
int newline_count = 0;

void lex_failed(char *s);
%}

%%

\n               {printf("\n");}
 /* keyword */
int              {printf("INT ");return INT;}
char             {printf("CHAR ");return CHAR;}
return           {printf("RETURN ");return RETURN;}
if               {printf("IF ");return IF;}
else             {printf("ELSE ");return ELSE;}
while            {printf("WHILE ");return WHILE;}
break            {printf("BREAK ");return BREAK;}
print            {printf("PRINT ");return PRINT;}
read             {printf("READ ");return READ;}
 /* arithmrtic op */
=                {printf("ASSIGN ");return ASSIGN;}
!                {printf("NOT ");return NOT;}
\+               {printf("PLUS ");return PLUS;}
-                {printf("MINUS ");return MINUS;}
\*               {printf("MULTIPLY ");return MULTIPLY;}
\/               {printf("DIVIDE ");return DIVIDE;}
 /* comparison op */
==               {printf("EQUAL ");return EQUAL;}
!=               {printf("NOT_EQUAL ");return NOT_EQUAL;}
\<               {printf("LESS ");return LESS;}
>                {printf("GREATER ");return GREATER;}
\<=              {printf("LESS_EQUAL ");return LESS_EQUAL;}
>=               {printf("GREATER_EQUAL ");return GREATER_EQUAL;}
&&               {printf("AND ");return AND;}
"||"             {printf("OR "); return OR;}
 /* special symbols */
"["              {printf("[");return O_BRACKET;}
"]"              {printf("]");return C_BRACKET;}
"("              {printf("(");return O_PARENTHESIS;}
")"              {printf(")");return C_PARENTHESIS;}
"{"              {printf("{");return O_BRACE;}
"}"              {printf("}");return C_BRACE;}
;                {printf(";");return SEMICOLON;}
,                {printf(",");return COMMA;}
 /* identifier(incorrect) */
id[A-Z][a-z]*    {printf("%s ", yytext);return IDENTIFIER;}
 /* numbers */
[0-9]+           {printf("%s ", yytext);return NUMBER;}
 /* a char in " " */
\"[a-zA-Z0-9]\"  {printf("%s ",yytext);return A_CHAR;}
 /* a one line comment(but return comment is useless)*/
"//".*\n         {printf("%s ",yytext);/*return COMMENT;*/}
 /* other */
[\t ]+           ;  /* ignore any space or tab. */
.                {printf("WTF? ");lex_failed(yytext);}

%%

void lex_failed(char *s){
    //exit(1);
}
