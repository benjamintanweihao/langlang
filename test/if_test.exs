defmodule IfTest do
  use ExUnit.Case, async: true

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "if with boolean" do
    {:ok, tokens, _} = L.string('if true then a = 1 end')

    result = {:ok,
              [{:if_clause, 1, true, {true, 1},
                [{:match, 1, {:var, 1, :a}, {:integer, 1, 1}}]}]}

    assert result == tokens |> P.parse
  end

end
