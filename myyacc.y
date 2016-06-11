%{
#include <stdio.h>
void yyerror(char *s);
%}

%union{
    char *id;
    int num;
}
%token INT CHAR RETURN IF ELSE WHILE BREAK PRINT READ
%token ASSIGN NOT PLUS MINUS MULTIPLY DIVIDE
%token EQUAL NOT_EQUAL LESS GREATER LESS_EQUAL GREATER_EQUAL AND OR
%token O_BRACKET C_BRACKET O_PARENTHESIS C_PARENTHESIS O_BRACE 
       C_BRACE SEMICOLON COMMA
%token <id> IDENTIFIER
%token <num> NUMBER
%token A_CHAR
%token COMMENT
/*小心 MINUS可能是減法或是負號*/
%%

Program: DeclList
       ;
DeclList: DeclList_  DeclList
	    | /*epsilon*/
        ;
DeclList_: Type IDENTIFIER Decl
         ;
Decl: VarDecl_ 
    | FunDecl
    ;
VarDecl: Type IDENTIFIER VarDecl_
         ;
VarDecl_:  SEMICOLON
         | O_BRACKET NUMBER C_BRACKET SEMICOLON
         ;
FunDecl: O_PARENTHESIS ParamDeclList C_PARENTHESIS Block
       ;
VarDeclList: VarDecl VarDeclList
           | /*epsilon*/
           ;
ParamDeclList: ParamDeclListTail
	         | /*epsilon*/
             ;
ParamDeclListTail: ParamDecl ParamDeclListTail_
                 ;
ParamDeclListTail_:	COMMA ParamDeclListTail
                  |	/*epsilon*/
                  ;
ParamDecl: Type IDENTIFIER ParamDecl_
         ;
ParamDecl_: O_BRACKET C_BRACKET
	      | /*epsilon*/
          ;
Block: O_BRACE VarDeclList StmtList C_BRACE
     ;
Type: INT
	| CHAR
    ;
StmtList: Stmt StmtList_
        ;
StmtList_: StmtList
	     | /*epsilon*/
         ;
Stmt: SEMICOLON
	| Expr SEMICOLON
	| RETURN Expr SEMICOLON
	| BREAK SEMICOLON
	| IF O_PARENTHESIS Expr C_PARENTHESIS Stmt ELSE Stmt
	| WHILE O_PARENTHESIS Expr C_PARENTHESIS Stmt
	| Block
	| PRINT IDENTIFIER SEMICOLON 
	| READ IDENTIFIER SEMICOLON
    ;
Expr: UnaryOp Expr
	| NUMBER Expr_
	| O_PARENTHESIS Expr C_PARENTHESIS Expr_
	| IDENTIFIER ExprIdTail
    ;
ExprIdTail:	Expr_
	| O_PARENTHESIS ExprList C_PARENTHESIS Expr_
	| O_BRACKET Expr C_BRACKET ExprArrayTail
	| ASSIGN Expr
    ;
ExprArrayTail: Expr_
	         | ASSIGN Expr
             ;
Expr_: BinOp Expr
	 | /*epsilon*/
     ;
ExprList: ExprListTail
	    | /*epsilon*/
        ;
ExprListTail: Expr ExprListTail_
            ;
ExprListTail_: COMMA ExprListTail
	         | /*epsilon*/
             ;
UnaryOp: MINUS
       | NOT
       ;
BinOp: PLUS
	 | MINUS
	 | MULTIPLY
	 | DIVIDE
 	 | EQUAL
	 | NOT_EQUAL
	 | LESS
	 | LESS_EQUAL
	 | GREATER
	 | GREATER_EQUAL
	 | AND
	 | OR
     ;

%%
extern FILE *yyin;

main(){
    yyparse();
}
void yyerror (char *s) {fprintf (stderr, "%s, byebye\n",s);}
