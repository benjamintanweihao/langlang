% Lexer syntax for the LangLang language

Definitions.

Digit = [0-9]
Whitespace = [\s]

Rules.

%% Numbers

{Digit}+           :   { token, { integer, TokenLine, list_to_integer(TokenChars) } }.
{Digit}+\.{Digit}+ :   { token, { float, TokenLine, list_to_float(TokenChars) } }.

{Whitespace}       : skip_token.

%% Operators

\+    : { token, { '+', TokenLine } }.

Erlang code.
