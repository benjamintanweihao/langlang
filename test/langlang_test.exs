defmodule LangLangTest do
  use ExUnit.Case

  alias LangLang, as: LL

  test "arithmetic evaluation" do
    assert 0 == LL.eval('1 + 2 * 3 / 2 - 4')
    assert 0.5 == LL.eval('(1 + 2) * 3 / 2 - 4')
  end

end
