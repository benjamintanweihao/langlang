defmodule FunctionTest do
  use ExUnit.Case

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "function assignment" do
    {:ok, tokens, _} = L.string('a = -> 1 + 2')

    result = {:ok,
              [{:match, 1, {:var, 1, :a},
                {:fun, 1,
                 {:clauses,
                  [{:clause, 1, [], [],
                    [{:binary_op, 1, :+, {:integer, 1, 1},
                      {:integer, 1, 2}}]}]}}}]}

    assert result == tokens |> P.parse
  end

end
