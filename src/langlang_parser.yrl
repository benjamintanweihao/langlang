% Grammar for the LangLang language done with yecc

Nonterminals
  arithmetic
  add_op
  mul_op
  number
  .

Terminals
  integer
  float
  '+' '-' '*' '/' '(' ')'
  .

Rootsymbol arithmetic.

Left 100 add_op.
Left 200 mul_op.

%% Arithmetic

arithmetic -> arithmetic add_op arithmetic :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

arithmetic -> arithmetic mul_op arithmetic :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

arithmetic -> '(' arithmetic ')' : '$2'.
arithmetic -> number : '$1'.

%% Numbers
number -> integer : '$1'.
number -> float : '$1'.


%% Addition operator
add_op -> '+' : '$1'.
add_op -> '-' : '$1'.

%% Multiplication operator
mul_op -> '*' : '$1'.
mul_op -> '/' : '$1'.

Erlang code.

-define(op(Node), element(1, Node)).
-define(line(Node), element(2, Node)).
