defmodule LangLangTest do
  use ExUnit.Case

  alias :langlang_lexer, as: L
  alias :langlang_parser, as: P

  test "integers" do
    {:ok, tokens, _} = L.string('315')

    assert {:ok, {:integer, 1, 315}} == tokens |> P.parse
  end
end
