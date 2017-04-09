% Lexer syntax for the LangLang language

Definitions.

Digit = [0-9]

Rules.

%% Numbers

{Digit}+           :   { token, { integer, TokenLine, list_to_integer(TokenChars) } }.
{Digit}+\.{Digit}+ :   { token, { float, TokenLine, list_to_float(TokenChars) } }.

%% Operators

\+    : { token, { '+', TokenLine } }.

Erlang code.

