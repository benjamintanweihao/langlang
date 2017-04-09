% Grammar for the LangLang language done with yecc

Nonterminals
  arithmetic
  add_op
  number
  .

Terminals
  integer
  float
  '+'
  .

Rootsymbol arithmetic.

Left 100 add_op.

%% Arithmetic

arithmetic -> arithmetic add_op arithmetic :
  { binary_op, ?line('$1'), ?op('$2'), '$1', '$3' }.

arithmetic -> number : '$1'.

%% Numbers
number -> integer : '$1'.
number -> float : '$1'.


%% Addition operator
add_op -> '+' : '$1'.

Erlang code.

-define(op(Node), element(1, Node)).
-define(line(Node), element(2, Node)).
