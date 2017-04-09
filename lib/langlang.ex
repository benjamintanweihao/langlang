defmodule LangLang do

  def eval(input) do
    {:value, value, _} = input |> parse |> transform |> :erl_eval.expr([])
    value
  end

  defp parse(input) do
    {:ok, tokens, _} = :langlang_lexer.string(input)
    {:ok, parse_tree} = :langlang_parser.parse(tokens)
    parse_tree
  end

  # Patterns can be found at http://erlang.org/doc/apps/erts/absform.html

  defp transform({:integer, _, _} = expr), do: expr
  defp transform({:binary_op, line, op, lhs, rhs}) do
    {:op, line, op, transform(lhs), transform(rhs)}
  end

end
