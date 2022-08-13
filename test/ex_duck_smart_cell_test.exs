defmodule ExDuckSmartCellTest do
  use ExUnit.Case, async: true

  import Kino.Test

  setup :configure_livebook_bridge

  test "initial source uses the defaults" do
    {_kino, source} = start_smart_cell!(ExDuckSmartCell, %{})

    assert source == """
           results = ExDuck.answer!(\"\")
           results |> ExDuck.to_markdown() |> Kino.Markdown.new()\
           """
  end

  test "uses topic and variable from attrs" do
    attrs = %{
      "variable" => "query_results",
      "topic" => "Elixir Language"
    }

    {_kino, source} = start_smart_cell!(ExDuckSmartCell, attrs)

    assert source ==
             """
             query_results = ExDuck.answer!(\"Elixir Language\")
             query_results |> ExDuck.to_markdown() |> Kino.Markdown.new()\
             """
  end
end
