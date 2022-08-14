defmodule ExDuckSmartCellTest do
  use ExUnit.Case, async: true

  import Kino.Test

  setup :configure_livebook_bridge

  test "initial source uses the defaults" do
    {_kino, source} = start_smart_cell!(ExDuckSmartCell, %{})

    assert source == """
           api_result = ExDuck.query!(\"\")
           answer = api_result |> ExDuck.understand()
           answer |> ExDuck.to_markdown() |> Kino.Markdown.new()\
           """
  end

  test "uses topic and variable from attrs" do
    attrs = %{
      "api_result_variable" => "query_result",
      "answer_variable" => "answer",
      "topic" => "Elixir Language"
    }

    {_kino, source} = start_smart_cell!(ExDuckSmartCell, attrs)

    assert source ==
             """
             query_result = ExDuck.query!(\"Elixir Language\")
             answer = query_result |> ExDuck.understand()
             answer |> ExDuck.to_markdown() |> Kino.Markdown.new()\
             """
  end
end
