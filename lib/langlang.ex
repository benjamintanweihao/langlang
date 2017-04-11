defmodule LangLang do

  def eval(input), do: eval(input, [])

  def eval(input, binding) do
    {:value, value, new_binding} =
      input
      |> parse
      |> Enum.map(&transform(&1))
      |> :erl_eval.exprs(binding)

    {value, new_binding}
  end

  defp parse(input) do
    {:ok, tokens, _} = :langlang_lexer.string(input)
    {:ok, parse_tree} = :langlang_parser.parse(tokens)
    parse_tree
  end

  # Patterns can be found at http://erlang.org/doc/apps/erts/absform.html

  defp transform({:binary_op, line, op, lhs, rhs}) do
    {:op, line, op, transform(lhs), transform(rhs)}
  end

  defp transform({:unary_op, line, op, rhs}) do
    {:op, line, op, transform(rhs)}
  end

  defp transform({:match, line, lhs, rhs}) do
    {:match, line, transform(lhs), transform(rhs)}
  end

  # Match all other expressions. Types:
  #   integer
  #   var
  defp transform(expr), do: expr

end
