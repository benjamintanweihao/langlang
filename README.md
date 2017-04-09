# LangLang

Nothing to see here, seriously.

```elixir
iex(1)> {:ok, tokens, _} = :langlang_lexer.string('315')
{:ok, [{:integer, 1, 315}], 1}

iex(2)> :langlang_parser.parse(tokens)
{:ok, {:integer, 1, 315}}
```
