% Lexer syntax for the LangLang language

Definitions.

Digit = [0-9]

Rules.

%% Numbers

{Digit}+        :   {token,{integer,TokenLine,list_to_integer(TokenChars)}}.

Erlang code.

