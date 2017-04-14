% Lexer syntax for the LangLang language

Definitions.

Digit      = [0-9]
Whitespace = [\s]
Lowercase  = [a-z]
Uppercase  = [A-Z]
Comment    = #.*

Rules.

%% Numbers

{Digit}+                                    : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{Digit}+\.{Digit}+                          : {token, {float, TokenLine, list_to_float(TokenChars)}}.

%% Variable names
({Lowercase}|_)({Lowercase}|{Uppercase}|_)* : {token, {var, TokenLine, list_to_atom(TokenChars)}}.

%% Skip

{Comment}     : skip_token.
{Whitespace}+ : skip_token.

%% Newlines and Comments
({Comment}|{Whitespace})*(\n({Comment}|{Whitespace})*)+ : {token, {eol, TokenLine}}.

%% Operators

\+    : {token, {'+', TokenLine}}.
\-    : {token, {'-', TokenLine}}.
\*    : {token, {'*', TokenLine}}.
\/    : {token, {'/', TokenLine}}.
\(    : {token, {'(', TokenLine}}.
\)    : {token, {')', TokenLine}}.
\=    : {token, {'=', TokenLine}}.
->    : {token, {'->', TokenLine}}.

Erlang code.
