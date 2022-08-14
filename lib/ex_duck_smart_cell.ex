defmodule ExDuckSmartCell do
  @moduledoc false

  use Kino.JS, assets_path: "lib/assets/ex_duck_smart_cell_with_variables"
  use Kino.JS.Live
  use Kino.SmartCell, name: "ExDuck with variables"

  @impl true
  def init(attrs, ctx) do
    fields = %{
      "answer_variable" => Kino.SmartCell.prefixed_var_name("answer", attrs["answer_variable"]),
      "api_result_variable" =>
        Kino.SmartCell.prefixed_var_name("api_result", attrs["api_result_variable"]),
      "topic" => attrs["topic"] || ""
    }

    {:ok, assign(ctx, fields: fields)}
  end

  @impl true
  def handle_connect(ctx) do
    payload = %{
      fields: ctx.assigns.fields
    }

    {:ok, payload, ctx}
  end

  @impl true
  def to_attrs(%{assigns: %{fields: fields}}) do
    Map.take(fields, ["topic", "answer_variable", "api_result_variable"])
  end

  @impl true
  def to_source(attrs) do
    quote do
      unquote(quoted_var(attrs["api_result_variable"])) = ExDuck.query!(unquote(attrs["topic"]))

      unquote(quoted_var(attrs["answer_variable"])) =
        unquote(quoted_var(attrs["api_result_variable"]))
        |> ExDuck.understand()

      unquote(quoted_var(attrs["answer_variable"]))
      |> ExDuck.to_markdown()
      |> Kino.Markdown.new()
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  @impl true
  def handle_event("update_field", %{"field" => field, "value" => value}, ctx) do
    updated_fields = to_updates(ctx.assigns.fields, field, value)
    ctx = update(ctx, :fields, &Map.merge(&1, updated_fields))
    broadcast_event(ctx, "update", %{"fields" => updated_fields})
    {:noreply, ctx}
  end

  defp to_updates(fields, "answer_variable", value) do
    if Kino.SmartCell.valid_variable_name?(value) do
      %{"answer_variable" => value}
    else
      %{"answer_variable" => fields["answer_variable"]}
    end
  end

  defp to_updates(fields, "api_result_variable", value) do
    if Kino.SmartCell.valid_variable_name?(value) do
      %{"api_result_variable" => value}
    else
      %{"api_result_variable" => fields["api_result_variable"]}
    end
  end

  defp to_updates(_fields, field, value), do: %{field => value}

  defp quoted_var(string), do: {String.to_atom(string), [], nil}
end
