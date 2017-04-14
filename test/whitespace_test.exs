defmodule WhitespaceTest do
  use ExUnit.Case, async: true

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "whitespace is ignored" do
    {:ok, tokens, _} = L.string('    ')

    assert {:ok, []} == tokens |> P.parse
  end

end
