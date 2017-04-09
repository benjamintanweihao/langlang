% Grammar for the LangLang language done with yecc

Nonterminals
  number.

Terminals
  integer.

Rootsymbol number.

%% Numbers
number -> integer : '$1'.
