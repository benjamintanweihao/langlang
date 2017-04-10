% Grammar for the LangLang language done with yecc

Nonterminals
  expr
  assign_expr
  add_expr
  mul_expr
  unary_expr
  max_expr
  add_op
  mul_op
  unary_op
  number
  .

Terminals
  integer float var
  '+' '-' '*' '/' '(' ')' '='
  .

Rootsymbol expr.

%% Assignment

expr -> assign_expr : '$1'.

assign_expr -> add_expr '=' assign_expr :
  { match, ?line('$2'), '$1', '$3' }.

assign_expr -> add_expr : '$1'.

%% Arithmetic

add_expr -> add_expr add_op mul_expr :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

add_expr -> mul_expr : '$1'.

mul_expr -> mul_expr mul_op unary_expr :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

mul_expr -> unary_expr : '$1'.

unary_expr -> unary_op max_expr :
  { unary_op, ?line('$1'), ?op('$1'), '$2' }.

unary_expr -> max_expr : '$1'.

%% Minimum expressions
max_expr -> var : '$1'.
max_expr -> number : '$1'.
max_expr -> '(' expr ')' : '$2'.

%% Numbers
number -> integer : '$1'.
number -> float : '$1'.

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
