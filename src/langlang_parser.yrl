% Grammar for the LangLang language done with yecc

Nonterminals
  grammar
  expr_list
  expr
  assign_expr
  add_expr
  mul_expr
  unary_expr
  fun_expr
  given_args
  given_args_tail
  stabber
  max_expr
  add_op
  mul_op
  unary_op
  number
  boolean
  if_expr
  comp_expr
  .

Terminals
  var float integer eol
  'func' 'end'
  'true' 'false'
  'if' 'then'
  '+' '-' '*' '/' '(' ')' '=' '->' ',' '=='
  .

Rootsymbol grammar.

grammar -> expr_list : '$1'.
grammar -> '$empty' : [].

expr_list -> eol : [].
expr_list -> expr : ['$1'].
expr_list -> expr eol : ['$1'].
expr_list -> eol expr_list : '$2'.
expr_list -> expr eol expr_list : ['$1'|'$3'].

expr -> assign_expr : '$1'.
expr -> if_expr : '$1'.
expr -> comp_expr : '$1'.

%% Conditionals (WIP)

if_expr -> 'if' boolean 'then' expr_list 'end' :
  { 'if_clause', ?line('$1'), ?op('$2'), '$2', '$4' }.

if_expr -> 'if' comp_expr 'then' expr_list 'end' :
  { 'if_clause', ?line('$1'), ?op('$2'), '$2', '$4' }.

%% Assignment

assign_expr -> add_expr '=' assign_expr :
  { match, ?line('$2'), '$1', '$3' }.

assign_expr -> add_expr : '$1'.

%% Comparison Expressions

comp_expr -> expr '==' expr :
                 { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

%% Arithmetic

add_expr -> add_expr add_op mul_expr :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

add_expr -> mul_expr : '$1'.

mul_expr -> mul_expr mul_op unary_expr :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

mul_expr -> unary_expr : '$1'.

unary_expr -> unary_op max_expr :
  { unary_op, ?line('$1'), ?op('$1'), '$2' }.

unary_expr -> fun_expr : '$1'.

%% Function definitions

fun_expr -> 'func' stabber expr 'end' :
  { 'fun', ?line('$1'),
    { clauses, [ { clause, ?line('$1'), [], [], ['$3'] } ] }
  }.

fun_expr -> 'func' given_args stabber expr 'end' :
  { 'fun', ?line('$1'),
    { clauses, [ { clause, ?line('$1'), '$2', [], ['$4'] } ] }
  }.

fun_expr -> max_expr : '$1'.

%% Args given to function declarations
given_args -> '(' ')' : [].
given_args -> '(' eol ')' : [].
given_args -> '(' var given_args_tail : ['$2'|'$3'].

given_args_tail -> ',' var given_args_tail : ['$2'|'$3'].
given_args_tail -> ')' : [].
given_args_tail -> eol ')' : [].

%% Minimum expressions
max_expr -> var : '$1'.
max_expr -> number : '$1'.
max_expr -> boolean : '$1'.
max_expr -> '(' expr ')' : '$2'.

%% Stab syntax
stabber -> '->' : '$1'.

%% Numbers
number -> integer : '$1'.
number -> float : '$1'.

boolean -> true : '$1'.
boolean -> false : '$1'.

%% Unary operator
unary_op -> '+' : '$1'.
unary_op -> '-' : '$1'.

%% Addition operator
add_op -> '+' : '$1'.
add_op -> '-' : '$1'.

%% Multiplication operator
mul_op -> '*' : '$1'.
mul_op -> '/' : '$1'.

Erlang code.

-define(op(Node), element(1, Node)).
-define(line(Node), element(2, Node)).
