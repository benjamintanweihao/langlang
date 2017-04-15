defmodule LangLang do

  def eval(input), do: eval(input, [])

  def eval(input, binding) do
    {:value, value, new_binding} =
      input
      |> parse
      |> Enum.map(&transform(&1))
      |> erl_eval(binding)

    {value, new_binding}
  end

  # Handle empty files
  defp erl_eval([], binding), do: {:value, [], binding}

  defp erl_eval(transformed, binding) do
    :erl_eval.exprs(transformed, binding)
  end

  defp parse(input) do
    {:ok, tokens, _} = :langlang_lexer.string(input)
    {:ok, parse_tree} = :langlang_parser.parse(tokens)
    parse_tree
  end

  # Patterns can be found at http://erlang.org/doc/apps/erts/absform.html

  defp transform({:fun, line, clauses}) do
    {:fun, line, transform(clauses)}
  end

  defp transform({:clauses, clauses}) do
    {:clauses, clauses |> Enum.map(&transform(&1))}
  end

  # WIP: Collapse this together.
  defp transform({:if_clause, line, true, x, expr}) do
    {:case, line, {:atom, line, :true}, [
      {:clause, line, [{:atom, line, :true}], [], expr |> Enum.map(&transform(&1))}
    ]}
  end

  defp transform({:if_clause, line, false, _, expr}) do
    {:case, line, {:atom, line, :false}, [
        {:clause, line, [{:atom, line, :false}], [], [{:atom, line, nil}]},
        {:clause, line, [{:atom, line, :true}], [], expr |> Enum.map(&transform(&1))}
    ]}
  end

  defp transform({:clause, line, [], [], expr}) do
    {:clause, line, [], [], expr |> Enum.map(&transform(&1))}
  end

  defp transform({:clause, line, args, [], expr}) do
    {:clause, line, transform(args), [], expr |> Enum.map(&transform(&1))}
  end

  defp transform({:binary_op, line, op, lhs, rhs}) do
    {:op, line, op, transform(lhs), transform(rhs)}
  end

  defp transform({:unary_op, line, op, rhs}) do
    {:op, line, op, transform(rhs)}
  end

  defp transform({:match, line, lhs, rhs}) do
    {:match, line, transform(lhs), transform(rhs)}
  end

  defp transform({true, line}) do
    {:atom, line, :true}
  end

  defp transform({false, line}) do
    {:atom, line, :false}
  end

  # Match all other expressions. Types:
  #   integer
  #   var
  defp transform(expr), do: expr

  defp debug(input) do
    IO.inspect input
    input
  end

end
