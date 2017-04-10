defmodule AssignmentTest do
  use ExUnit.Case

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "basic assignment" do
    {:ok, tokens, _} = L.string('a = 42')

    result = tokens |> P.parse

    assert result == {:ok, {:match, 1, {:var, 1, :a}, {:integer, 1, 42}}}
  end

end
