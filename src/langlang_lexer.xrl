% Lexer syntax for the LangLang language

Definitions.

Digit = [0-9]
Whitespace = [\s]
Lowercase = [a-z]
Uppercase = [A-Z]

Rules.

%% Numbers

{Digit}+                                    : { token, { integer, TokenLine, list_to_integer(TokenChars) } }.
{Digit}+\.{Digit}+                          : { token, { float, TokenLine, list_to_float(TokenChars) } }.

%% Variable names
({Lowercase}|_)({Lowercase}|{Uppercase}|_)* : { token, { var, TokenLine, list_to_atom(TokenChars) } }.


{Whitespace}       : skip_token.

%% Operators

\+    : { token, { '+', TokenLine } }.
\-    : { token, { '-', TokenLine } }.
\*    : { token, { '*', TokenLine } }.
\/    : { token, { '/', TokenLine } }.
\(    : { token, { '(', TokenLine } }.
\)    : { token, { ')', TokenLine } }.
\=    : { token, { '=', TokenLine } }.

Erlang code.
