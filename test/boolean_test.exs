defmodule BooleanTest do
  use ExUnit.Case, async: true

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "true" do
    {:ok, tokens, _} = L.string('true')

    result = {:ok, [{:true, 1}]}

    assert result == tokens |> P.parse
  end

  test "false" do
    {:ok, tokens, _} = L.string('false')

    result = {:ok, [{:false, 1}]}

    assert result == tokens |> P.parse
  end

  test "equality" do
    {:ok, tokens, _} = L.string('42 == 42')

    result = {:ok, [{:binary_op, 1, :==, {:integer, 1, 42}, {:integer, 1, 42}}]}

    assert result == tokens |> P.parse
  end

end
