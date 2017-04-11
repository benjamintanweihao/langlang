defmodule LangLangTest do
  use ExUnit.Case

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

end
