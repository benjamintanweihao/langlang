% Lexer syntax for the LangLang language

Definitions.

Digit      = [0-9]
Whitespace = [\s]
Lowercase  = [a-z]
Uppercase  = [A-Z]
Comment    = #.*

Rules.

%% Numbers

{Digit}+              : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{Digit}+\.{Digit}+    : {token, {float, TokenLine, list_to_float(TokenChars)}}.

%% Variable names
({Lowercase}|_)({Lowercase}|{Uppercase}|_)* : {token, build_id(TokenLine, TokenChars)}.

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
,     : {token, {',', TokenLine}}.
->    : {token, {'->', TokenLine}}.
==    : {token, {'==', TokenLine}}.
!=    : {token, {'!=', TokenLine}}.
<     : {token, {'<', TokenLine}}.
>     : {token, {'>', TokenLine}}.

Erlang code.

build_id(Line, Chars) ->
    Atom = list_to_atom(Chars),
    case reserved_word(Atom) of
        true -> {Atom, Line};
        false -> {var, Line, Atom}
    end.

reserved_word('if')    -> true;
reserved_word('then')  -> true;
reserved_word('else')  -> true;
reserved_word('end')   -> true;
reserved_word('true')  -> true;
reserved_word('false') -> true;
reserved_word('func')  -> true;
reserved_word(_)       -> false. % Anything else is not reserved
