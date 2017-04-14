defmodule FunctionTest do
  use ExUnit.Case, async: true

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "anonymous function assignment" do
    {:ok, tokens, _} = L.string('a = func -> 1 + 2 end')

    result = {:ok,
              [{:match, 1, {:var, 1, :a},
                {:fun, 1,
                 {:clauses,
                  [{:clause, 1, [], [],
                    [{:binary_op, 1, :+, {:integer, 1, 1},
                      {:integer, 1, 2}}]}]}}}]}

    assert result == tokens |> P.parse
  end

  test "anonymous function with arguments" do
    {:ok, tokens, _} = L.string('a = func(b, c) -> b + c end')

    result = {:ok,
              [{:match, 1, {:var, 1, :a},
                {:fun, 1,
                 {:clauses,
                  [{:clause, 1, [{:var, 1, :b}, {:var, 1, :c}], [],
                    [{:binary_op, 1, :+, {:var, 1, :b}, {:var, 1, :c}}]}]}}}]}

    assert result == tokens |> P.parse
  end

end
