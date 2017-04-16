defmodule LangLangTest do
  use ExUnit.Case, async: true

  alias LangLang, as: LL

  test "arithmetic evaluation" do
    assert {0, []} == LL.eval('1 + 2 * 3 / 2 - 4')
    assert {0.5, []} == LL.eval('(1 + 2) * 3 / 2 - 4')
  end

  test "assignment" do
    assert {42, [{:a, 42}]} == LL.eval('a = 42')
    assert {42, [{:b, 42}]} == LL.eval('b = 40 + 2')
    assert {42, [{:c, 42}]} == LL.eval('c = (8 * 10) / 2 + 2')
    assert {42, [{:a, 42}, {:b, 42}, {:c, 42}]} == LL.eval('a = b = c = 42')
  end

  test "assignment with bindings" do
    assert {42, [{:a, 42}, {:b, 2}]} == LL.eval('a = 40 + b', [{:b, 2}])
    assert {42, [{:a, 42}, {:b, 2}]} == LL.eval('a = 40 + b', [{:b, 2}])
    assert {42, [{:a, 42}, {:b, 1}, {:c, 3}]} == LL.eval('a = (38 + (b = 1) + c)', [{:c, 3}])
  end

  test "multiline" do
    assert {42, [{:a, 1}, {:b, 42}]} == LL.eval('a = 1\nb=42')
    assert {42, [{:a, 1}, {:b, 42}]} == LL.eval('\n\na = 1\n\nb=42\n\n')
  end

  test "comments" do
    assert {[], []} == LL.eval('#a = 1\n#b=42')
    assert {[], []} == LL.eval('#')
    assert {1, [{:a, 1}]} == LL.eval('#\na = 1\n#b=42\n#')
    assert {42, [{:a, 1}, {:c, 42}]} == LL.eval('#\na = 1\n#b=2\n#\nc=42')
  end

  test "anonymous function" do
    {fun, [a: fun]} = LL.eval('a = func -> 1 + 2 end')
    assert fun.() == 3

    {fun, [a: fun]} = LL.eval('a = func -> func -> 1 + 2 end end')
    assert fun.().() == 3
  end

  test "anonymous function with empty arguments" do
    {fun, [a: fun]} = LL.eval('a = func() -> 3 end')

    assert fun.() == 3
  end

  test "anonymous function with one argument" do
    {fun, [a: fun]} = LL.eval('a = func(b) -> b end')

    assert fun.(3) == 3
  end

  test "anonymous function with multiple arguments" do
    {fun, [a: fun]} = LL.eval('a = func(b, c, d) -> b + c + d end')

    assert fun.(1, 2, 39) == 42
  end

  test "booleans" do
    assert {true, [{:a, true}]} == LL.eval('a = true')
    assert {false, [{:b, false}]} == LL.eval('b = false')
  end

  test "if true expression" do
    assert {2, [{:a, 1}, {:b, 2}]} == LL.eval('if true then a = 1\nb = 2 end')
  end

  test "if false expression" do
    assert {nil, []} == LL.eval('if false then a = 1\nb = 2 end')
  end

  test "equality comparison" do
    assert {true, []} == LL.eval('42 == 42')
    assert {false, []} == LL.eval('42 == 43')
    assert {true, [{:a, 1}, {:b, 1}]} == LL.eval('(a = 1) == (b = 1)')
  end

  test "inequality comparison" do
    assert {false, []} == LL.eval('42 != 42')
  end

  test "if equality expression" do
    assert {2, [{:a, 1}, {:b, 2}]} == LL.eval('if 42 == 42 then a = 1\nb = 2 end')
    assert {nil, []} == LL.eval('if 43 == 42 then a = 1\nb = 2 end')
  end

  test "if inequality expression" do
    assert {2, [{:a, 1}, {:b, 2}]} == LL.eval('if 42 != 43 then a = 1\nb = 2 end')
    assert {nil, []} == LL.eval('if 42 != 42 then a = 1\nb = 2 end')
  end

end
